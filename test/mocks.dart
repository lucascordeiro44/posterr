import 'package:mocktail/mocktail.dart';
import 'package:posterr/modules/user_profile/data/datasources/user.datasource.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';
import 'package:posterr/modules/user_profile/domain/repositories/user_profile.repository.dart';

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
];

class MockUserDatasource extends Mock implements IUserDatasource {}

class MockUserProfileRepository extends Mock implements IUserProfileRepository {
}
