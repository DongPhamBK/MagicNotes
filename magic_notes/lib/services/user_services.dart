import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_notes/models/data_response.dart';
import 'package:magic_notes/utils/constants.dart';

import '../models/user.dart';

class UserServices {
  final BASE_URL = Constants.BASE_URL;

  //Luôn cần dùng async await vì load dữ liệu cần có thời gian
  //Thao tác đăng nhập
  Future<DataResponse?> logIn(User user) async {
    DataResponse? dataResponse;
    try {
      // Lấy email và mật khẩu thôi
      final data = user.toJsonLogin();
      //print("Dữ liệu vào: $data");
      Response response = await dio.post("$BASE_URL/login", data: data);
      //print(response.data);

      dataResponse = DataResponse.fromJson(response.data);
      return dataResponse;
    } on DioError catch (e) {
      // Xử lí time out
      return DataResponse(status: "time out", code: 400, data: "", message: e.toString());
      //throw Exception(ex.message);
    } catch (e) {
      // print(e);
      throw Exception(e);
    }
  }

  //Thao tác đăng ký
  Future<DataResponse?> signUp(User user) async {
    try {
      // Lấy thông tin
      final data = user.toJson();
      Response? response = await dio.post("$BASE_URL/signup", data: data);
      return DataResponse.fromJson(response.data);
    }on DioError catch (e) {
      // Xử lí time out
      return DataResponse(status: "time out", code: 400, data: "nulll", message: e.toString());
      //throw Exception(ex.message);
    }  catch (e) {
      // print(e);
      throw Exception(e);
    }
  }

  //Thao tác lấy thông tin người dùng
  Future<DataResponse?> getUserInfo(String userId) async {
    DataResponse? dataResponse;
    try {
      //print("Dữ liệu vào: $data");
      Response response = await dio.get("$BASE_URL/users?userid=$userId");
      //print(response.data);
      dataResponse = DataResponse.fromJson(response.data);
      return dataResponse;
    } on DioError catch (e) {
      // Xử lí time out
      return DataResponse(status: "time out", code: 400, data: "null", message: e.toString());
      //throw Exception(ex.message);
    } catch (e) {
      //print(e);
      //print(Exception(e));
      throw Exception(e);
    }
  }

  //Thao tác thay đổi thông tin người dùng
  Future<DataResponse?> changeUserInfo(String userId, String userName, String userDescription) async {
    DataResponse? dataResponse;
    try {
      //print("Dữ liệu vào: $data");
      final data = {"userName": userName, "userDescription": userDescription};
      Response response = await dio.post("$BASE_URL/users?userid=$userId", data: data);
      //print(response.data);
      dataResponse = DataResponse.fromJson(response.data);
      return dataResponse;
    } on DioError catch (e) {
      // Xử lí time out
      return DataResponse(status: "time out", code: 400, data: "null", message: e.toString());
      //throw Exception(ex.message);
    } catch (e) {
      //print(e);
      //print(Exception(e));
      throw Exception(e);
    }
  }

  //Thao tác đổi mật khẩu
  Future<DataResponse?> changeUserPassword(String userEmail, String password, String confirmPassword) async {
    DataResponse? dataResponse;
    try {
      //print("Dữ liệu vào: $data");
      final data = {
        "userEmail": userEmail,
        "userPassword": password,
        "userConfirmPassword": confirmPassword,
      };
      Response response = await dio.put("$BASE_URL/changepassword", data: data);
      print(response.data);
      dataResponse = DataResponse.fromJson(response.data);
      return dataResponse;
    } on DioError catch (e) {
      // Xử lí time out
      return DataResponse(status: "time out", code: 400, data: "null", message: e.toString());
      //throw Exception(ex.message);
    } catch (e) {
      //print(e);
      //print(Exception(e));
      throw Exception(e);
    }
  }

  //Thao tác quên mật khẩu
  Future<DataResponse?> forgotUserPassword(String userEmail) async {
    DataResponse? dataResponse;
    try {
      //print("Dữ liệu vào: $data");
      final data = {"userEmail": userEmail};
      Response response = await dio.post("$BASE_URL/changepassword", data: data);
      print(response.data);
      dataResponse = DataResponse.fromJson(response.data);
      return dataResponse;
    } on DioError catch (e) {
      // Xử lí time out

      return DataResponse(status: "time out", code: 400, data: "null", message: e.toString());
      //throw Exception(ex.message);
    } catch (e) {
      //print(e);
      //print(Exception(e));
      throw Exception(e);
    }
  }
}

final userServicesPr = Provider<UserServices>((ref) => UserServices());
