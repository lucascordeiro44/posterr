import 'package:flutter/cupertino.dart';
import 'package:posterr/modules/user_profile/domain/usecases/get_current_user.usecase.dart';
import 'package:posterr/modules/user_profile/presenter/store/user_profile.state.dart';

class UserProfileStore extends ValueNotifier<UserProfileState> {
  final IGetCurrentUserUsecase usecase;
  UserProfileStore(this.usecase) : super(LoadingUserProfileState());

  getCurrentUser() {}
}
