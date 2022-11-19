import 'package:flutter/cupertino.dart';
import 'package:posterr/core/models/content_item.dart';
import 'package:posterr/core/stores/auth_store.dart';
import 'package:posterr/modules/user_profile/domain/usecases/get_user_contents.usecase.dart';
import 'package:posterr/modules/user_profile/presenter/states/user_profile.state.dart';

class UserProfileStore extends ValueNotifier<UserProfileState> {
  final GetUserContentsUsecase usecase;
  AuthStore authStore;
  int amountPosts = 0;
  int amountReposts = 0;
  int amountQuotedPosts = 0;
  UserProfileStore(this.usecase, this.authStore)
      : super(InitialUserProfileState([]));

  void emit(UserProfileState newState) => value = newState;

  Future<void> fetchUserContents() async {
    emit(LoadingUserProfileState());
    final result = await usecase.call(authStore.getLoggedUser);
    final newState = result.fold((l) {
      return ErrorUserProfileState(l.message);
    }, (r) {
      calculateAmountPublications(r);
      return SuccessUserProfileState(r);
    });
    emit(newState);
  }

  void calculateAmountPublications(List<ContentItem> contents) {
    amountPosts = 0;
    amountReposts = 0;
    amountQuotedPosts = 0;
    for (ContentItem c in contents) {
      if (c.type == ContentType.post) {
        amountPosts++;
      } else if (c.type == ContentType.repost) {
        amountReposts++;
      } else {
        amountQuotedPosts++;
      }
    }
  }
}
