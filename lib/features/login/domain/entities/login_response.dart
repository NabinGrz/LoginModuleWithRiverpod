class LoginResponse {
  final String? message;
  final int? statusCode;
  final String? errorMessage;
  final bool isLoading;

  LoginResponse({
    this.message,
    this.statusCode,
    this.errorMessage,
    required this.isLoading,
  });
}
