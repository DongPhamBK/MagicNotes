import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_notes/utils/style.dart';
import 'package:magic_notes/views/widgets/button.dart';
import 'package:magic_notes/views/widgets/dialog_notification.dart';

import '../providers/user_provider.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  ForgotPasswordScreen({
    Key? key,
  }) : super(key: key);

  TextEditingController userEmailController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //var dataResponse = ref.watch(userProvider).dataResponse;
    var isLoading = ref.watch(userProvider).isLoading;
    //print("ForgotPasswordScreen build");

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text("Quên mật khẩu"),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 10,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 500,
                      child: Text(
                        "Sau khi nhập tài khoản email bạn đã đăng ký và nhấn Xác nhận, một email sẽ được gửi tới tài khoản của bạn, mở email và truy cập liên kết rồi đổi mật khẩu. Sau đó, quay lại và đăng nhập với mật khẩu mới!",
                        style: textContent.copyWith(color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 500,
                      child: TextField(
                        maxLength: 100,
                        keyboardType: TextInputType.text,
                        controller: userEmailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Địa chỉ email',
                          hintText: 'Nhập địa chỉ email ứng với tài khoản của bạn!',
                          labelStyle: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    buttonText(
                      "Xác nhận",
                      () {
                        final userEmail = userEmailController.text;

                        if (userEmail.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) => dialogNotification(context, "CHÚ Ý:", "Không được để trống email!"),
                          );
                        } else {
                          ref.read(userProvider).forgotUserPassword(userEmail).then((value) {
                            if (value!.code == 200) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return dialogNotification(context, "KẾT QUẢ", "Reset mật khẩu thành công!");
                                },
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return dialogNotification(context, "KẾT QUẢ", "Reset mật khẩu thất bại!");
                                },
                              );
                            }
                          });
                        }
                      },
                    ),
                    if (isLoading) CircularProgressIndicator(color: Colors.orange) else SizedBox(),
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
