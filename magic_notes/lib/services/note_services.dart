import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_notes/models/data_response.dart';
import 'package:magic_notes/utils/constants.dart';

import '../models/note.dart';
import '../models/user.dart';

class NoteServices {
  final BASE_URL = Constants.BASE_URL;

  //Luôn cần dùng async await vì load dữ liệu cần có thời gian
  //Thao tác lấy dữ liệu
  Future<DataResponse?> getNotes(String userId) async {
    DataResponse? dataResponse;
    try {
      // print("Dữ liệu vào: $userId");
      Response response = await dio.get("$BASE_URL/notes?userid=$userId&&sort=dsc");
      //print(response.data);

      dataResponse = DataResponse.fromJson(response.data);
      return dataResponse;
    } catch (e) {
      // print(e);
      // print(Exception(e));
      throw Exception(e);
    }
  }

  //Thao tác thêm mới
  Future<DataResponse?> addNote({required String userId, required Note note}) async {
    try {
      // Lấy thông tin
      final data = note.toJsonAddNote();
      Response? response = await dio.post("$BASE_URL/notes?userid=$userId", data: data);
      return DataResponse.fromJson(response.data);
    } catch (e) {
      // print(e);
      throw Exception(e);
    }
  }

  //Thao tác cập nhật
  Future<DataResponse?> updateNote({required String userId, required Note note}) async {
    try {
      // Lấy thông tin
      final data = note.toJsonUpdateNote();
      Response? response = await dio.put("$BASE_URL/notes?userid=$userId", data: data);
      return DataResponse.fromJson(response.data);
    } catch (e) {
      // print(e);
      throw Exception(e);
    }
  }

  //Thao tác xóa
  Future<DataResponse?> deleteNote({required String userId, required String noteId}) async {
    try {
      // Lấy thông tin
      final data = {"noteId": noteId};
      Response? response = await dio.delete("$BASE_URL/notes?userid=$userId", data: data);
      return DataResponse.fromJson(response.data);
    } catch (e) {
      // print(e);
      throw Exception(e);
    }
  }
}

final noteServicesPr = Provider<NoteServices>((ref) => NoteServices());
