import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posterr/core/models/content_item.dart';
import 'package:posterr/core/stores/auth_store.dart';
import 'package:posterr/core/stores/post.store.dart';
import 'package:posterr/core/widgets/card_quote_post.dart';
import 'package:posterr/core/widgets/card_repost_widget.dart';
import 'package:posterr/core/widgets/card_widget.dart';
import 'package:posterr/core/widgets/modal_bottom_sheet.widget.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/post/domain/entities/quote_post.dart';
import 'package:posterr/modules/post/domain/entities/repost.dart';
import 'package:quickalert/quickalert.dart';

class AppListPublicationsWidget extends StatefulWidget {
  final List<ContentItem> contents;
  bool shrinkWrap;
  AppListPublicationsWidget({
    required this.contents,
    this.shrinkWrap = false,
    super.key,
  });

  @override
  State<AppListPublicationsWidget> createState() =>
      _AppListPublicationsWidgetState();
}

class _AppListPublicationsWidgetState extends State<AppListPublicationsWidget> {
  List<ContentItem> get contents => widget.contents;
  final postStore = Modular.get<PostStore>();
  final authStore = Modular.get<AuthStore>();
  @override
  Widget build(BuildContext context) {
    return _listView();
  }

  _listView() {
    int listLength = contents.length;
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ListView.builder(
        shrinkWrap: widget.shrinkWrap,
        itemCount: listLength,
        itemBuilder: (context, index) {
          ContentItem contentItem = contents[index];
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
