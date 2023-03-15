import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_notes/models/user.dart';
import 'package:magic_notes/providers/user_provider.dart';
import 'package:magic_notes/views/widgets/button.dart';
import 'package:magic_notes/views/widgets/dialog_notification.dart';
import 'package:magic_notes/views/widgets/password_input.dart';
import '../utils/constants.dart';
import '../utils/style.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dataResponse = ref.watch(userProvider).dataResponse;
    var logInResult = ref.watch(userProvider).logInResult;
    var isLoading = ref.watch(userProvider).isLoading;

    TextEditingController userEmailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/background.png"), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "MAGICNOTES",
                      style: textHeadline1.copyWith(color: Colors.deepOrange, fontSize: 52),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "ĐĂNG NHẬP",
                      style: textHeadline1.copyWith(color: Colors.orange, fontSize: 32),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 500,
                      child: TextField(
                        maxLength: 100,
                        keyboardType: TextInputType.emailAddress,
                        controller: userEmailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Địa chỉ email',
                          hintText: 'Nhập địa chỉ email của bạn!',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 500,
                      child: PasswordInput(
                        label: "Mật khẩu",
                        hintText: "Nhập mật khẩu của bạn!",
                        passwordController: passwordController,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    buttonText(
                      "Xác nhận",
                      () {
                        final userEmail = userEmailController.text;
                        final password = passwordController.text;
                        if (userEmail.isEmpty || password.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) => dialogNotification(context, "CHÚ Ý", "Địa chỉ email hoặc mật khẩu không được để trống!"),
                          );
                        } else {
                          User user = User(userEmail: userEmail, userPassword: password);
                          ref.read(userProvider).logIn(user).then(
                            (response) {
                              USER_ID = response!.data;
                              if (response!.code == 200) {
                                context.goNamed('/home', params: {'userId': response.data});
                              }
                            },
                          );
                        }
                      },
                    ),
                    if (isLoading) const CircularProgressIndicator(color: Colors.orange) else const SizedBox(),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: 500,
                      child: Text(dataResponse?.code != 200 ? logInResult.toString() : ""),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: InkWell(
                  child: Text(
                    "Đăng ký",
                    style: textHeadline1.copyWith(color: Colors.orange),
                  ),
                  onTap: () {
                    context.go('/signup');
                  },
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: InkWell(
                  child: Text(
                    "Quên mật khẩu?",
                    style: textHeadline1.copyWith(color: Colors.orange),
                  ),
                  onTap: () {
                    context.push('/forgetpass');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
