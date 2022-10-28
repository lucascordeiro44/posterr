import 'package:hive/hive.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';

part 'post.g.dart';

@HiveType(typeId: 2)
class Post extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final HiveList<User> assignedToUser;
  @HiveField(2)
  final int totalComments;
  @HiveField(3)
  final String text;

  Post(
      {required this.id,
      required this.assignedToUser,
      required this.totalComments,
      required this.text});
}
