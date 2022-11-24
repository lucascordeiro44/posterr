import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posterr/core/models/content_item.dart';
import 'package:posterr/core/styles.dart';
import 'package:posterr/core/widgets/circle_avatar.dart';
import 'package:posterr/core/widgets/divider.dart';
import 'package:posterr/core/widgets/list_publications.widget.dart';
import 'package:posterr/core/widgets/modal_bottom_sheet.widget.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/core/stores/post.store.dart';
import 'package:posterr/modules/user_profile/presenter/states/user_profile.state.dart';
import 'package:posterr/core/stores/auth_store.dart';
import 'package:posterr/modules/user_profile/presenter/store/user_profile.store.dart';
import 'package:quickalert/quickalert.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final PostStore postStore = Modular.get();
  final AuthStore authStore = Modular.get();
  final UserProfileStore userProfileStore = Modular.get();
  @override
  void initState() {
    super.initState();
    userProfileStore.fetchUserContents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: _body(context),
      floatingActionButton: FloatingActionButton(
          isExtended: true,
          onPressed: () => _showBottomSheet(context: context),
          child: const Icon(Icons.create)),
    );
  }

  _body(BuildContext context) {
    final store = context.watch<UserProfileStore>();
    final state = store.value;

    if (state is LoadingUserProfileState) {
      return const CircularProgressIndicator();
    }

    if (state is SuccessUserProfileState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _header(context),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Feed', style: titleStyle),
                Text(
                    'Posts: ${userProfileStore.amountPosts}  Reposts: ${userProfileStore.amountReposts}  Quotes: ${userProfileStore.amountQuotedPosts}',
                    style: labelStyle)
              ],
            ),
          ),
          const AppDivider(
            color: Colors.black54,
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: AppListPublicationsWidget(
              contents: state.contents,
              shrinkWrap: true,
            ),
          )
        ],
      );
    }

    if (state is ErrorUserProfileState) {
      return Container(
        color: Colors.white,
        child: Text(state.message),
      );
    }
  }

  _header(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: Colors.blueAccent.withOpacity(0.7),
          height: MediaQuery.of(context).size.height / 4.5,
        ),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppCircleAvatar(
                photo: authStore.getLoggedUser.photo,
                height: 80,
                width: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 14, bottom: 8),
                      child: Text(authStore.getLoggedUser.fullName,
                          style: titleStyle),
                    ),
                    Text("Joined Date: ${authStore.getLoggedUser.dateJoined}",
                        style: subtitleStyle),
                  ]),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  _userContent(BuildContext context, SuccessUserProfileState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Feed', style: titleStyle),
              Text(
                  'Posts: ${userProfileStore.amountPosts}  Reposts: ${userProfileStore.amountReposts}  Quotes: ${userProfileStore.amountQuotedPosts}',
                  style: labelStyle)
            ],
          ),
          const AppDivider(
            color: Colors.black54,
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: AppListPublicationsWidget(
              contents: state.contents,
              shrinkWrap: true,
            ),
          )
        ],
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
        userProfileStore.fetchUserContents();
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
        userProfileStore.fetchUserContents();
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
