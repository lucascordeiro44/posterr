import 'package:hive/hive.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';

part 'quote_post.g.dart';

@HiveType(typeId: 4)
class QuotePost extends HiveObject {
  @HiveField(0)
  String quotePostDate;
  @HiveField(1)
  HiveList<User> assignedToUser;
  @HiveField(2)
  String comment;
  @HiveField(3)
  HiveList<Post> relatedPost;

  QuotePost(
      {required this.quotePostDate,
      required this.assignedToUser,
      required this.comment,
      required this.relatedPost});
}
