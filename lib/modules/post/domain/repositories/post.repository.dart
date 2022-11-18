import 'package:dartz/dartz.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/core/models/content_item.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';

abstract class IPostsRepository {
  Future<Either<Failure, bool>> createPost(String title, String text);
  Future<Either<Failure, bool>> createRepost(Post post);
  Future<Either<Failure, bool>> createQuotePost(Post post, String comment);
  Future<Either<Failure, List<ContentItem>>> getAllHomeContent();
  Future<void> incrementPublicationCounter();
}
