class LoginResponse {
  final String? message;
  final int? statusCode;
  final String? errorMessage;
  final bool isLoading;
  final String? numberErrorMsg;
  final String? passwordErrorMsg;
  final bool showDialog;

  LoginResponse({
    this.numberErrorMsg,
    this.passwordErrorMsg,
    this.message,
    this.statusCode,
    this.errorMessage,
    required this.isLoading,
    this.showDialog = false,
  });

  LoginResponse addNumberErrorMsg(String? msg) => LoginResponse(
        isLoading: isLoading,
        message: message,
        statusCode: statusCode,
        errorMessage: errorMessage,
        numberErrorMsg: msg,
        passwordErrorMsg: passwordErrorMsg,
        showDialog: showDialog,
      );
  bool get hasNumberError => numberErrorMsg != null;
  LoginResponse addPasswordErrorMsg(String? msg) => LoginResponse(
        isLoading: isLoading,
        message: message,
        statusCode: statusCode,
        errorMessage: errorMessage,
        numberErrorMsg: numberErrorMsg,
        passwordErrorMsg: msg,
        showDialog: showDialog,
      );
  bool get hasPasswordError => passwordErrorMsg != null;
}

class LoginDetails {
  final String number;
  final String password;

  LoginDetails({
    required this.number,
    required this.password,
  });
}
