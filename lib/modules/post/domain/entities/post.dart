import 'package:posterr/modules/post/domain/entities/comment.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';

class Post {
  final String id;
  final User user;
  final List<Comment> comments;
  final int totalComments;
  final String text;

  Post(
      {required this.id,
      required this.user,
      required this.totalComments,
      required this.comments,
      required this.text});
}
