import 'package:hive_flutter/hive_flutter.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';

abstract class IUserDatasource {
  Future<bool> setUsers(List<User> users);
  Future<User> getUser(String key);
  Future<List<User>> getUsers();
  Future<List<Post>> getPostsFromLoggedUser(User user);
}

class UserDatasource implements IUserDatasource {
  Box<User> usersBox;
  Box<Post> postsBox;
  UserDatasource({required this.usersBox, required this.postsBox});

  @override
  Future<bool> setUsers(List<User> users) async {
    try {
      for (var user in users) {
        usersBox.put(user.username, user);
      }
      return true;
    } catch (e, s) {
      throw UserException(message: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<List<User>> getUsers() async {
    try {
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
      return usersBox.get(key)!;
    } catch (e, s) {
      throw UserException(message: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<List<Post>> getPostsFromLoggedUser(User user) async {
    try {
      final List<Post> allPosts = postsBox.values.toList();
      final List<Post> userPosts = [];
      for (Post post in allPosts) {
        if (post.assignedToUser.single.username == user.username) {
          userPosts.add(post);
        }
      }
      return userPosts;
    } catch (e, s) {
      throw UserException(message: e.toString(), stackTrace: s);
    }
  }
}
