import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_notes/views/widgets/button.dart';
import 'package:magic_notes/views/widgets/dialog_notification.dart';
import 'package:magic_notes/views/widgets/password_input.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';

class SignUpScreen extends ConsumerWidget {
  SignUpScreen({
    Key? key,
  }) : super(key: key);

  //Đừng để controller trong build, nếu không sẽ mất dữ liệu khi bật tắt bàn phím
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userDescriptionController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dataResponse = ref.watch(userProvider).dataResponse;
    var signUpResult = ref.watch(userProvider).signUpResult;
    var isLoading = ref.watch(userProvider).isLoading;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text("Đăng ký"),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
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
                            height: 10,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 500,
                            child: TextField(
                              maxLength: 20,
                              keyboardType: TextInputType.text,
                              controller: userNameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Tên tài khoản',
                                hintText: 'Nhập tên tài khoản của bạn!',
                              ),
                            ),
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
                            child: TextField(
                              maxLength: 200,
                              keyboardType: TextInputType.text,
                              controller: userDescriptionController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Mô tả',
                                hintText: 'Nhập mô tả về bạn!',
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
                          SizedBox(
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
                                  builder: (context) => dialogNotification(context, "CHÚ Ý", "Không được để trống bất cứ ô nào!"),
                                );
                              } else if (password != confirmPassword) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return dialogNotification(context, "CHÚ Ý", "Mật khẩu phải khớp nhau");
                                  },
                                );
                              } else {
                                User user = User(userName: userName, userEmail: userEmail, userDescription: userDescription, userPassword: password);
                                ref.read(userProvider).signUp(user).then(
                                  (response) {
                                    //print("code ${response!.code}");
                                    if (response!.code == 201) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return dialogNotification(context, "KẾT QUẢ", "Đăng ký thành công");
                                        },
                                      );
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return dialogNotification(context, "KẾT QUẢ", "Đăng ký thất bại:\n ${response.message}");
                                        },
                                      );
                                    }
                                  },
                                );
                              }
                            },
                          ),
                          if (isLoading) CircularProgressIndicator(color: Colors.orange) else SizedBox(),
                          SizedBox(
                            height: 10,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
