import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';

class Repost {
  int id;
  User user;
  Post post;
  Repost(this.id, this.post, this.user);
}
