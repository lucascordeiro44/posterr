import 'package:posterr/core/models/content_item.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/post/domain/entities/quote_post.dart';
import 'package:posterr/modules/post/domain/entities/repost.dart';
import 'package:posterr/modules/user_profile/data/datasources/user.datasource.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:posterr/modules/user_profile/domain/repositories/user_profile.repository.dart';

class UserProfileRepositoryImpl implements IUserProfileRepository {
  final IUserDatasource datasource;

  UserProfileRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, User>> getCurrentUser(String key) async {
    try {
      final user = await datasource.getUser(key);
      return right(user);
    } on UserException catch (e, s) {
      return left(GetUserException(message: e.message, stackTrace: s));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    try {
      final List<User> user = await datasource.getUsers();
      return right(user);
    } on UserException catch (e, s) {
      return left(GetUserException(message: e.message, stackTrace: s));
    }
  }

  @override
  Future<Either<Failure, bool>> setUsers(List<User> users) async {
    try {
      final result = await datasource.setUsers(users);
      return right(result);
    } on UserException catch (e, s) {
      return left(SetUserException(message: e.message, stackTrace: s));
    }
  }

  @override
  Future<Either<Failure, List<ContentItem>>> getUserContents(User user) async {
    try {
      final posts = await datasource.getUserPosts(user);
      final reposts = await datasource.getUserReposts(user);
      final quotePosts = await datasource.getUserQuotePosts(user);
      List<ContentItem> result = [];
      if (posts.isNotEmpty) {
        final postContent = posts
            .map<ContentItem<Post>>((e) => ContentItem<Post>(
                content: e, type: ContentType.post, publishDate: e.postDate))
            .toList();
        result.addAll(postContent);
      }
      if (reposts.isNotEmpty) {
        final repostContent = reposts
            .map<ContentItem<Repost>>((e) => ContentItem<Repost>(
                content: e,
                type: ContentType.repost,
                publishDate: e.repostDate))
            .toList();
        result.addAll(repostContent);
      }

      if (quotePosts.isNotEmpty) {
        final quotePostsContent = quotePosts
            .map<ContentItem<QuotePost>>((e) => ContentItem<QuotePost>(
                content: e,
                type: ContentType.quotePost,
                publishDate: e.quotePostDate))
            .toList();
        result.addAll(quotePostsContent);
      }
      result.sort(
        (a, b) {
          return -a.publishDate.compareTo(b.publishDate);
        },
      );
      return right(result);
    } on UserException catch (e, s) {
      return left(GetPostsException(message: e.message, stackTrace: s));
    }
  }
}
