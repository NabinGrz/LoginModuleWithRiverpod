import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'widgets/login_form_widget.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Consumer(builder: (context, ref, widget) {
          return const Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
            ),
          );
        }),
      ),
      body: const LoginFormWidget(),
    );
  }
}
