// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive/hive.dart';
import 'package:posterr/core/utils/utils.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final DateTime joinedDate;
  @HiveField(2)
  final String fullName;
  @HiveField(3)
  final String photo;
  @HiveField(4)
  int userPublishCounter;
  @HiveField(5)
  DateTime lastPutlicationEventDate;

  String get dateJoined => formatDateJoinedDate(joinedDate);

  bool canPublish() {
    if (userPublishCounter == 5 && isToday(lastPutlicationEventDate)) {
      return false;
    }
    return true;
  }

  User(
      {required this.username,
      required this.fullName,
      required this.joinedDate,
      required this.photo,
      required this.userPublishCounter,
      required this.lastPutlicationEventDate});
}
