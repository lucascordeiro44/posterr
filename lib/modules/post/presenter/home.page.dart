import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posterr/core/stores/auth_store.dart';
import 'package:posterr/core/styles.dart';
import 'package:posterr/core/widgets/card_repost_widget.dart';
import 'package:posterr/core/widgets/card_widget.dart';
import 'package:posterr/core/models/content_item.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/post/domain/entities/repost.dart';
import 'package:posterr/modules/post/presenter/states/post.state.dart';
import 'store/post.store.dart';

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
      body: _body(context),
      floatingActionButton: FloatingActionButton(
          isExtended: true,
          onPressed: () => _configurandoModalBottomSheet(context),
          child: const Icon(Icons.add)),
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
      return _listView(state);
    }

    if (state is ErrorHomeContentState) {
      return Align(
        alignment: Alignment.center,
        child: Text(state.message, style: titleStyle),
      );
    }
  }

  _listView(SuccessHomeContentState state) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ListView.builder(
        itemCount: state.contents.length,
        itemBuilder: (context, index) {
          ContentItem contentItem = state.contents[index];
          if (contentItem.type == ContentType.post) {
            Post post = contentItem.content;
            return _postCard(post);
          } else if (contentItem.type == ContentType.repost) {
            Repost repost = contentItem.content;
            return _repostCard(repost);
          } else {
            return const Text('Quote Post');
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
        onClickRepost: () async => await postStore.createRepost(post),
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

  void _configurandoModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: postStore.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 4,
                      maxLines: 6,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueAccent.withOpacity(0.5),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      controller: postStore.textController,
                      autofocus: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      maxLength: 777,
                    ),
                  ),
                  _sendButton()
                ],
              ),
            ),
          );
        });
  }

  _sendButton() {
    return MaterialButton(
        child: Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: const [
            Text('Send Post'),
            SizedBox(
              width: 8,
            ),
            Icon(
              Icons.send,
              color: Colors.redAccent,
              size: 28,
            ),
          ],
        ),
        onPressed: () async {
          _onClickSendPost().then((_) => Navigator.pop(context));
        });
  }

  Future<void> _onClickSendPost() async {
    if (postStore.formKey.currentState!.validate()) {
      await postStore.createPost(
          postStore.titleController.text, postStore.textController.text);
      setState(() {
        postStore.textController.clear();
      });
    }
  }
}
