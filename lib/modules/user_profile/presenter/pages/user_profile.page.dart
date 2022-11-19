import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posterr/core/styles.dart';
import 'package:posterr/core/widgets/circle_avatar.dart';
import 'package:posterr/core/widgets/divider.dart';
import 'package:posterr/initial_users.dart';
import 'package:posterr/modules/user_profile/presenter/states/user_profile.state.dart';
import 'package:posterr/core/stores/auth_store.dart';
import 'package:posterr/modules/user_profile/presenter/store/user_profile.store.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
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
          _userContent(context, state),
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

  Stack _header(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: Colors.blueAccent.withOpacity(0.7),
          height: MediaQuery.of(context).size.height / 3.3,
        ),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppCircleAvatar(photo: authStore.getLoggedUser.photo),
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
        ],
      ),
    );
  }
}
