import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:magic_notes/utils/style.dart';

Widget dialogConfirm(BuildContext context, String title, String message, Function callback) {
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
            callback();
          },
          child: Text(
            "Xác nhận",
            style: textHeadline1,
          ),
        ),
      ],
    ),
  );
}
