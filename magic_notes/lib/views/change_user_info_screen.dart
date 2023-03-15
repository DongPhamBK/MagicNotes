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

  ChangeUserInfoScreen({
    required this.userName,
    required this.userDescription,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //var dataResponse = ref.watch(userProvider).dataResponse;
    var isLoading = ref.watch(userProvider).isLoading;

    TextEditingController userNameController = TextEditingController();
    userNameController.text = userName!;
    TextEditingController userDescriptionController = TextEditingController();
    userDescriptionController.text = userDescription!;
    print("ChangePasswordScreen build");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text("Đổi thông tin người dùng"),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 10,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Thay đổi tên tài khoản:",
                      style: textHeadline1.copyWith(color: Colors.deepOrange),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 500,
                      child: TextField(
                        maxLength: 100,
                        keyboardType: TextInputType.text,
                        controller: userNameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Tên người dùng',
                          hintText: 'Nhập tên người dùng mới',
                          labelStyle: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 500,
                      child: TextField(
                        maxLength: 100,
                        keyboardType: TextInputType.text,
                        controller: userDescriptionController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Mô tả',
                          hintText: 'Nhập mô tả người dùng mới',
                          labelStyle: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    const SizedBox(
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
                              await Future.delayed(Duration(milliseconds: 500)).then((value) => showDialog(
                                context: context,
                                builder: (context) {
                                  return dialogNotification(context, "KẾT QUẢ", "Đổi thông tin người dùng thành công!");
                                },
                              ));

                            } else {
                              await Future.delayed(Duration(milliseconds: 500)).then((value) => showDialog(
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
                    if (isLoading) const CircularProgressIndicator(color: Colors.orange) else const SizedBox(),
                    const SizedBox(
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
