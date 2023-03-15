import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_notes/views/widgets/button.dart';
import 'package:magic_notes/views/widgets/dialog_notification.dart';
import 'package:magic_notes/views/widgets/password_input.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../utils/style.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dataResponse = ref.watch(userProvider).dataResponse;
    var signUpResult = ref.watch(userProvider).signUpResult;
    var isLoading = ref.watch(userProvider).isLoading;

    TextEditingController userNameController = TextEditingController();
    TextEditingController userEmailController = TextEditingController();
    TextEditingController userDescriptionController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height - 10,
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "ĐĂNG KÝ",
                          style: textHeadline1.copyWith(color: Colors.orange, fontSize: 32),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 500,
                          child: TextField(
                            maxLength: 20,
                            keyboardType: TextInputType.text,
                            controller: userNameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Tên tài khoản',
                              hintText: 'Nhập tên tài khoản của bạn!',
                            ),
                          ),
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
                          child: TextField(
                            maxLength: 200,
                            keyboardType: TextInputType.text,
                            controller: userDescriptionController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Mô tả',
                              hintText: 'Nhập mô tả về bạn!',
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
                        SizedBox(
                          width: 500,
                          child: PasswordInput(
                            label: "Xác nhận mật khẩu",
                            hintText: "Nhập lại mật khẩu của bạn!",
                            passwordController: confirmPasswordController,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        buttonText(
                          "Xác nhận",
                          () {
                            final userName = userNameController.text;
                            final userEmail = userEmailController.text;
                            final userDescription = userDescriptionController.text;
                            final password = passwordController.text;
                            final confirmPassword = confirmPasswordController.text;
                            if (userEmail.isEmpty || password.isEmpty || userDescription.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
                              showDialog(
                                context: context,
                                builder: (context) => dialogNotification(context, "CHÚ Ý:", "Không được để trống bất cứ ô nào!"),
                              );
                            } else {
                              User user = User(userName: userName, userEmail: userEmail, userDescription: userDescription, userPassword: password);
                              ref.read(userProvider).sigUp(user).then(
                                (response) {
                                  if (response!.code == 200) {
                                    //context.goNamed('/home', params: {'userId': response.data});
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
                          child: Text(dataResponse?.code != 200 ? signUpResult.toString() : ""),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: InkWell(
                  child: Text(
                    "Đăng nhập",
                    style: textHeadline1.copyWith(
                      color: Colors.orange,
                    ),
                  ),
                  onTap: () {
                    context.go('/login');
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
