import 'package:hive/hive.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';

part 'post.g.dart';

@HiveType(typeId: 2)
class Post extends HiveObject {
  @HiveField(0)
  final DateTime postDate;
  @HiveField(1)
  final String text;
  @HiveField(2)
  final HiveList<User> assignedToUser;

  Post({required this.assignedToUser,required this.postDate, required this.text});
}
