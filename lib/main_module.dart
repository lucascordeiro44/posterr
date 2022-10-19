import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:posterr/modules/post/presenter/home.page.dart';
import 'package:posterr/modules/user_profile/data/datasources/user.datasource.dart';
import 'package:posterr/modules/user_profile/data/repositories/user_profile.repository_impl.dart';
import 'package:posterr/modules/user_profile/domain/repositories/user_profile.repository.dart';
import 'package:posterr/modules/user_profile/domain/usecases/get_current_user.usecase.dart';
import 'package:posterr/modules/user_profile/domain/usecases/get_users.usecase.dart';
import 'package:posterr/modules/user_profile/domain/usecases/set_users.usecase.dart';
import 'package:posterr/modules/user_profile/presenter/user_profile.page.dart';

/// It's the main App module. Each module should have your binds (dependencys) and routes
class MainModule extends Module {
  // Dependency injection
  @override
  List<Bind<Object>> get binds => [
        //datasources
        Bind.singleton<IUserDatasource>(
            (i) => UserDatasource(box: Hive.box('users'))),

        //Repositorys
        Bind.factory<IUserProfileRepository>(
            (i) => UserProfileRepositoryImpl(datasource: i())),

        //UseCases
        Bind.factory<IGetCurrentUserUsecase>((i) => GetCurrentUserUsecase(i())),
        Bind.factory<IGetUsersUsecase>((i) => GetUsersUsecase(i())),
        Bind.factory<ISetUsersUsecase>((i) => SetUsersUsecase(i())),
      ];

  // Main Routes: All the App Mobules routes
  @override
  List<ModularRoute> get routes => [
        // App Initial Route
        ChildRoute('/', child: (context, args) => const UserProfilePage()),
        // Modules Routes
      ];
}
