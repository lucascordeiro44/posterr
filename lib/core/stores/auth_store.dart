import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:posterr/core/stores/auth_store.state.dart';
import 'package:posterr/modules/user_profile/domain/usecases/get_current_user.usecase.dart';

import '../../modules/user_profile/domain/entities/user.dart';

class AuthStore extends ValueNotifier<AuthStoreState> {
  final IGetCurrentUserUsecase usecase;
  AuthStore(this.usecase) : super(InitiaAuthStoreState());

  void emit(AuthStoreState newState) => value = newState;

  User? user;

  Box<User> get getUserBox => Modular.get<Box<User>>();
  User get getLoggedUser => user!;
  static int userPublicationCounter = 0;

  Future<void> login(String userName) async {
    emit(LoadingAuthStoreState());
    final result = await usecase.call(userName);
    final newState = result.fold((l) {
      return ErrorAuthStoreState(l.message);
    }, (r) {
      user = r;
      return SuccessAuthStoreState(r);
    });
    emit(newState);
  }
}
