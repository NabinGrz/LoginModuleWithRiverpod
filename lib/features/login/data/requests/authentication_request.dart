import 'package:dio/dio.dart';

import '../../domain/entities/login_response.dart';

class AuthenticationRequest {
  Dio dioClient = Dio();
  Future<LoginResponse> login(
      {required String number, required String password}) async {
    String loginUrl =
        "https://dev.publicapi-hgie2e.ekbana.net/api/v1/app-individual/login";
    try {
      final response = await dioClient.post(loginUrl, data: {
        "username": number,
        "password": password,
        "role": "user",
      });
      return LoginResponse(
        message: response.data['data']['message'],
        statusCode: response.statusCode,
        isLoading: false,
      );
    } on DioException catch (e) {
      return LoginResponse(
        message: e.response?.data['errors'][0]['message'],
        statusCode: e.response?.statusCode,
        isLoading: false,
      );
    }
  }
}
