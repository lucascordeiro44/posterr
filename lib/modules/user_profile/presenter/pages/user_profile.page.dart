import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posterr/modules/user_profile/presenter/states/user_profile.state.dart';
import 'package:posterr/modules/user_profile/presenter/store/user_profile.store.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final UserProfileStore userProfileStore = Modular.get();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UserProfile')),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Modular.to.navigate('/post/home_page'),
          child: const Icon(Icons.add)),
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
      return ListView(
        shrinkWrap: true,
        children: [
          Text('Nome: ${state.user.fullName}',
              style: const TextStyle(fontSize: 18, color: Colors.black)),
          Text('Joined Date: ${state.user.joinedDate}',
              style: const TextStyle(fontSize: 14))
        ],
      );
    }

    if (state is ErrorUseProfileState) {
      return Container(
        color: Colors.white,
        child: Text(state.message),
      );
    }
  }
}
