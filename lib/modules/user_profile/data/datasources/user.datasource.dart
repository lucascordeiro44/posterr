import 'package:hive_flutter/hive_flutter.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';

abstract class IUserDatasource {
  Future<bool> setUsers(List<User> users);
  Future<User> getUser(String key);
}

class UserDatasource implements IUserDatasource {
  Box<User> box;
  UserDatasource({required this.box});

  @override
  Future<bool> setUsers(List<User> users) async {
    try {
      for (var user in users) {
        box.put(user.username, user);
      }
      Future.delayed(const Duration(seconds: 2));
      return true;
    } catch (e, s) {
      throw UserException(message: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<User> getUser(String key) async {
    try {
      Future.delayed(const Duration(seconds: 2));
      return box.get(key)!;
    } catch (e, s) {
      throw UserException(message: e.toString(), stackTrace: s);
    }
  }
}
