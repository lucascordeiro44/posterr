import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:posterr/app_module.dart';
import 'package:posterr/modules/post/data/repositories/post.repository_impl.dart';
import 'package:posterr/modules/post/data/datasources/post.datasource.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/post/domain/entities/quote_post.dart';
import 'package:posterr/modules/post/domain/entities/repost.dart';
import 'package:posterr/modules/post/domain/repositories/post.repository.dart';
import 'package:posterr/modules/post/domain/usecases/create_post.usecase.dart';
import 'package:posterr/modules/post/domain/usecases/create_quote_post.usecase.dart';
import 'package:posterr/modules/post/domain/usecases/create_repost.usecase.dart';
import 'package:posterr/modules/post/domain/usecases/get_home_content.usecase.dart';
import 'package:posterr/modules/post/presenter/pages/home.page.dart';
import 'package:posterr/modules/post/presenter/store/post.store.dart';

class PostModule extends Module {
  @override
  List<Module> get imports => [
        MainModule(),
      ];

  @override
  List<Bind<Object>> get binds => [
        //Box
        Bind.lazySingleton<Box<Post>>((i) => Hive.box('posts')),
        Bind.lazySingleton<Box<Repost>>((i) => Hive.box('reposts')),
        Bind.lazySingleton<Box<QuotePost>>((i) => Hive.box('quotePosts')),
        //Stores
        Bind.lazySingleton((i) => PostStore(i(), i(), i(), i(), i())),
        //repositorys
        Bind.lazySingleton<IPostsRepository>(
            (i) => PostRepositoryImpl(i(), i(), i())),
        //usecases
        Bind.lazySingleton<ICreatePostUsecase>((i) => CreatePostUsecase(i())),
        Bind.lazySingleton<IGetHomeContentUsecase>(
            (i) => GetHomeContentUsecase(i())),
        Bind.lazySingleton<ICreateRepostUsecase>(
            (i) => CreateRepostUsecase(i())),
        Bind.lazySingleton<ICreateQuotePostUsecase>(
            (i) => CreateQuotePostUsecase(i())),
        //datasources
        Bind.lazySingleton<IPostDatasource>(
            (i) => PostDatasource(i(), i(), i()))
      ];

  @override
  List<ModularRoute> get routes => [
        // App Initial Route
        ChildRoute('/home', child: (context, args) => const HomePage()),
        // Modules Routes
      ];
}
