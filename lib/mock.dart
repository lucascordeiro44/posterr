// final GetUsersUsecase getUsersUsecase = Modular.get();
// final GetCurrentUserUsecase getCurrentUserUsecase = Modular.get();
// final SetUsersUsecase setUsersUsecase = Modular.get();
// late List<User> listUsers;

// test() async {
//   await setUsersUsecase.call(users);
//   final result = await getUsersUsecase.call();
//   final result2 = await getCurrentUserUsecase.call('lucascordeiro');
//   final newState = result.fold((l) {
//     print(l.toString());
//   }, (r) {
//     listUsers = r;
//     print("User: " + r.first.fullName);
//   });

//   result2.fold((l) {
//     print(l.toString());
//   }, (r) {
//     print("User: " + r.fullName);
//   });
// }

import 'package:posterr/modules/user_profile/domain/entities/user.dart';

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
