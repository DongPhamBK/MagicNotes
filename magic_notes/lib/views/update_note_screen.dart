import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_notes/views/widgets/button.dart';
import 'package:magic_notes/views/widgets/dialog_notification.dart';
import 'package:magic_notes/views/widgets/note_state_option.dart';

import '../models/note.dart';
import '../providers/note_provider.dart';
import '../utils/constants.dart';
import '../utils/style.dart';

class UpdateNoteStcreen extends ConsumerWidget {
  late Note note;

  UpdateNoteStcreen({
    required this.note,
    Key? key,
  }) : super(key: key);

  TextEditingController noteTitleController = TextEditingController();
  TextEditingController noteDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var noteState = NoteStateOption();
    noteState.setState(note.noteState!);
    noteTitleController.text = note.noteTitle!;
    noteDescriptionController.text = note.noteDescription!;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text("Cập nhật ghi chú"),
        ),
        body: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Cập nhật tiêu đề",
                    style: textHeadline1.copyWith(color: Colors.deepOrange),
                  ),
                  SizedBox(
                    width: 500,
                    child: TextField(
                      maxLength: 100,
                      keyboardType: TextInputType.text,
                      controller: noteTitleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nhập tiêu đề ghi chú của bạn!',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Cập nhật nội dung",
                    style: textHeadline1.copyWith(color: Colors.deepOrange),
                  ),
                  SizedBox(
                    width: Platform.isAndroid || Platform.isIOS ? MediaQuery.of(context).size.width - 10 : 500,
                    height: MediaQuery.of(context).size.height - 550,
                    child: TextField(
                      //expands: true, //Mở rộng tối đa
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.multiline,
                      maxLines: 50,
                      controller: noteDescriptionController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nhập nội dung ghi chú của bạn!',
                      ),
                    ),
                  ),
                  Text(
                    "Cập nhật trạng thái hiện tại",
                    style: textHeadline1.copyWith(color: Colors.deepOrange),
                  ),
                  noteState,
                  SizedBox(
                    height: 20,
                  ),
                  buttonText(
                    "Cập nhật",
                    () async {
                      final noteTitle = noteTitleController.text;
                      final noteDescription = noteDescriptionController.text;
                      final updateNote = Note(
                        noteId: note.noteId,
                        noteTitle: noteTitle,
                        noteDescription: noteDescription,
                        noteCreatedTime: null,
                        noteState: noteState.getState(),
                      );
                      if (noteTitle.isEmpty || noteDescription.isEmpty) {
                        await showDialog(
                          context: context,
                          builder: (context) => dialogNotification(context, "CHÚ Ý:", "Không được để trống bất cứ ô nào!"),
                        );
                      } else {
                        print(USER_ID);
                        ref.read(noteProvider).updateNote(USER_ID, updateNote).then((value) async {
                          if (value!.code == 200) {
                            await Future.delayed(Duration(milliseconds: 500));
                            await showDialog(
                              context: context,
                              builder: (context) {
                                Future.delayed(Duration(seconds: 2));
                                return dialogNotification(context, "KẾT QUẢ", "Cập nhật ghi chú thành công!");
                              },
                            );
                          } else {
                            await Future.delayed(Duration(milliseconds: 500));
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return dialogNotification(context, "KẾT QUẢ", "Cập nhật ghi chú thất bại!");
                              },
                            );
                          }
                        }).then((value) => context.goNamed('/home', params: {'userId': USER_ID}));
                      }
                      //context.pop();
                      //var new_note = note.copyWith(noteTitle: noteTitle, noteDescription: noteDescription, noteState: noteState.getState(), noteCreatedTime: DateTime.now().toString());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
