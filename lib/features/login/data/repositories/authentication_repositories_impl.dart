import 'package:login_with_riverpod/features/login/data/repositories/authentication_repositories.dart';
import 'package:login_with_riverpod/features/login/data/requests/authentication_request.dart';
import 'package:login_with_riverpod/features/login/domain/entities/login_response.dart';

class AuthenticationRepositoryImpl implements AuthRepository {
  final authenticationRequest = AuthenticationRequest();
  @override
  Future<LoginResponse> login(
      {required String number, required String password}) async {
    return await authenticationRequest.login(
        number: number, password: password);
  }
}
