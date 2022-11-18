import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posterr/core/stores/auth_store.dart';
import 'package:posterr/core/styles.dart';
import 'package:posterr/core/widgets/card_quote_post.dart';
import 'package:posterr/core/widgets/card_repost_widget.dart';
import 'package:posterr/core/widgets/card_widget.dart';
import 'package:posterr/core/models/content_item.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/post/domain/entities/quote_post.dart';
import 'package:posterr/modules/post/domain/entities/repost.dart';
import 'package:posterr/modules/post/presenter/states/post.state.dart';
import '../store/post.store.dart';

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
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: _listView(state));
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
          int reversedIndex = listLength - 1 - index;
          ContentItem contentItem = state.contents[reversedIndex];
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
          await postStore.createRepost(post);
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
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: postStore.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          isQuotePost ? 'Write a Quote Post' : 'Write a Post',
                          style: titleStyle,
                        ),
                      ),
                      _sendButton(post, isQuotePost),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: isQuotePost ? 1 : 4,
                      maxLines: isQuotePost ? 3 : 6,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: isQuotePost ? 'Add comment' : 'write a text',
                        fillColor: Colors.blueAccent.withOpacity(0.2),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      controller: postStore.textController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      maxLength: 777,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _sendButton(Post? post, bool isQuotePost) {
    return ElevatedButton(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Colors.blue)))),
      onPressed: () async {
        if (post != null && isQuotePost) {
          Navigator.pop(context);
          _onClickQuotePost(post);
        } else {
          Navigator.pop(context);
          _onClickSendPost();
        }
      },
      child: Text(isQuotePost ? 'SEND QUOTE' : "SEND POST",
          style: const TextStyle(fontSize: 14)),
    );
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

  Future<void> _onClickQuotePost(Post post) async {
    if (postStore.formKey.currentState!.validate()) {
      await postStore.createQuotePost(post, postStore.textController.text);
      setState(() {
        postStore.textController.clear();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    authStore.logout();
  }
}
