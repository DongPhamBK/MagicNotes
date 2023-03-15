import 'package:flutter/material.dart';

Widget buttonText(String label, Function callback) {
  return FloatingActionButton.extended(
    heroTag: "buttonText",// Nếu có nhiều hơn floatButton/màn hình
    label: Text(label),
    onPressed: () {
      callback();
    },
    backgroundColor: Colors.orange,
  );
}
