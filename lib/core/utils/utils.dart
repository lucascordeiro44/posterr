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

int diffTime(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day, from.minute);
  to = DateTime(to.year, to.month, to.day, to.minute);
  if (to.difference(from).inMinutes > 60) {
    return (to.difference(from).inDays);
  } else {
    return to.difference(from).inMinutes;
  }
}
