import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/post/data/datasources/post.datasource.dart';
import 'package:posterr/core/models/content_item.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/post/domain/entities/quote_post.dart';
import 'package:posterr/modules/post/domain/entities/repost.dart';
import 'package:posterr/modules/post/domain/repositories/post.repository.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';
import 'package:posterr/core/stores/auth_store.dart';

class PostRepositoryImpl implements IPostsRepository {
  IPostDatasource datasource;
  AuthStore userStore;
  Box<Post> postBox;

  PostRepositoryImpl(this.datasource, this.userStore, this.postBox);

  User get _loggedUser => userStore.getLoggedUser;

  @override
  Future<Either<Failure, bool>> createPost(String title, String text) async {
    try {
      final post = Post(
        postDate: DateTime.now(),
        text: text,
        assignedToUser: HiveList(userStore.getUserBox),
      );
      post.assignedToUser.add(_loggedUser);
      final result = await datasource.createPost(post);
      incrementPublicationCounter();
      return right(result);
    } catch (e) {
      return left(PostFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> createRepost(Post post) async {
    try {
      final repost = Repost(
          repostDate: DateTime.now(),
          assignedToUser: HiveList(userStore.getUserBox),
          relatedPost: HiveList(postBox));
      repost.assignedToUser.add(_loggedUser);
      repost.relatedPost.add(post);
      final result = await datasource.createRepost(repost);
      incrementPublicationCounter();
      return right(result);
    } on RepostException catch (e) {
      return left(RepostFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<ContentItem>>> getAllHomeContent() async {
    try {
      final posts = await datasource.getPosts();
      final reposts = await datasource.getReposts();
      final quotePosts = await datasource.getQuotePosts();
      List<ContentItem> result = [];
      if (posts.isNotEmpty) {
        final postContent = posts
            .map<ContentItem<Post>>(
                (e) => ContentItem<Post>(content: e, type: ContentType.post))
            .toList();
        result.addAll(postContent);
      }
      if (reposts.isNotEmpty) {
        final repostContent = reposts
            .map<ContentItem<Repost>>((e) =>
                ContentItem<Repost>(content: e, type: ContentType.repost))
            .toList();
        result.addAll(repostContent);
      }
      if (quotePosts.isNotEmpty) {
        final quotePostsContent = quotePosts
            .map<ContentItem<QuotePost>>((e) =>
                ContentItem<QuotePost>(content: e, type: ContentType.quotePost))
            .toList();
        result.addAll(quotePostsContent);
      }
      return right(result);
    } catch (e) {
      return left(HomeContentFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> createQuotePost(
      Post post, String comment) async {
    try {
      final quotePost = QuotePost(
          comment: comment,
          quotePostDate: DateTime.now(),
          assignedToUser: HiveList(userStore.getUserBox),
          relatedPost: HiveList(postBox));
      quotePost.assignedToUser.add(_loggedUser);
      quotePost.relatedPost.add(post);
      final result = await datasource.createQuotePost(quotePost);
      incrementPublicationCounter();
      return right(result);
    } on QuotePostException catch (e) {
      return left(QuotePostFailure(message: e.message));
    }
  }

  @override
  Future<void> incrementPublicationCounter() async {
    _loggedUser.userPublishCounter++;
    _loggedUser.lastPutlicationEventDate = DateTime.now();
    userStore.getUserBox.put(_loggedUser.key, _loggedUser);
  }
}
