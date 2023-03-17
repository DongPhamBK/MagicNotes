import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_notes/models/note.dart';
import 'package:magic_notes/providers/note_provider.dart';
import 'package:magic_notes/utils/style.dart';
import 'package:magic_notes/views/widgets/button.dart';
import 'package:magic_notes/views/widgets/dialog_notification.dart';
import 'package:magic_notes/views/widgets/note_state_option.dart';

import '../utils/constants.dart';

class AddNoteScreen extends ConsumerWidget {
  AddNoteScreen({
    Key? key,
  }) : super(key: key);

  TextEditingController noteTitleController = TextEditingController();
  TextEditingController noteDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var noteState = NoteStateOption();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Tạo ghi chú mới"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - 5,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Tiêu đề",
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
                    "Nội dung",
                    style: textHeadline1.copyWith(color: Colors.deepOrange),
                  ),
                  SizedBox(
                    width: 500,
                    height: Platform.isWindows? 300: 250,
                    child: TextField(
                      //expands: true, //Mở rộng tối đa
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.multiline,
                      maxLines: 100,
                      controller: noteDescriptionController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nhập nội dung ghi chú của bạn!',
                      ),
                    ),
                  ),
                  Text(
                    "Trạng thái hiện tại",
                    style: textHeadline1.copyWith(color: Colors.deepOrange),
                  ),
                  noteState,
                  SizedBox(
                    height: 20,
                  ),
                  buttonText(
                    "Xác nhận",
                    () {
                      final noteTitle = noteTitleController.text;
                      final noteDescription = noteDescriptionController.text;
                      final newNote = Note(
                        noteId: null,
                        noteTitle: noteTitle,
                        noteDescription: noteDescription,
                        noteCreatedTime: null,
                        noteState: noteState.getState(),
                      );
                      if (noteTitle.isEmpty || noteDescription.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => dialogNotification(context, "CHÚ Ý:", "Không được để trống bất cứ ô nào!"),
                        );
                      } else {
                        print(USER_ID);
                        ref.read(noteProvider).addNote(USER_ID, newNote).then((value) async {
                          if (value!.code == 200) {
                            await Future.delayed(Duration(milliseconds: 500));
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return dialogNotification(context, "KẾT QUẢ", "Thêm ghi chú thành công!");
                              },
                            );
                          } else {
                            await Future.delayed(Duration(milliseconds: 500));
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return dialogNotification(context, "KẾT QUẢ", "Thêm ghi chú thất bại!");
                              },
                            );
                          }
                        }).then((value) => context.pop());
                        //then then mới đúng!
                        //Cũng được
                      }
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
