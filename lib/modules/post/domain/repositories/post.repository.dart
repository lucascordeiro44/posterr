import 'package:dartz/dartz.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/post/data/datasources/post.datasource.dart';
import 'package:posterr/core/models/content_item.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/post/domain/entities/repost.dart';

abstract class IPostsRepository {
  // Future<Either<Failure, Post>> getPost(int postId);
  Future<Either<Failure, List<Post>>> getPosts();
  Future<Either<Failure, List<Repost>>> getReposts();
  Future<Either<Failure, bool>> createPost(String title, String text);
  Future<Either<Failure, bool>> createRepost(Post post);
  Future<Either<Failure, List<ContentItem>>> getAllHomeContent();
}
