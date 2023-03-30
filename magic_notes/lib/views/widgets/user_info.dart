import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_notes/providers/user_provider.dart';
import 'package:magic_notes/utils/constants.dart';
import 'package:magic_notes/utils/style.dart';
import 'package:magic_notes/views/widgets/button.dart';
import 'package:magic_notes/views/widgets/dialog_user_photo.dart';

import '../../providers/password_provider.dart';

class UserInfo extends ConsumerWidget {
  late String userId;

  UserInfo({
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var userInfo = ref.watch(userProvider).userInfo;
    var userPhotoURL = ref.watch(userProvider).userPhotoURL;
    print("UserInfo build");
    //print("Local $imageLocalURL");
    return SafeArea(
      child: Container(
        color: Colors.yellow.shade200,
        padding: EdgeInsets.only(left: 6, right: 2),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Colors.orange,
                  height: 50,
                  child: Text(
                    "Xin chào ${userInfo != null ? userInfo!.userName : ""}",
                    style: textHeadline1.copyWith(backgroundColor: Colors.orange),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: imageLocal == null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(userPhotoURL),
                          backgroundColor: Colors.orange,
                          maxRadius: 100,
                          minRadius: 20,
                        )
                      : CircleAvatar(
                          backgroundImage: MemoryImage(imageLocal!),
                          backgroundColor: Colors.orange,
                          maxRadius: 100,
                          minRadius: 20,
                        ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DialogUserPhoto(photoURL: userPhotoURL);
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Tên tài khoản: ${userInfo != null ? userInfo!.userName : ""}"),
                Text("Địa chỉ email: ${userInfo != null ? userInfo!.userEmail : ""}"),
                Text("Mô tả: ${userInfo != null ? userInfo!.userDescription : ""}"),
                TextButton(
                    onPressed: () {
                      context.push('/changepass', extra: userInfo?.userEmail);
                    },
                    child: Text("Đổi mật khẩu")),
                TextButton(
                    onPressed: () {
                      context.pushNamed('/changeuserinfo', params: {'userName': userInfo!.userName!, 'userDescription': userInfo!.userDescription!});
                    },
                    child: Text("Thay đổi thông tin người dùng")),
              ],
            ),
            Positioned(
              bottom: 50,
              right: 0,
              left: 0,
              child: Center(
                child: buttonText("  Đăng xuất  ", () {
                  imageLocal = null; // Cân chỉnh lại!
                  ref.read(passwordPr.notifier).savePassword(false, "", "");
                  context.go('/login');
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
