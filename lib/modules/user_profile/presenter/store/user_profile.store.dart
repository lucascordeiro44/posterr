import 'package:flutter/cupertino.dart';
import 'package:posterr/core/error/errors.dart';
import 'package:posterr/modules/user_profile/domain/usecases/get_current_user.usecase.dart';
import 'package:posterr/modules/user_profile/presenter/store/user_profile.state.dart';
import 'package:uno/uno.dart';

class UserProfileStore extends ValueNotifier<UserProfileState> {
  final IGetCurrentUserUsecase usecase;
  UserProfileStore(this.usecase) : super(InitialUserProfileState());

  void emit(UserProfileState newState) => value = newState;

  Future<void> getCurrentUser(String userName) async {
    emit(LoadingUserProfileState());
    print('chegou aqui');
    final result = await usecase.call(userName);
    final newState = result.fold((l) {
      print('erro');
      return ErrorUseProfileState(l.message);
    }, (r) {
      print('sucesso');
      print(r.fullName + " " + r.dateJoined);
      return SuccessUserProfileState(r);
    });
    emit(newState);
  }
}
