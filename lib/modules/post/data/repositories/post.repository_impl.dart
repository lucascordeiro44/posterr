import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/post/data/datasources/post.datasource.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/post/domain/repositories/post.repository.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';
import 'package:posterr/modules/user_profile/presenter/store/user_profile.store.dart';

class PostRepositoryImpl implements IPostsRepository {
  IPostDatasource datasource;
  UserProfileStore userStore;

  PostRepositoryImpl(this.datasource, this.userStore);

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    try {
      final result = await datasource.getPosts();
      return right(result);
    } catch (e) {
      return left(PostFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> createPost(String text) async {
    try {
      User user = userStore.getLoggedUser;
      final posts = await getPosts();
      final postLength = posts.fold(
          (l) => throw Exception('Fail when get posts to see the length'),
          (r) => r.length);
      //I could make some adapter here but in this case don´t need because the Hive already have a adapter generator.
      final post = Post(
          id: postLength.toString(),
          text: text,
          assignedToUser: HiveList(userStore.getUserBox),
          totalComments: 0);
      post.assignedToUser.add(user);
      final result = await datasource.createPost(post);
      return right(result);
    } catch (e) {
      return left(PostFailure(message: e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, bool>> createRepost(int postId) async {
  //   try {
  //     final post = await getPost(postId);
  //     post.fold((l) => null, (r) => r.reposts.);
  //     final repost =
  //     return right(r);
  //   } oncatch (e) {
  //     return left(PostFailure(message: e.toString()));
  //   }
  // }

  @override
  Future<Either<Failure, Post>> getPost(int postId) async {
    try {
      final post = await datasource.getPost(postId);
      if (post == null) {
        throw NullPostException();
      }
      return right(post);
    } on NullPostException catch (e) {
      return left(
          NullPostFailure(message: 'Not find any post with this postId'));
    } catch (e) {
      return left(PostFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> createRepost(Post post) {
    // TODO: implement createRepost
    throw UnimplementedError();
  }
}
