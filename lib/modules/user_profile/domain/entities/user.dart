// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:posterr/core/error/formats.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends Equatable {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final DateTime joinedDate;
  @HiveField(2)
  final String fullName;

  String get dateJoined => formatDate(joinedDate);

  const User({
    required this.username,
    required this.fullName,
    required this.joinedDate,
  });

  @override
  List<Object?> get props => [username, joinedDate];
}
