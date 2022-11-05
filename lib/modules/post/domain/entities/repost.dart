
import 'package:hive/hive.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';


class Repost extends HiveObject {
  final int id;
  final HiveList assignedToUser;
  final Post post;
  Repost({required this.id, required this.post, required this.assignedToUser});
}
