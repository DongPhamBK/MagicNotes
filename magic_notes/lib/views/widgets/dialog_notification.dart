import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_notes/utils/style.dart';

Widget dialogNotification(BuildContext context, String title, String message) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    backgroundColor: Colors.orangeAccent.shade200,
    title: Text(title),
    content: Text(message),
    actions: [
      TextButton(
        onPressed: () {
          context.pop("Giá trị trả về");
        },
        child:  Text(
          "Đã hiểu",
          style: textHeadline1,
        ),
      ),
    ],
  );
}
