import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_notes/models/note.dart';
import 'package:magic_notes/providers/note_provider.dart';
import 'package:magic_notes/views/responsive.dart';
import 'package:magic_notes/views/widgets/note_item.dart';

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

    return WillPopScope(
      onWillPop: () async {
        context.pop<String>("trả về push nút back trên mobile");
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            //Leading để xử lí một số tác vụ khác
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => context.pop<String>("trả về push"),
            ),
            //toolbarHeight: 56,//Độ cao toolbar
            backgroundColor: Colors.orange,
            title: TextField(
              maxLines: 1,
              keyboardType: TextInputType.text,
              //autocorrect: true,
              controller: textSearchController,
              autofocus: true,
              showCursor: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(2.5), //Phân cách đệm
                enabledBorder: OutlineInputBorder(
                  //dùng enable thay vì border
                  borderSide: BorderSide(color: Colors.white), //màu viền
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
            child: Builder(
              builder: (context) {
                final list = (dataResponse != null && dataResponse.data != "null") ? dataResponse!.data as List : [];
                final List<Note> listNote = list.map((note) => Note.fromJson(note)).toList();
                if (listNote.isEmpty) {
                  return Center(
                    child: Text('Không tìm thấy kết quả nào!'),
                  );
                }
                if(isLoading) return Center(child: CircularProgressIndicator(color: Colors.orange));
                if (Responsive.isMobile(context)) {
                  return Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.86,
                        scrollDirection: Axis.vertical,
                        children: List.generate(
                          listNote.length,
                          (index) {
                            return NoteItem(note: listNote[index]);
                          },
                        ),
                      ),
                    ),
                  );
                } else {
                  return SingleChildScrollView(
                    child: Center(
                      child: Wrap(
                        spacing: 8.0, // gap between adjacent chips
                        runSpacing: 4.0, // gap between lines
                        children: List.generate(
                          listNote.length,
                          (index) {
                            return NoteItem(note: listNote[index]);
                          },
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
