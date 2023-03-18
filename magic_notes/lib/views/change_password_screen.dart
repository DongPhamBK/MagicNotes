import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_notes/providers/user_provider.dart';
import 'package:magic_notes/views/widgets/button.dart';
import 'package:magic_notes/views/widgets/dialog_notification.dart';
import 'package:magic_notes/views/widgets/password_input.dart';

import '../utils/style.dart';

class ChangePasswordScreen extends ConsumerWidget {
  late String userEmail;

  ChangePasswordScreen({
    required this.userEmail,
    Key? key,
  }) : super(key: key);
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //var dataResponse = ref.watch(userProvider).dataResponse;
    var isLoading = ref.watch(userProvider).isLoading;

    //print("ChangePasswordScreen build");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title:   Text("Đổi mật khẩu"),
        ),
        body: Container(
          height:MediaQuery.of(context).size.height,
          decoration:   BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding:   EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Thay đổi mật khẩu tài khoản MagicNotes của bạn!",
                      style: textHeadline1.copyWith(color: Colors.deepOrange),
                    ),
                      SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: 500,
                      child: TextField(
                        maxLength: 100,
                        keyboardType: TextInputType.text,
                        enabled: false,
                        controller: TextEditingController(text: userEmail),
                        decoration:   InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Địa chỉ email',
                          labelStyle: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                      SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 500,
                      child: PasswordInput(
                        hintText: 'Nhập mật khẩu mới của bạn!',
                        label: 'Mật khẩu mới',
                        passwordController: passwordController,
                      ),
                    ),
                      SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 500,
                      child: PasswordInput(
                        label: "Nhập lại mật khẩu",
                        hintText: "Nhập lại mật khẩu mới của bạn!",
                        passwordController: confirmPasswordController,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    buttonText(
                      "Xác nhận",
                      () {
                        final password = passwordController.text;
                        final confirmPassword = confirmPasswordController.text;

                        if (password.isEmpty || confirmPassword.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) => dialogNotification(context, "CHÚ Ý:", "Không được để trống bất cứ ô nào!"),
                          );
                        } else if (password != confirmPassword) {
                          showDialog(
                            context: context,
                            builder: (context) => dialogNotification(context, "CHÚ Ý:", "Hai mật khẩu phải khớp nhau!"),
                          );
                        } else {
                          ref.read(userProvider).changeUserPassword(userEmail, password, confirmPassword).then((value) {
                            if (value!.code == 200) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return dialogNotification(context, "KẾT QUẢ", "Đổi mật khẩu thành công!");
                                },
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return dialogNotification(context, "KẾT QUẢ", "Đổi mật khẩu thất bại!");
                                },
                              );
                            }
                          });
                        }
                      },
                    ),
                    if (isLoading)   CircularProgressIndicator(color: Colors.orange) else   SizedBox(),
                      SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
