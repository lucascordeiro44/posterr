import 'package:jiffy/jiffy.dart';

String formatDateJoinedDate(DateTime joinedDate) {
  return Jiffy(DateTime(joinedDate.year, joinedDate.month, joinedDate.day))
      .yMMMMd;
}

String formatPostDate(DateTime postDate) {
  return Jiffy(DateTime(postDate.year, postDate.month, postDate.day,
          postDate.hour, postDate.minute))
      .yMMMMdjm;
}
