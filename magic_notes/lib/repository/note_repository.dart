import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_notes/models/data_response.dart';
import 'package:magic_notes/services/note_services.dart';

import '../models/note.dart';

class NoteRepository {
  NoteServices noteServices;

  NoteRepository({
    required this.noteServices,
  });

  Future<DataResponse?> getNotes(String userId) async {
    var response = await noteServices.getNotes(userId);
    return response;
  }

  Future<DataResponse?> addNote(String userId, Note note) async {
    var response = await noteServices.addNote(userId: userId, note: note);
    return response;
  }

  Future<DataResponse?> updateNote(String userId, Note note) async {
    var response = await noteServices.updateNote(userId: userId, note: note);
    return response;
  }

  Future<DataResponse?> deleteNote(String userId, String noteId) async {
    var response = await noteServices.deleteNote(userId: userId, noteId: noteId);
    return response;
  }

  Future<DataResponse?> searchNotes(String userId, String search) async {
    var response = await noteServices.searchNotes(userId, search);
    return response;
  }
}

final noteRepositoryPr = Provider<NoteRepository>(
  (ref) {
    final noteServices = ref.read(noteServicesPr);
    return NoteRepository(noteServices: noteServices);
  },
);
