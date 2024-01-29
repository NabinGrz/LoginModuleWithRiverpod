import 'package:flutter/material.dart';

import '../../domain/entities/login_response.dart';

class ShowLoginMessageDialog {
  static void showLoginStatusDialog(BuildContext context,
          LoginResponse response, bool isSuccess, void Function()? onPressed) =>
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: const Text("Login Status"),
            content: Text(
              "${response.message}",
              style: TextStyle(
                fontSize: 20,
                color: !isSuccess ? Colors.red : Colors.green,
              ),
            ),
            actions: [
              TextButton(
                onPressed: onPressed,
                child: const Center(
                  child: Text(
                    "Ok",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
}
