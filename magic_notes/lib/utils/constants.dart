import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static const BASE_URL = "https://dongpt.pythonanywhere.com/v1";
}

final options = BaseOptions(
  baseUrl: Constants.BASE_URL,
  receiveDataWhenStatusError: true,
  connectTimeout: const Duration(seconds: 60),
  // 60 giây
  receiveTimeout: const Duration(seconds: 60),
  // 60 giây
  sendTimeout: const Duration(seconds: 60),
  //60 giây
  validateStatus: (status) => true,
  // Luôn nhận dữ liệu bất chấp server trả về code bao nhiêu, cái này hợp lí nè!
);
final Dio dio = Dio(options);

//Mã User dùng cho nhiều trường hợp
String USER_ID = "";

//Quá gắt
BuildContext? GLOBAL_CONTEXT = null;

extension convert on String {
  String toVietnamese() {
    switch (this) {
      case "Unstarted":
        return "Chưa bắt đầu";
      case "In Process":
        return "Đang tiến hành";
      default:
        return "Xong";
    }
  }
}

//Mã lưu mật khẩu
SharedPreferences? prefs = null;

//Lưu ảnh hiện tại
Uint8List? imageLocal = null;
