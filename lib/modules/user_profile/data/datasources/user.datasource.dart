import 'package:hive_flutter/hive_flutter.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';

abstract class IUserDatasource {
  Future<bool> setUsers(List<User> users);
  Future<User> getUser(String key);
  Future<List<User>> getUsers();
}

class UserDatasource implements IUserDatasource {
  Box<User> usersBox;
  UserDatasource({required this.usersBox});

  @override
  Future<bool> setUsers(List<User> users) async {
    try {
      for (var user in users) {
        usersBox.put(user.username, user);
      }
      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (e, s) {
      throw UserException(message: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<List<User>> getUsers() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      List<User> users = [];
      final result = usersBox.values;
      users.addAll(result);
      return users;
    } catch (e, s) {
      throw UserException(message: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<User> getUser(String key) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return usersBox.get(key)!;
    } catch (e, s) {
      throw UserException(message: e.toString(), stackTrace: s);
    }
  }
}
