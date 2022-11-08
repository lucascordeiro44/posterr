import 'package:hive/hive.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';

part 'repost.g.dart';

@HiveType(typeId: 3)
class Repost extends HiveObject {
  @HiveField(0)
  final String repostDate;
  @HiveField(1)
  final HiveList<User> assignedToUser;
  @HiveField(2)
  final HiveList<Post> relatedPost;
  Repost(
      {required this.repostDate,
      required this.assignedToUser,
      required this.relatedPost});
}
