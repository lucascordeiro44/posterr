import 'package:hive_flutter/hive_flutter.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';

abstract class IUserDatasource {
  Future<dynamic> getUser();
}

class UserDatasource implements IUserDatasource {
    UserDatasource();
  @override
  Future<dynamic> getUser() async {
    final response = await Hive.openBox<User>('users');
    throw UnimplementedError();
  }
}