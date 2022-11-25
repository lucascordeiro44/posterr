import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posterr/core/shared/stores/auth_store.dart';
import 'package:posterr/core/styles.dart';
import 'package:posterr/core/shared/widgets/list_publications.widget.dart';
import 'package:posterr/core/shared/widgets/modal_bottom_sheet.widget.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/post/presenter/states/post.state.dart';
import 'package:quickalert/quickalert.dart';
import '../../../../core/shared/stores/post.store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PostStore postStore = Modular.get();
  final authStore = Modular.get<AuthStore>();
  @override
  void initState() {
    super.initState();
    postStore.fetchHomeContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posterr'), actions: [
        IconButton(
          onPressed: () => Modular.to.pushNamed('/user'),
          icon: const Icon(Icons.person),
          iconSize: 40,
        )
      ]),
      body: RefreshIndicator(
        onRefresh: () async => await postStore.fetchHomeContent(),
        child: _body(context),
      ),
      floatingActionButton: FloatingActionButton(
          isExtended: true,
          onPressed: () => _showBottomSheet(context: context),
          child: const Icon(Icons.create)),
    );
  }

  _body(BuildContext context) {
    final store = context.watch<PostStore>();
    final state = store.value;
    if (state is LoadingHomeContentState) {
      return const Align(
          alignment: Alignment.center, child: CircularProgressIndicator());
    }

    if (state is SuccessHomeContentState) {
      if (state.contents.isEmpty) {
        return const Align(
          alignment: Alignment.center,
          child: Text('There is not post yet!', style: titleStyle),
        );
      }
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: AppListPublicationsWidget(
            contents: state.contents,
            onFinishFetchCallback: postStore.fetchHomeContent,
          ));
    }

    if (state is ErrorHomeContentState) {
      return Align(
        alignment: Alignment.center,
        child: Text(state.message, style: titleStyle),
      );
    }
  }

  void _showBottomSheet({context, bool isQuotePost = false, Post? post}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
        builder: (BuildContext bc) {
          return AppModalBottomSheet(
              post: post,
              onClickSendPost: _onClickSendPost,
              onClickQuotePost: _onClickQuotePost,
              textController: postStore.textController,
              isQuotePost: isQuotePost,
              formKey: postStore.formKey);
        });
  }

  Future<void> _onClickSendPost() async {
    if (postStore.formKey.currentState!.validate()) {
      final result = await postStore.createPost(
          postStore.titleController.text, postStore.textController.text);
      if (!result) {
        QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Limit exceeded',
            text: 'Your limit of posts per day has exceeded 5.');
      }
      setState(() {
        postStore.fetchHomeContent();
        postStore.textController.clear();
      });
    }
  }

  Future<void> _onClickQuotePost(Post post) async {
    if (postStore.formKey.currentState!.validate()) {
      final result =
          await postStore.createQuotePost(post, postStore.textController.text);
      if (!result) {
        QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Limit exceeded',
            text: 'Your limit of posts per day has exceeded 5.');
      }
      setState(() async {
        postStore.fetchHomeContent();
        postStore.textController.clear();
      });
    }
  }
}
