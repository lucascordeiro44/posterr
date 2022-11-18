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

String diffTime(DateTime from) {
  DateTime to = DateTime.now();
  from = DateTime(
      from.year, from.month, from.day, from.hour, from.minute, from.second);
  to = DateTime(to.year, to.month, to.day, to.hour, to.minute, to.second);
  if (to.difference(from).inDays < 1) {
    if (to.difference(from).inHours < 1) {
      if ((to.difference(from).inMinutes < 1)) {
        return "${(to.difference(from).inSeconds)}s";
      }
      return "${(to.difference(from).inMinutes)}m";
    }
    return "${(to.difference(from).inHours)}h";
  } else {
    return "${(to.difference(from).inDays)}d";
  }
}

bool isToday(DateTime from) {
  DateTime now = DateTime.now();
  return DateTime(from.year, from.month, from.day)
          .difference(DateTime(now.year, now.month, now.day))
          .inDays ==
      0;
}
