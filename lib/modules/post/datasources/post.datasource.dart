import 'package:hive_flutter/hive_flutter.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';

abstract class IPostDatasource {
  Future<List<Post>> getPosts();
}

class PostDatasource implements IPostDatasource {
  Box<Post> postsBox;
  PostDatasource(this.postsBox);

  @override
  Future<List<Post>> getPosts() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      List<Post> posts = [];
      final result = postsBox.values;
      posts.addAll(result);
      return posts;
    } catch (e) {
      throw PostException(message: e.toString());
    }
  }
}
