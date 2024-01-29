import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:login_with_riverpod/features/login/domain/entities/login_response.dart';
import 'package:login_with_riverpod/features/login/presentation/widgets/alert_dialog.dart';

import '../../providers.dart';

final loginProvider = StateNotifierProvider<LoginProvider, LoginResponse>(
    (ref) => LoginProvider());

class LoginFormWidget extends ConsumerWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginResponse = ref.watch(loginProvider);
    final provider = ref.read(loginProvider.notifier);
    _listener(context, ref, loginProvider);
    return Consumer(builder: (context, ref, child) {
      return loginResponse.isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    maxLength: 10,
                    controller: provider.loginUseCase.numberController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      counterText: "",
                      hintText: "Enter your number...",
                    ),
                    onChanged: provider.onChangedNumber,
                  ),
                  if (loginResponse.hasNumberError) ...{
                    Text(
                      "${loginResponse.numberErrorMsg}",
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  },
                  const SizedBox(
                    height: 10,
                  ),
                  ValueListenableBuilder(
                    valueListenable:
                        provider.loginUseCase.passwordValueNotifier,
                    builder: (context, value, child) {
                      return TextField(
                        controller: provider.loginUseCase.passwordController,
                        obscureText: value,
                        obscuringCharacter: "*",
                        onChanged: provider.onChangedPassword,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: "Enter your password...",
                            suffixIcon: InkWell(
                              onTap: () => provider.loginUseCase
                                  .passwordValueNotifier.value = !value,
                              child: value
                                  ? const Icon(Icons.check_box)
                                  : const Icon(Icons.hide_source),
                            )),
                      );
                    },
                  ),
                  if (loginResponse.hasPasswordError) ...{
                    Text(
                      "${loginResponse.passwordErrorMsg}",
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  },
                  const SizedBox(
                    height: 30,
                  ),
                  //****USING FUTURE PROVIDER WE CAN FOLLOW CODE BELOW,,,THIS WILL SHOW LOADER IN BUTTON NOT IN SCREEN */
                  // ElevatedButton(
                  //   onPressed: () {
                  //     ref.read(numberProvider.notifier).state = numberController.text;
                  //     ref.read(passwordProvider.notifier).state = passwordController.text;
                  //   },
                  //   child: const Text("Login"),
                  // ),

                  // ref.watch(loginFutureProvider).when(
                  //     data: (data) {
                  //       return ElevatedButton(
                  //         onPressed: () {
                  //           ref.read(numberProvider.notifier).state =
                  //               numberController.text;
                  //           ref.read(passwordProvider.notifier).state =
                  //               passwordController.text;
                  //         },
                  //         child: const Text("Login"),
                  //       );
                  //     },
                  //     error: (_, __) {
                  //       return const Text("Error");
                  //     },
                  //     loading: () => const CircularProgressIndicator.adaptive())

                  ElevatedButton(
                    onPressed: () async {
                      await provider.login(
                          loginDetails: LoginDetails(
                            number: provider.loginUseCase.numberController.text,
                            password:
                                provider.loginUseCase.passwordController.text,
                          ),
                          context: context);
                    },
                    child: const Text("Login"),
                  ),
                ],
              ),
            );
    });
  }

  void _listener(
      BuildContext context,
      WidgetRef ref,
      StateNotifierProvider<LoginProvider, LoginResponse>
          loginStateNotifierProvider) {
    ref.listen(
      loginStateNotifierProvider,
      (previous, next) {
        final provider = ref.read(loginProvider.notifier);
        bool isSuccess = next.statusCode == 200;
        if (next.showDialog) {
          ShowLoginMessageDialog.showLoginStatusDialog(context, next, isSuccess,
              () {
            Navigator.pop(context);
            provider.reset();
          });
        }
      },
      onError: (error, stackTrace) {},
    );
  }
}
