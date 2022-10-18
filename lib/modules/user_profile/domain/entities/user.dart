// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:posterr/core/error/formats.dart';

class User extends Equatable {
  final String username;
  final DateTime joinedDate; 

   String get dateJoined => formatDate(joinedDate);

  const User({
    required this.username,
    required this.joinedDate,
  });
  
  @override
  List<Object?> get props => [username, joinedDate];
}
