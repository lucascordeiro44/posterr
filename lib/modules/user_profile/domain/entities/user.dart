// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive/hive.dart';
import 'package:posterr/core/error/formats.dart';


part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final DateTime joinedDate;
  @HiveField(2)
  final String fullName;
  // @HiveField(3)
  // final HiveList<Post>? posts;

  String get dateJoined => formatDate(joinedDate);

  User({
    required this.username,
    required this.fullName,
    required this.joinedDate,
  });
}
