import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_notes/models/data_response.dart';
import 'package:magic_notes/models/user.dart';
import 'package:magic_notes/repository/note_repository.dart';
import 'package:magic_notes/repository/user_repository.dart';

import '../models/note.dart';

class NoteNotifier extends ChangeNotifier {
  late NoteRepository noteRepository;
  bool isLoading = false;
  DataResponse? dataResponse;
  String? noteResult = "";
  String? signUpResult = "";
  User? userInfo;

  NoteNotifier({required this.noteRepository});

  /*Future<DataResponse?> getNotes(String userId) async {
    isLoading = true;
    notifyListeners();
    dataResponse = await noteRepository.getNotes(userId);
    noteResult = dataResponse?.message.toString();
    isLoading = false;
    notifyListeners();
    return dataResponse;
  }*/

  Future<DataResponse?> addNote(String userId, Note note) async {
    isLoading = true;
    notifyListeners();
    dataResponse = await noteRepository.addNote(userId, note);
    signUpResult = dataResponse?.message.toString();
    isLoading = false;
    notifyListeners();
    return dataResponse;
  }

  Future<DataResponse?> updateNote(String userId, Note note) async {
    isLoading = true;
    notifyListeners();
    dataResponse = await noteRepository.updateNote(userId, note);
    signUpResult = dataResponse?.message.toString();
    isLoading = false;
    notifyListeners();
    return dataResponse;
  }

  Future<DataResponse?> deleteNote(String userId, String noteId) async {
    isLoading = true;
    notifyListeners();
    dataResponse = await noteRepository.deleteNote(userId, noteId);
    signUpResult = dataResponse?.message.toString();
    isLoading = false;
    notifyListeners();
    return dataResponse;
  }
}

final noteProvider = ChangeNotifierProvider((ref) {
  NoteRepository noteRepository = ref.watch(noteRepositoryPr);
  return NoteNotifier(noteRepository: noteRepository);
});

final noteListProvider = FutureProvider.family<DataResponse?, String>((ref, userId) {
  var data = ref.watch(noteRepositoryPr).getNotes(userId);
  //Cập nhật sau mỗi 5 giây
  final timer = Timer(const Duration(seconds: 10), () {
    ref.invalidateSelf();
  });
  ref.onDispose(timer.cancel);

  return data;
});
