import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_notes/utils/style.dart';

Widget dialogNotification(BuildContext context, String title, String message) {
  return Animate(
    effects: const [
      FlipEffect(duration: Duration(milliseconds: 200),direction: Axis.vertical)
    ],
    child: AlertDialog(
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
    ),
  );
}
