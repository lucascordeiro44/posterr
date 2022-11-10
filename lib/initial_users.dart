import 'package:posterr/modules/user_profile/domain/entities/user.dart';

final user = User(
    fullName: 'Lucas Cordeiro',
    username: 'lucascordeiro',
    photo: 'https://picsum.photos/150/150',
    joinedDate: DateTime.now());

final List<User> users = [
  User(
      fullName: 'Lucas Cordeiro',
      username: 'lucascordeiro',
      photo: 'https://picsum.photos/150/150',
      joinedDate: DateTime.now()),
  User(
      fullName: 'Maria Cordeiro',
      username: 'mariacordeiro',
      photo: 'https://picsum.photos/160/160',
      joinedDate: DateTime.now()),
  User(
      fullName: 'Jose Cordeiro',
      username: 'josecordeiro',
      photo: 'https://picsum.photos/160/165',
      joinedDate: DateTime.now()),
  User(
      fullName: 'Juliano Cordeiro',
      username: 'julianocordeiro',
      photo: 'https://picsum.photos/140/140',
      joinedDate: DateTime.now()),
];
