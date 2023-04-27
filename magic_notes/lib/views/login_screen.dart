import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_notes/models/user.dart';
import 'package:magic_notes/providers/password_provider.dart';
import 'package:magic_notes/providers/user_provider.dart';
import 'package:magic_notes/views/responsive.dart';
import 'package:magic_notes/views/widgets/button.dart';
import 'package:magic_notes/views/widgets/dialog_notification.dart';
import 'package:magic_notes/views/widgets/password_input.dart';

import '../utils/constants.dart';
import '../utils/style.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({
    Key? key,
  }) : super(key: key);

  TextEditingController userEmailController = TextEditingController(text: prefs!.getString('email'));
  TextEditingController passwordController = TextEditingController(text: prefs!.getString('password'));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dataResponse = ref.watch(userProvider).dataResponse;
    var logInResult = ref.watch(userProvider).logInResult;
    var isLoading = ref.watch(userProvider).isLoading;
    var isSavePassword = ref.watch(passwordPr);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/background.png"), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Animate(
                        effects: [
                          ShimmerEffect(duration: Duration(milliseconds: 5000), color: Colors.yellow),
                        ],
                        onPlay: (controller) => controller.repeat(reverse: false),
                        child: Text(
                          "MAGICNOTES",
                          style: textHeadline1.copyWith(color: Colors.deepOrange, fontSize: 32),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "ĐĂNG NHẬP",
                        style: textHeadline1.copyWith(color: Colors.orange, fontSize: 24),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 500,
                        child: TextField(
                          maxLength: 100,
                          keyboardType: TextInputType.emailAddress,
                          controller: userEmailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Địa chỉ email',
                            hintText: 'Nhập địa chỉ email của bạn!',
                          ),
                        ),
                      ),
                      SizedBox(
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
                      SizedBox(
                        width: 250,
                        child: CheckboxListTile(
                          value: isSavePassword,
                          checkColor: Colors.white,
                          activeColor: Colors.orange,

                          controlAffinity: ListTileControlAffinity.leading,
                          // đặt bên trái
                          onChanged: (value) {
                            ref.read(passwordPr.notifier).savePassword(value!, userEmailController.text, passwordController.text);
                          },
                          title: Text('Nhớ mật khẩu'),
                        ),
                      ),
                      SizedBox(
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
                      SizedBox(
                        height: 10,
                      ),
                      if (isLoading) CircularProgressIndicator(color: Colors.orange) else SizedBox(),
                      SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: 500,
                        child: Text(dataResponse?.code != 200 ? logInResult.toString() : ""),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: Responsive.isDesktop(context) ? 20 : 10,
                child: InkWell(
                  child: Text(
                    "Đăng ký",
                    style: textHeadline1.copyWith(color: Colors.orange, fontSize: Responsive.isDesktop(context) ? 20 : 14),
                  ),
                  onTap: () {
                    context.push('/signup');
                  },
                ),
              ),
              Positioned(
                bottom: 20,
                right: Responsive.isDesktop(context) ? 20 : 10,
                child: InkWell(
                  child: Text(
                    "Quên mật khẩu?",
                    style: textHeadline1.copyWith(color: Colors.orange, fontSize: Responsive.isDesktop(context) ? 20 : 14),
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
