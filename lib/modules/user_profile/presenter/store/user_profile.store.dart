import 'package:flutter/cupertino.dart';
import 'package:posterr/modules/user_profile/domain/usecases/get_current_user.usecase.dart';
import 'package:posterr/modules/user_profile/presenter/states/user_profile.state.dart';

class UserProfileStore extends ValueNotifier<UserProfileState> {
  final IGetCurrentUserUsecase usecase;
  UserProfileStore(this.usecase) : super(InitialUserProfileState());

  void emit(UserProfileState newState) => value = newState;

  Future<void> getCurrentUser(String userName) async {
    emit(LoadingUserProfileState());
    final result = await usecase.call(userName);
    final newState = result.fold((l) {
      return ErrorUseProfileState(l.message);
    }, (r) {
      return SuccessUserProfileState(r);
    });
    emit(newState);
  }
}
