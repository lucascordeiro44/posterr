import 'package:posterr/modules/user_profile/domain/entities/user.dart';

final List<User> users = [
  User(
    fullName: 'Lucas Cordeiro',
    username: 'lucascordeiro',
    joinedDate: DateTime.now(),
  ),
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

final User user = User(
    fullName: 'Lucas Cordeiro',
    username: 'lucascordeiro',
    joinedDate: DateTime.now());
