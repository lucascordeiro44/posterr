import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posterr/core/shared/stores/auth_store.dart';
import 'package:posterr/initial_users.dart';
import 'package:posterr/modules/user_profile/domain/usecases/set_users.usecase.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final SetUsersUsecase setUsersUsecase = Modular.get();
  final AuthStore authStore = Modular.get();

  @override
  void initState() {
    super.initState();
    setUpInitialUsers();
  }

  setUpInitialUsers() async {
    if (authStore.getUserBox.isEmpty) {
      await setUsersUsecase.call(users);
    }
    await Future.delayed(const Duration(seconds: 2));
    Modular.to.pushNamedAndRemoveUntil("/choose_user", (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            color: Colors.redAccent[100],
          ),
          Container(
            color: Theme.of(context).primaryColor.withOpacity(0.6),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "Postter",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 2.0,
                        color: Colors.black,
                        offset: Offset(1.0, 1),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14),
                CircularProgressIndicator(
                  color: Colors.white,
                ),
                SizedBox(height: 8),
                Text(
                  'Loading data...',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
