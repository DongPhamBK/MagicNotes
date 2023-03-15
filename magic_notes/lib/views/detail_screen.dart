import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_notes/providers/note_provider.dart';
import 'package:magic_notes/views/widgets/button.dart';
import 'package:magic_notes/views/widgets/dialog_confirm.dart';

import '../models/note.dart';
import '../utils/constants.dart';
import '../utils/style.dart';

class DetailScreen extends ConsumerWidget {
  Note note;

  DetailScreen({
    required this.note,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController noteDescriptionController = TextEditingController();
    noteDescriptionController.text = note.noteDescription!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          note.noteTitle.toString(),
          style: textHeadline1.copyWith(
            overflow: TextOverflow.ellipsis,
          ),
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 20),
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => dialogConfirm(
                  context,
                  "XÓA GHI CHÚ",
                  "Bạn chắc chắn muốn xóa ghi chú này?",
                  () {
                    ref.read(noteProvider).deleteNote(USER_ID, note.noteId!);
                    context.goNamed('/home', params: {'userId': USER_ID});
                  },
                ),
              );
            },
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Nội dung",
                    style: textHeadline1.copyWith(color: Colors.deepOrange),
                  ),
                  SizedBox(
                    width: Platform.isAndroid || Platform.isIOS ? MediaQuery.of(context).size.width - 10 :500,
                    height: MediaQuery.of(context).size.height - 260,
                    child: SingleChildScrollView(
                      child: TextField(
                        //expands: true, //Mở rộng tối đa
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.multiline,
                        maxLines: 100,
                        enabled: false,
                        controller: noteDescriptionController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Nhập nội dung ghi chú của bạn!',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Trạng thái hiện tại: ${note.noteState}",
                        style: textContent.copyWith(color: Colors.black),
                      ),
                      //noteState,
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Thời gian tạo(sửa) ghi chú: ${note.noteCreatedTime}",
                        style: textContent.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buttonText("Cập nhật ghi chú", () {
                    context.pushNamed('/updatenote', extra: note);
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
