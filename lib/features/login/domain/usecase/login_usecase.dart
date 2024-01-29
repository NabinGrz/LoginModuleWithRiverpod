import 'package:flutter/material.dart';
import 'package:login_with_riverpod/features/login/data/repositories/authentication_repositories.dart';

import '../entities/login_response.dart';

class LoginUseCase {
  final AuthRepository authRepository;
  LoginUseCase(this.authRepository);
  final passwordValueNotifier = ValueNotifier(false);
  final numberController = TextEditingController();
  final passwordController = TextEditingController();

  Future<LoginResponse> execute(
      {required String number, required String password}) async {
    return await authRepository.login(number: number, password: password);
  }
}
