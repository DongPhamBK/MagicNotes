import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_notes/utils/constants.dart';
import 'package:magic_notes/views/widgets/button.dart';
import 'package:magic_notes/views/widgets/dialog_notification.dart';

import '../providers/user_provider.dart';
import '../utils/style.dart';

class ChangeUserInfoScreen extends ConsumerWidget {
  late String? userName;
  late String? userDescription;
  late  TextEditingController userNameController;
  late TextEditingController userDescriptionController;
  ChangeUserInfoScreen({
    required this.userName,
    required this.userDescription,
    Key? key,
  }) : super(key: key){
    userNameController = TextEditingController(text: userName!);
    userDescriptionController = TextEditingController(text: userDescription!);
  }



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //var dataResponse = ref.watch(userProvider).dataResponse;
    var isLoading = ref.watch(userProvider).isLoading;

    //userNameController.text = userName!;
    //userDescriptionController.text = userDescription!;
    //print("ChangePasswordScreen build");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text("Đổi thông tin người dùng"),
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
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Thay đổi tên tài khoản:",
                        style: textHeadline1.copyWith(color: Colors.deepOrange),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 500,
                        child: TextField(
                          maxLength: 100,
                          keyboardType: TextInputType.text,
                          controller: userNameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Tên người dùng',
                            hintText: 'Nhập tên người dùng mới',
                            labelStyle: TextStyle(fontSize: 25),
                          ),
                        ),
                      ),
                      Text(
                        "Thay đổi mô tả:",
                        style: textHeadline1.copyWith(color: Colors.deepOrange),
                      ),
                      SizedBox(
                        width: 500,
                        child: TextField(
                          maxLength: 100,
                          maxLines: 5,
                          keyboardType: TextInputType.text,
                          controller: userDescriptionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Mô tả',
                            hintText: 'Nhập mô tả người dùng mới',
                            labelStyle: TextStyle(fontSize: 25),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      buttonText(
                        "Xác nhận",
                        () {
                          final userName = userNameController.text;
                          final userDescription = userDescriptionController.text;

                          if (userName.isEmpty || userDescription.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (context) => dialogNotification(context, "CHÚ Ý:", "Không được để trống bất cứ ô nào!"),
                            );
                          } else {
                            ref.read(userProvider).changeUserInfo(USER_ID, userName, userDescription).then((value) async {
                              if (value!.code == 200) {
                                await Future.delayed(Duration(milliseconds: 100)).then((value) => showDialog(
                                      context: context,
                                      builder: (context) {
                                        ref.invalidate(userProvider); //Cập nhật lại thông tin người dùng
                                        return dialogNotification(context, "KẾT QUẢ", "Đổi thông tin người dùng thành công!");
                                      },
                                    ));
                              } else {
                                await Future.delayed(Duration(milliseconds: 100)).then((value) => showDialog(
                                      context: context,
                                      builder: (context) {
                                        return dialogNotification(context, "KẾT QUẢ", "Đổi thông tin người dùng thất bại!");
                                      },
                                    ));
                              }
                            }).then((value) {
                              context.pop();
                              context.pop();
                            });
                            //context.pop();
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
          ),
        ));
  }
}
