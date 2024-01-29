import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:login_with_riverpod/features/login/domain/entities/login_response.dart';

import '../../providers.dart';

class LoginFormWidget extends ConsumerWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginProvider = StateNotifierProvider<LoginProvider, LoginResponse>(
        (ref) => LoginProvider());
    final passwordValueNotifier = ValueNotifier(false);
    final numberController = TextEditingController();
    final passwordController = TextEditingController();
    ref.listen(
      loginProvider,
      (previous, next) {
        bool isSuccess = next.statusCode == 200;
        if (!next.isLoading) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog.adaptive(
                title: const Text("Login Status"),
                content: Text(
                  "${next.message}",
                  style: TextStyle(
                    fontSize: 20,
                    color: !isSuccess ? Colors.red : Colors.green,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
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
      },
      onError: (error, stackTrace) {},
    );
    return Consumer(builder: (context, ref, child) {
      return ref.watch(loginProvider).isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  maxLength: 10,
                  maxLines: null,
                  controller: numberController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    counterText: "",
                    hintText: "Enter your number...",
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: passwordValueNotifier,
                  builder: (context, value, child) {
                    return TextField(
                      controller: passwordController,
                      obscureText: value,
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                          hintText: "Enter your password...",
                          suffixIcon: InkWell(
                            onTap: () => passwordValueNotifier.value = !value,
                            child: value
                                ? const Icon(Icons.check_box)
                                : const Icon(Icons.hide_source),
                          )),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
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
                    final provider = ref.read(loginProvider.notifier);
                    await provider.login(
                        number: numberController.text,
                        password: passwordController.text,
                        context: context);
                  },
                  child: const Text("Login"),
                ),
              ],
            );
    });
  }
}
