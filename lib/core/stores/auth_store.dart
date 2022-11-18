import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:posterr/core/globals.dart';
import 'package:posterr/modules/user_profile/domain/usecases/get_current_user.usecase.dart';
import 'package:posterr/modules/user_profile/presenter/states/user_profile.state.dart';

import '../../modules/user_profile/domain/entities/user.dart';

class AuthStore extends ValueNotifier<UserProfileState> {
  final IGetCurrentUserUsecase usecase;
  AuthStore(this.usecase) : super(InitialUserProfileState());

  void emit(UserProfileState newState) => value = newState;

  User? user;

  Box<User> get getUserBox => Modular.get<Box<User>>();
  User get getLoggedUser => user!;
  static int userPublicationCounter = 0;

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

  Future<void> logout() async {
    User loggedUser = getLoggedUser;
    loggedUser.userPublishCounter = Globals.publicationCounter;
    loggedUser.lastPutlicationEventDate = DateTime.now();
    getUserBox.put(loggedUser.key, loggedUser);
    Globals.publicationCounter = 0;
  }
}
