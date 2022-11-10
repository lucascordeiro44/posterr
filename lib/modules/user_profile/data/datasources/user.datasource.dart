import 'package:hive_flutter/hive_flutter.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/post/domain/entities/quote_post.dart';
import 'package:posterr/modules/post/domain/entities/repost.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';

abstract class IUserDatasource {
  Future<bool> setUsers(List<User> users);
  Future<User> getUser(String key);
  Future<List<User>> getUsers();
  Future<List<Post>> getUserPosts(User user);
  Future<List<Repost>> getUserReposts(User user);
  Future<List<QuotePost>> getUserQuotePosts(User user);
}

class UserDatasource implements IUserDatasource {
  Box<User> usersBox;
  Box<Post> postsBox;
  Box<Repost> repostsBox;
  Box<QuotePost> quotePostsBox;
  UserDatasource(
      {required this.usersBox,
      required this.postsBox,
      required this.repostsBox,
      required this.quotePostsBox});

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
  Future<List<Post>> getUserPosts(User user) async {
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

  @override
  Future<List<Repost>> getUserReposts(User user) async {
    try {
      final List<Repost> allReposts = repostsBox.values.toList();
      final List<Repost> userReposts = [];
      for (Repost repost in allReposts) {
        if (repost.assignedToUser.single.username == user.username) {
          userReposts.add(repost);
        }
      }
      return userReposts;
    } catch (e, s) {
      throw UserException(message: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<List<QuotePost>> getUserQuotePosts(User user) async {
    try {
      final List<QuotePost> allQuotePosts = quotePostsBox.values.toList();
      final List<QuotePost> userQuotePosts = [];
      for (QuotePost quotePost in allQuotePosts) {
        if (quotePost.assignedToUser.single.username == user.username) {
          userQuotePosts.add(quotePost);
        }
      }
      return userQuotePosts;
    } catch (e, s) {
      throw UserException(message: e.toString(), stackTrace: s);
    }
  }
}
