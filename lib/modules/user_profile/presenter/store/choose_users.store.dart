import 'package:flutter/cupertino.dart';
import 'package:posterr/modules/user_profile/domain/usecases/get_current_user.usecase.dart';
import 'package:posterr/modules/user_profile/presenter/states/choose_user.state.dart';
import 'package:posterr/modules/user_profile/domain/usecases/get_users.usecase.dart';

class ChooseUserStore extends ValueNotifier<ChooseUserState> {
  GetUsersUsecase getUsersUsecase;
  ChooseUserStore(this.getUsersUsecase) : super(EmptyChooseUserState([]));
  void emit(ChooseUserState newState) => value = newState;

  getUsers() async {
    emit(LoadingChooseUserState());
    final result = await getUsersUsecase.call();
    result.fold((l) {
      emit(ErrorChooseUserState(l.message));
    }, (r) => emit(SuccessChooseUserState(r)));
  }
}
