import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posterr/core/stores/auth_store.dart';
import 'package:posterr/modules/user_profile/presenter/states/choose_user.state.dart';
import 'package:posterr/modules/user_profile/presenter/store/choose_users.store.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';

class ChooseUserPage extends StatefulWidget {
  const ChooseUserPage({super.key});

  @override
  State<ChooseUserPage> createState() => _ChooseUserPageState();
}

class _ChooseUserPageState extends State<ChooseUserPage> {
  final store = Modular.get<ChooseUserStore>();
  final AuthStore authStore = Modular.get();

  @override
  void initState() {
    super.initState();
    store.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose User')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(child: _body(context)),
      ),
    );
  }

  _body(BuildContext context) {
    final store = context.watch<ChooseUserStore>();
    final state = store.value;
    if (state is LoadingChooseUserState) {
      return const CircularProgressIndicator();
    }

    if (state is SuccessChooseUserState) {
      if (state.users.isEmpty) {
        return const Text('Nothing Users ');
      }
      return ListView.separated(
        separatorBuilder: (context, index) => Container(
          color: Colors.black12,
          height: 2,
        ),
        shrinkWrap: true,
        itemCount: state.users.length,
        itemBuilder: (context, index) {
          User user = state.users[index];
          return Column(
            children: [
              MaterialButton(
                onPressed: () async {
                  await authStore.login(user.username);
                  Modular.to.pushNamed('/post/home');
                },
                child: Text(user.fullName),
              )
            ],
          );
        },
      );
    }

    if (state is ErrorChooseUserState) {
      return Container(
        color: Colors.white,
        child: Text(state.message),
      );
    }
  }
}
