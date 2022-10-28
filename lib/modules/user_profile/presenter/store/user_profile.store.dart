import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:posterr/modules/user_profile/domain/usecases/get_current_user.usecase.dart';
import 'package:posterr/modules/user_profile/presenter/states/user_profile.state.dart';

import '../../domain/entities/user.dart';

class UserProfileStore extends ValueNotifier<UserProfileState> {
  final IGetCurrentUserUsecase usecase;
  UserProfileStore(this.usecase) : super(InitialUserProfileState());

  void emit(UserProfileState newState) => value = newState;

  User? user;

  Box<User> get getUserBox => Hive.box('users');
  User get getLoggedUser => user!;

  Future<void> login(String userName) async {
    emit(LoadingUserProfileState());
    final result = await usecase.call(userName);
    final newState = result.fold((l) {
      return ErrorUseProfileState(l.message);
    }, (r) {
      user = r;
      return SuccessUserProfileState(r);
    });
    emit(newState);
  }
}
