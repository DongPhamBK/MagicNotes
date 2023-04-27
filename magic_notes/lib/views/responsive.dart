// Phần quan trọng nhất trong xác định giao diện
// Responsive sẽ đo đạc kích thước màn hình để hiển thị giao diện tương ứng
import 'package:flutter/material.dart';

//Lớp Responsive hỗ trợ phản ứng thay đổi kích thước các loại màn hình
class Responsive extends StatelessWidget {
  //Giao diện tương ứng cho từng loại màn hình
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

  //Kiểm tra kích thước và xác định loại màn hình
  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 850;

  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width < 1100 && MediaQuery.of(context).size.width >= 850;

  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    if (screenSize.width >= 1100) {
      return desktop;
    } else if (screenSize.width >= 850 && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}
