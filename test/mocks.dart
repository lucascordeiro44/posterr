import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posterr/modules/post/data/datasources/post.datasource.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/post/domain/repositories/post.repository.dart';
import 'package:posterr/modules/user_profile/data/datasources/user.datasource.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';
import 'package:posterr/modules/user_profile/domain/repositories/user_profile.repository.dart';

final testUserFormatDate = User(
    fullName: 'Lucas Cordeiro',
    username: 'lucascordeiro',
    joinedDate: DateTime(2022, 10, 18));

final post = Post(
  id: '1',
  text: 'Mock Post test',
  totalComments: 0,
  user: user,
);

final user = User(
    fullName: 'Lucas Cordeiro',
    username: 'lucascordeiro',
    joinedDate: DateTime.now());

final List<User> users = [
  User(
      fullName: 'Lucas Cordeiro',
      username: 'lucascordeiro',
      joinedDate: DateTime.now()),
  User(
      fullName: 'Maria Cordeiro',
      username: 'mariacordeiro',
      joinedDate: DateTime.now()),
  User(
      fullName: 'Jose Cordeiro',
      username: 'josecordeiro',
      joinedDate: DateTime.now()),
  User(
      fullName: 'Juliano Cordeiro',
      username: 'julianocordeiro',
      joinedDate: DateTime.now()),
];

class MockUserDatasource extends Mock implements IUserDatasource {}

class MockUserProfileRepository extends Mock implements IUserProfileRepository {
}

class MockPostsRepository extends Mock implements IPostsRepository {}

class MockPostDatasource extends Mock implements PostDatasource {}

class MockHivePost extends Mock implements Box<Post> {}
