import 'package:jiffy/jiffy.dart';

String formatDate(DateTime joinedDate) {
  return Jiffy(DateTime(joinedDate.year, joinedDate.month, joinedDate.day)).yMMMMd;
}
