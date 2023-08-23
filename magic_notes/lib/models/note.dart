import 'package:intl/intl.dart';

class Note {
  String? noteId;
  String? noteTitle;
  String? noteDescription;
  String? noteCreatedTime;
  String? noteState;

  Note({this.noteId, this.noteTitle, this.noteDescription, this.noteCreatedTime, this.noteState});

  Note.fromJson(Map<String, dynamic> json) {
    final DateFormat formatter = DateFormat('HH:mm dd-MM-yyyy');
    final toDateTime = DateTime.parse(json['noteCreatedTime']);
    final String formatted = formatter.format(toDateTime);
    noteId = json['noteId'];
    noteTitle = json['noteTitle'];
    noteDescription = json['noteDescription'];
    noteCreatedTime = formatted;
    noteState = json['noteState'];
  }

  Map<String, dynamic> toJsonAddNote() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['noteTitle'] = noteTitle;
    data['noteDescription'] = noteDescription;
    data['noteState'] = noteState;
    return data;
  }

  Map<String, dynamic> toJsonUpdateNote() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['noteId'] = noteId;
    data['noteTitle'] = noteTitle;
    data['noteDescription'] = noteDescription;
    data['noteState'] = noteState;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['noteId'] = noteId;
    data['noteTitle'] = noteTitle;
    data['noteDescription'] = noteDescription;
    data['noteCreatedTime'] = noteCreatedTime;
    data['noteState'] = noteState;
    return data;
  }

  @override
  String toString() {
    return 'Note{noteId: $noteId, noteTitle: $noteTitle, noteDescription: $noteDescription, noteCreatedTime: $noteCreatedTime, noteState: $noteState}';
  }

  Note copyWith({
    String? noteId,
    String? noteTitle,
    String? noteDescription,
    String? noteCreatedTime,
    String? noteState,
  }) {
    return Note(
      noteId: noteId ?? this.noteId,
      noteTitle: noteTitle ?? this.noteTitle,
      noteDescription: noteDescription ?? this.noteDescription,
      noteCreatedTime: noteCreatedTime ?? this.noteCreatedTime,
      noteState: noteState ?? this.noteState,
    );
  }
}
