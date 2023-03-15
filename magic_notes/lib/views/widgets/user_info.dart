import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_notes/providers/user_provider.dart';
import 'package:magic_notes/utils/constants.dart';
import 'package:magic_notes/utils/style.dart';
import 'package:magic_notes/views/widgets/button.dart';

class UserInfo extends ConsumerWidget {
  late String userId;

  UserInfo({
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var userInfo = ref.watch(userProvider).userInfo;
    print("UserInfo build");

    return Container(
      color: Colors.yellow.shade200,
      padding: const EdgeInsets.only(left: 6, right: 2),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.orange,
                height: 50,
                child: Text(
                  "Xin chào ${userInfo?.userName}",
                  style: textHeadline1.copyWith(backgroundColor: Colors.orange),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 200,
              ),
              Text("Tên tài khoản: ${userInfo?.userName}"),
              Text("Địa chỉ email: ${userInfo?.userEmail}"),
              Text("Mô tả: ${userInfo?.userDescription}"),
              TextButton(
                  onPressed: () {
                    context.push('/changepass', extra: userInfo?.userEmail);
                  },
                  child: const Text("Đổi mật khẩu")),
              TextButton(
                  onPressed: () {
                    context.pushNamed('/changeuserinfo', params: {'userName': userInfo!.userName!, 'userDescription': userInfo!.userDescription!});
                  },
                  child: const Text("Thay đổi thông tin người dùng")),
            ],
          ),
          Positioned(
            bottom: 50,
            right: 0,
            left: 0,
            child: Center(
              child: buttonText("  Đăng xuất  ", () {
                USER_ID = "";
                context.go('/login');
              }),
            ),
          ),
        ],
      ),
    );
  }
}
