import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

Widget buttonText(String label, Function callback) {
  return Animate(
    effects: const [
      ScaleEffect(
        curve: Curves.easeInOutCubicEmphasized,
        duration: Duration(milliseconds: 200),
        alignment: Alignment.center
      ),
    ],
    child: FloatingActionButton.extended(
      heroTag: "buttonText", // Nếu có nhiều hơn floatButton/màn hình
      label: Text(label),
      onPressed: () {
        callback();
      },
      backgroundColor: Colors.orange,
    ),
  );
}
