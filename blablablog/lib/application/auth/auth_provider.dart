import 'package:clean_api/clean_api.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:blabloglucy/application/auth/auth_state.dart';
import 'package:blabloglucy/domain/auth/i_auth_repo.dart';
import 'package:blabloglucy/domain/auth/models/recovery.dart';
import 'package:blabloglucy/domain/auth/models/registration.dart';
import 'package:blabloglucy/domain/auth/models/user_info.dart';
import 'package:blabloglucy/infrastructure/auth/auth_repo.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(AuthRepo());
});

class AuthNotifier extends StateNotifier<AuthState> {
  final IAuthRepo authRepo;
  AuthNotifier(this.authRepo)
      : super(AuthState(
            userInfo: UserInfo.empty(),
            loading: false,
            failure: CleanFailure.none(),
            valueChecking: false,
            languageList: const [],
            countryList: const [],
            colorsList: const [],
            validEmail: false,
            validName: false));

  login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(loading: true, failure: CleanFailure.none());
    final data = await authRepo.login(
      email: email,
      password: password,
    );

    state = data.fold(
      (l) => state.copyWith(failure: l, loading: false),
      (r) => state.copyWith(
        loading: false,
        userInfo: r,
        failure: CleanFailure.none(),
      ),
    );

    // print(state.userInfo);
  }

  tryLogin() async {
    state = state.copyWith(
      loading: true,
    );
    final data = await authRepo.tryLogin();

    state = data.fold(
      (l) => state.copyWith(loading: false),
      (r) => state.copyWith(
        loading: false,
        userInfo: r,
        failure: CleanFailure.none(),
      ),
    );

    // print(state.userInfo);
  }

  createRegistration(Registration registration) async {
    state = state.copyWith(loading: true, failure: CleanFailure.none());
    final data = await authRepo.registration(registration);

    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false));
  }

  Future<void> logout() async {
    state = state.copyWith(userInfo: UserInfo.empty());

    await authRepo.logOut();
  }

  passWordRecovery(Recovery recovery) async {
    state = state.copyWith(loading: true, failure: CleanFailure.none());
    final data = await authRepo.passwordRecovary(recovery);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false));
  }

  checkNickName(String nickName) async {
    debugPrint('che k nik ');
    state = state.copyWith(valueChecking: true);
    final data = await authRepo.nickNameCheck(nickName);
    state = data.fold((l) => state.copyWith(failure: l),
        (r) => state.copyWith(validName: r).copyWith(valueChecking: false));
  }

  checkEmail(String email) async {
    state = state.copyWith(valueChecking: true, failure: CleanFailure.none());
    final data = await authRepo.emailCheck(email);
    state = data.fold((l) => state.copyWith(failure: l),
        (r) => state.copyWith(validEmail: r).copyWith(valueChecking: false));
  }

  getCountries() async {
    // state = state.copyWith(loading: true);
    final data = await authRepo.getCountries();
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, countryList: r));
  }

  getLanguage() async {
    // state = state.copyWith(loading: true);
    final data = await authRepo.getLanguages();
    state = data.fold((l) => state.copyWith(failure: l, loading: false),
        (r) => state.copyWith(loading: false, languageList: r));
  }

  getColors() async {
    // state = state.copyWith(loading: true);
    final data = await authRepo.getColors();
    state = data.fold((l) => state.copyWith(loading: false, failure: l), (r) {
      r.shuffle();
      return state.copyWith(loading: false, colorsList: r);
    });
  }
}
