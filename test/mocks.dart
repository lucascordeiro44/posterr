import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posterr/core/stores/auth_store.dart';
import 'package:posterr/core/utils/utils.dart';
import 'package:posterr/modules/post/data/datasources/post.datasource.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/post/domain/repositories/post.repository.dart';
import 'package:posterr/modules/user_profile/data/datasources/user.datasource.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';
import 'package:posterr/modules/user_profile/domain/repositories/user_profile.repository.dart';

final testUserFormatDate = User(
    fullName: 'Lucas Cordeiro',
    username: 'lucascordeiro',
    photo: 'https://picsum.photos/150/150',
    joinedDate: DateTime(2022, 10, 18));

final post = Post(
  postDate: formatPostDate(DateTime.now()),
  text: 'Mock Post text',
  assignedToUser: HiveList(Modular.get<AuthStore>().getUserBox),
);

// final repost = Repost(id: 1, post: post, assignedToUse: user);

final user = User(
    fullName: 'Lucas Cordeiro',
    username: 'lucascordeiro',
    photo: 'https://picsum.photos/150/150',
    joinedDate: DateTime.now());

final List<User> users = [
  User(
      fullName: 'Lucas Cordeiro',
      username: 'lucascordeiro',
      photo: 'https://picsum.photos/135/135',
      joinedDate: DateTime.now()),
  User(
      fullName: 'Maria Cordeiro',
      username: 'mariacordeiro',
      photo: 'https://picsum.photos/160/160',
      joinedDate: DateTime.now()),
  User(
      fullName: 'Jose Cordeiro',
      username: 'josecordeiro',
      photo: 'https://picsum.photos/132/132',
      joinedDate: DateTime.now()),
  User(
      fullName: 'Juliano Cordeiro',
      username: 'julianocordeiro',
      photo: 'https://picsum.photos/140/140',
      joinedDate: DateTime.now()),
];

class MockUserDatasource extends Mock implements IUserDatasource {}

class MockUserProfileRepository extends Mock implements IUserProfileRepository {
}

class MockPostsRepository extends Mock implements IPostsRepository {}

class MockPostDatasource extends Mock implements PostDatasource {}

class MockHivePost extends Mock implements Box<Post> {}
