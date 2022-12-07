import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posterr/core/shared/stores/auth_store.dart';
import 'package:posterr/modules/post/data/datasources/post.datasource.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/post/domain/entities/quote_post.dart';
import 'package:posterr/modules/post/domain/entities/repost.dart';
import 'package:posterr/modules/post/domain/repositories/post.repository.dart';
import 'package:posterr/modules/user_profile/data/datasources/user.datasource.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';
import 'package:posterr/modules/user_profile/domain/repositories/user_profile.repository.dart';

final testUserFormatDate = User(
    fullName: 'Lucas Cordeiro',
    username: 'lucascordeiro',
    lastPutlicationEventDate: DateTime(2022, 11, 13),
    userPublishCounter: 0,
    photo: 'https://picsum.photos/150/150',
    joinedDate: DateTime(2022, 10, 18));

final post = Post(
  postDate: DateTime.now(),
  text: 'Mock Post text',
  assignedToUser: HiveList(Modular.get<AuthStore>().getUserBox),
);

// final repost = Repost(id: 1, post: post, assignedToUse: user);

final user = User(
    fullName: 'Lucas Cordeiro',
    username: 'lucascordeiro',
    lastPutlicationEventDate: DateTime(2022, 11, 13),
    userPublishCounter: 0,
    photo: 'https://picsum.photos/150/150',
    joinedDate: DateTime.now());

final List<User> users = [
  User(
      fullName: 'Lucas Cordeiro',
      username: 'lucascordeiro',
      photo: 'https://picsum.photos/135/135',
      lastPutlicationEventDate: DateTime(2022, 11, 13),
      userPublishCounter: 0,
      joinedDate: DateTime.now()),
  User(
      fullName: 'Maria Cordeiro',
      username: 'mariacordeiro',
      photo: 'https://picsum.photos/160/160',
      lastPutlicationEventDate: DateTime(2022, 11, 13),
      userPublishCounter: 0,
      joinedDate: DateTime.now()),
  User(
      fullName: 'Jose Cordeiro',
      username: 'josecordeiro',
      photo: 'https://picsum.photos/132/132',
      lastPutlicationEventDate: DateTime(2022, 11, 13),
      userPublishCounter: 0,
      joinedDate: DateTime.now()),
  User(
      fullName: 'Juliano Cordeiro',
      username: 'julianocordeiro',
      photo: 'https://picsum.photos/140/140',
      lastPutlicationEventDate: DateTime(2022, 11, 13),
      userPublishCounter: 0,
      joinedDate: DateTime.now()),
];

class MockUserDatasource extends Mock implements IUserDatasource {}

class MockUserProfileRepository extends Mock implements IUserProfileRepository {
}

class MockPostsRepository extends Mock implements IPostsRepository {}

class MockPostDatasource extends Mock implements PostDatasource {}

class MockHivePost extends Mock implements Box<Post> {}

class MockHive extends Mock implements Box<User> {}

class PostMockHive extends Mock implements Box<Post> {}

class RepostMockHive extends Mock implements Box<Repost> {}

class QuotePostMockHive extends Mock implements Box<QuotePost> {}
