import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:login_with_riverpod/features/login/data/repositories/authentication_repositories_impl.dart';
import 'package:login_with_riverpod/features/login/domain/entities/login_response.dart';
import 'package:login_with_riverpod/features/login/domain/usecase/login_usecase.dart';

class LoginProvider extends StateNotifier<LoginResponse> {
  LoginProvider() : super(LoginResponse(isLoading: false));
  final loginUseCase = LoginUseCase(AuthenticationRepositoryImpl());
  bool get hasNumError => state.hasNumberError;
  Future<void> login(
      {required LoginDetails loginDetails,
      required BuildContext context}) async {
    if (loginDetails.number != "" && loginDetails.password != "") {
      state = LoginResponse(isLoading: true);
      state = await loginUseCase.execute(
        number: loginDetails.number,
        password: loginDetails.password,
      );
    } else {
      state = state.addNumberErrorMsg(loginDetails.number == ""
          ? "Field required!!"
          : loginDetails.number.length < 10
              ? "Invalid Number!!"
              : null);
      state = state.addPasswordErrorMsg(
          loginDetails.password == "" ? "Field required!!" : null);
    }
  }

  void onChangedNumber(String value) {
    if (state.numberErrorMsg != null) {
      state = state.addNumberErrorMsg(null);
    }
  }

  void onChangedPassword(String value) {
    if (state.passwordErrorMsg != null) {
      state = state.addNumberErrorMsg(null);
    }
  }

  void reset() {
    state = LoginResponse(isLoading: false);
  }
}

//** BELOW CODE IS OF USING FUTURE PROVIDER */
final numberProvider = StateProvider<String?>((ref) => null);
final passwordProvider = StateProvider<String?>((ref) => null);

final loginFutureProvider = FutureProvider<LoginResponse?>((ref) {
  final authRepo = AuthenticationRepositoryImpl();
  final number = ref.watch(numberProvider);
  final password = ref.watch(passwordProvider);
  if (number != null && password != null) {
    return authRepo.login(number: number, password: password);
  } else {
    return LoginResponse(isLoading: false);
  }
});
