import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:posterr/core/pages/splash_screen.page.dart';
import 'package:posterr/modules/post/domain/entities/quote_post.dart';
import 'package:posterr/modules/post/domain/entities/repost.dart';
import 'package:posterr/modules/user_profile/presenter/pages/user_profile.page.dart';
import 'package:posterr/modules/user_profile/presenter/store/choose_users.store.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/post/post_module.dart';
import 'package:posterr/modules/user_profile/data/datasources/user.datasource.dart';
import 'package:posterr/modules/user_profile/data/repositories/user_profile.repository_impl.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';
import 'package:posterr/modules/user_profile/domain/repositories/user_profile.repository.dart';
import 'package:posterr/modules/user_profile/domain/usecases/get_current_user.usecase.dart';
import 'package:posterr/modules/user_profile/domain/usecases/get_user_contents.usecase.dart';
import 'package:posterr/modules/user_profile/domain/usecases/get_users.usecase.dart';
import 'package:posterr/modules/user_profile/domain/usecases/set_users.usecase.dart';
import 'package:posterr/core/stores/auth_store.dart';
import 'package:posterr/modules/user_profile/presenter/pages/choose_user.page.dart';
import 'package:posterr/modules/user_profile/presenter/store/user_profile.store.dart';

/// It's the main App module. Each module should have your binds (dependencys) and routes
class MainModule extends Module {
  // Dependency injection
  @override
  List<Bind<Object>> get binds => [
        //Box user
        Bind.lazySingleton<Box<User>>((i) => Hive.box('users')),
        //Box Posts
        Bind.lazySingleton<Box<Post>>((i) => Hive.box('posts')),
        //Box Repost
        Bind.lazySingleton<Box<Repost>>((i) => Hive.box('reposts')),
        //Box Quote Post
        Bind.lazySingleton<Box<QuotePost>>((i) => Hive.box('quotePosts')),

        //store
        Bind.lazySingleton((i) => AuthStore(i())),
        Bind.lazySingleton((i) => ChooseUserStore(i())),
         Bind.lazySingleton((i) => UserProfileStore(i(), i())),

        //datasources
        Bind.lazySingleton<IUserDatasource>(
            (i) => UserDatasource(usersBox: i(), postsBox: i(),repostsBox: i(), quotePostsBox: i())),

        //Repositorys
        Bind.lazySingleton<IUserProfileRepository>(
            (i) => UserProfileRepositoryImpl(datasource: i())),

        //UseCases
        Bind.lazySingleton<IGetCurrentUserUsecase>(
            (i) => GetCurrentUserUsecase(i())),
        Bind.lazySingleton<IGetUsersUsecase>((i) => GetUsersUsecase(i())),
        Bind.lazySingleton<IGetUserContentsUsecase>(
            (i) => GetUserContentsUsecase(i())),
        Bind.lazySingleton<ISetUsersUsecase>((i) => SetUsersUsecase(i())),
      ];
  // Main Routes: All the App Mobules routes
  @override
  List<ModularRoute> get routes => [
        // App Initial Route
        ChildRoute('/', child: (context, args) => const SplashScreenPage()),
        ChildRoute('/choose_user',
            child: (context, args) => const ChooseUserPage()),
        ChildRoute('/user', child: (context, args) => const UserProfilePage()),
        ModuleRoute('/post', module: PostModule())
        // Modules Routes
      ];
}
