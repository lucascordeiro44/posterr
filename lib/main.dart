import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:posterr/app_module.dart';
import 'package:posterr/app_widget.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/post/domain/entities/quote_post.dart';
import 'package:posterr/modules/post/domain/entities/repost.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';

void main() async {
  await _initStorage();
  runApp(ModularApp(module: MainModule(), child: const AppWidget()));
}

_initStorage() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(PostAdapter());
  Hive.registerAdapter(RepostAdapter());
  Hive.registerAdapter(QuotePostAdapter());
  await Hive.openBox<User>('users');
  await Hive.openBox<Post>('posts');
  await Hive.openBox<Repost>('reposts');
  await Hive.openBox<QuotePost>('quotePosts');
}
