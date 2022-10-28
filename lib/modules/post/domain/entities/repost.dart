import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';

class Repost extends HiveObject {
  final int id;
  final HiveList assignedToUser;
  final Post post;
  Repost({required this.id, required this.post, required this.assignedToUser});
}
