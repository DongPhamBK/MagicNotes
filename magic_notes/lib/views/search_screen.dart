import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_notes/models/note.dart';
import 'package:magic_notes/providers/note_provider.dart';
import 'package:magic_notes/views/widgets/note_item.dart';
import 'package:magic_notes/views/widgets/user_info.dart';

import '../providers/user_provider.dart';
import '../utils/constants.dart';

class SearchScreen extends ConsumerWidget {
  SearchScreen({
    Key? key,
  }) : super(key: key);

  TextEditingController textSearchController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dataResponse = ref.watch(noteProvider).dataResponse;
    var isLoading = ref.watch(noteProvider).isLoading;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: TextField(
          maxLines: 1,
          keyboardType: TextInputType.text,
          //autocorrect: true,
          controller: textSearchController,
          autofocus: true,
          showCursor: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            hintText: 'Nhập nội dung tìm kiếm của bạn!',
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              final textSearch = textSearchController.text;
              print("search");
              ref.read(noteProvider).searchNotes(USER_ID, textSearch);
            },
            padding: EdgeInsets.only(right: 18),
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Builder(
              builder: (context) {
                final list = dataResponse?.data as List;
                final List<Note> listNote = list.map((note) => Note.fromJson(note)).toList();
                if (listNote.isEmpty) {
                  return Center(
                    child: Text('Không tìm thấy kết quả nào!'),
                  );
                }
                if (Platform.isAndroid || Platform.isIOS) {
                  return Center(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.86,
                      scrollDirection: Axis.vertical,
                      children: List.generate(listNote.length, (index) {
                        return NoteItem(note: listNote[index]);
                      }),
                    ),
                  );
                } else {
                  return SingleChildScrollView(
                    child: Center(
                      child: Wrap(
                        spacing: 8.0, // gap between adjacent chips
                        runSpacing: 4.0, // gap between lines
                        children: List.generate(listNote.length, (index) {
                          return NoteItem(note: listNote[index]);
                        }),
                      ),
                    ),
                  );
                }
              },
            ),
            if (isLoading) CircularProgressIndicator(color: Colors.orange) else SizedBox(),
          ],
        ),
      ),
    );
  }
}
