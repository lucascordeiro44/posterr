import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posterr/core/stores/auth_store.dart';
import 'package:posterr/core/styles.dart';
import 'package:posterr/core/widgets/card_quote_post.dart';
import 'package:posterr/core/widgets/card_repost_widget.dart';
import 'package:posterr/core/widgets/card_widget.dart';
import 'package:posterr/core/models/content_item.dart';
import 'package:posterr/core/widgets/list_publications.widget.dart';
import 'package:posterr/core/widgets/modal_bottom_sheet.widget.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/post/domain/entities/quote_post.dart';
import 'package:posterr/modules/post/domain/entities/repost.dart';
import 'package:posterr/modules/post/presenter/states/post.state.dart';
import 'package:quickalert/quickalert.dart';
import '../../../../core/stores/post.store.dart';

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
          child: AppListPublicationsWidget(contents: state.contents));
    }

    if (state is ErrorHomeContentState) {
      return Align(
        alignment: Alignment.center,
        child: Text(state.message, style: titleStyle),
      );
    }
  }

  _listView(SuccessHomeContentState state) {
    int listLength = state.contents.length;
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ListView.builder(
        controller: postStore.listController,
        itemCount: listLength,
        itemBuilder: (context, index) {
          // int reversedIndex = listLength - 1 - index;
          ContentItem contentItem = state.contents[index];
          if (contentItem.type == ContentType.post) {
            Post post = contentItem.content;
            return _postCard(post);
          } else if (contentItem.type == ContentType.repost) {
            Repost repost = contentItem.content;
            return _repostCard(repost);
          } else {
            QuotePost quote = contentItem.content;
            return _quotePostCard(quote);
          }
        },
      ),
    );
  }

  _postCard(Post post) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: AppCard(
        post: post,
        onClickRepost: () async {
          final result = await postStore.createRepost(post);
          if (!result) {
            QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'Limit exceeded',
                text: 'Your limit of posts per day has exceeded 5.');
          }
          postStore.scrollToTop();
        },
        onClickQuotePost: () async =>
            _showBottomSheet(context: context, isQuotePost: true, post: post),
      ),
    );
  }

  _repostCard(Repost repost) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: AppCardRepost(
        repost: repost,
        loggedUser: authStore.getLoggedUser,
      ),
    );
  }

  _quotePostCard(QuotePost quotePost) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: AppCardQuotePost(
        quotePost: quotePost,
      ),
    );
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
        postStore.textController.clear();
        postStore.scrollToTop();
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
      setState(() {
        postStore.textController.clear();
        postStore.scrollToTop();
      });
    }
  }
}
