import 'package:login_with_riverpod/features/login/domain/entities/login_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(
      {required String number, required String password});
}
