import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class Constants {
  static const BASE_URL = "http://192.168.1.183:5000/v1";
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
