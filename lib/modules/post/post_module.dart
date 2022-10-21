import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:posterr/main_module.dart';
import 'package:posterr/modules/post/data/repositories/post.repository_impl.dart';
import 'package:posterr/modules/post/datasources/post.datasource.dart';
import 'package:posterr/modules/post/domain/repositories/post.repository.dart';
import 'package:posterr/modules/post/domain/usecases/create_post.usecase.dart';
import 'package:posterr/modules/post/domain/usecases/get_posts.usecase.dart';
import 'package:posterr/modules/post/presenter/home.page.dart';
import 'package:posterr/modules/post/presenter/store/post.store.dart';

class PostModule extends Module {
  @override
  List<Module> get imports => [
        MainModule(),
      ];

  @override
  List<Bind<Object>> get binds => [
        //Stores
        Bind.singleton((i) => PostStore(i(), i())),

        //repositorys
        Bind.factory<IPostsRepository>((i) => PostRepositoryImpl(i())),

        //usecases
        Bind.factory<ICreatePostUsecase>((i) => CreatePostUsecase(i())),
        Bind.factory<IGetPostsUsecase>((i) => GetPostsUsecase(i())),

        //datasources
        Bind.factory<IPostDatasource>((i) => PostDatasource(Hive.box('posts')))
      ];

  @override
  List<ModularRoute> get routes => [
        // App Initial Route
        ChildRoute('/home_page', child: (context, args) => const HomePage()),
        // Modules Routes
      ];
}
