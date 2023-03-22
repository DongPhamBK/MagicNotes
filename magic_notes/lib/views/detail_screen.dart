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
            icon: Icon(
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
                  () async {
                    await ref.read(noteProvider).deleteNote(USER_ID, note.noteId!);
                    await ref.read(noteListProvider(USER_ID)); // cập nhật nhanh
                    context.goNamed('/home', params: {'userId': USER_ID});
                  },
                ),
              );
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Stack(
              fit: StackFit.expand,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Positioned(
                  top: 0,
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      "Nội dung",
                      style: textHeadline1.copyWith(color: Colors.deepOrange, fontSize: 18),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  bottom: 160,
                  child: Center(
                    child: SizedBox(
                      width: Platform.isAndroid || Platform.isIOS ? MediaQuery.of(context).size.width - 10 : 500,
                      child: SingleChildScrollView(
                        //reverse: true, // Xem ngược
                        child: TextField(
                          //expands: true, //Mở rộng tối đa
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.multiline,
                          maxLines: 50,
                          enabled: false,
                          controller: noteDescriptionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Nhập nội dung ghi chú của bạn!',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 80,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SizedBox(
                      width: 500,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Trạng thái hiện tại: ${note.noteState?.toVietnamese()}",
                            style: textContent.copyWith(color: Colors.black),
                          ),
                          //noteState,
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Thời gian tạo(sửa) ghi chú:\n ${note.noteCreatedTime}",
                            style: textContent.copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 40,
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 20,
                  child: Center(
                    child: buttonText("Cập nhật ghi chú", () {
                      context.pushNamed('/updatenote', extra: note);
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
