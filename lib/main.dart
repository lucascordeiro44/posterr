import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:posterr/main_module.dart';
import 'package:posterr/mock.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';
import 'package:posterr/modules/user_profile/domain/usecases/set_users.usecase.dart';

void main() async {
  await setUpHive();
  runApp(ModularApp(module: MainModule(), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SetUsersUsecase setUsersUsecase = Modular.get();

  @override
  void initState() {
    super.initState();
    setUpInitialUsers();
  }

  setUpInitialUsers() async {
    await setUsersUsecase.call(users);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Posterr',
        theme: ThemeData(primarySwatch: Colors.red),
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate);
  }

  @override
  void dispose() {
    closeBoxes();
    super.dispose();
  }
}

setUpHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('users');
}

closeBoxes() {
  Hive.close();
}
