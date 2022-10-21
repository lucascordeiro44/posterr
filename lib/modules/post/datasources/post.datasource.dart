import 'package:hive_flutter/hive_flutter.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';

abstract class IPostDatasource {
  Future<List<Post>> getPosts();
  Future<bool> createPost(Post post);
}

class PostDatasource implements IPostDatasource {
  Box<Post> postsBox;
  PostDatasource(this.postsBox);

  @override
  Future<List<Post>> getPosts() async {
    try {
      await Future.delayed(const Duration(microseconds: 500));
      List<Post> posts = [];
      final result = postsBox.values;
      posts.addAll(result);
      return posts;
    } catch (e) {
      throw PostException(message: e.toString());
    }
  }

  @override
  Future<bool> createPost(Post post) async {
    try {
      postsBox.add(post);
      return true;
    } catch (e) {
      throw PostException(message: e.toString());
    }
  }
}
