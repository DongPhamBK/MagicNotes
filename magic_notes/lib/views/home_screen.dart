import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_notes/models/note.dart';
import 'package:magic_notes/providers/note_provider.dart';
import 'package:magic_notes/views/responsive.dart';
import 'package:magic_notes/views/widgets/note_item.dart';
import 'package:magic_notes/views/widgets/user_info.dart';

import '../providers/user_provider.dart';

class HomeScreen extends ConsumerWidget {
  String? userId;

  HomeScreen({
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //ref.refresh(noteListProvider(userId!));
    // Cập nhật lại danh sách mỗi khi làm mới trang
    print("Build! ${DateTime.now()}");
    final notes = ref.watch(noteListProvider(userId!));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              //Lấy thông tin người dùng trước tiên
              ref.read(userProvider).getUserInfo(userId!);
              ref.read(userProvider).getUserPhoto(userId!);
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 25),
            icon: Icon(Icons.search),
            onPressed: () async {
              final String? result = await context.pushNamed<String>('/search');
              print("Giá trị sau push $result");
            },
          ),
        ],
        title: Text("MagicNotes"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: notes.when(
          data: (data) {
            final list = data?.data as List;
            final List<Note> listNote = list.map((note) => Note.fromJson(note)).toList();
            if (Responsive.isMobile(context)) {
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
              //Khá ảo
              return Theme(
                data: Theme.of(context).copyWith(
                  scrollbarTheme: ScrollbarThemeData(
                    //thumbColor: MaterialStateProperty.all(Colors.red), //Màu thanh cuộn
                    thickness: MaterialStateProperty.all(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Center(
                    child: Wrap(
                      spacing: 8.0, // gap between adjacent chips
                      runSpacing: 4.0, // gap between lines
                      children: List.generate(listNote.length, (index) {
                        return NoteItem(note: listNote[index]);
                      }),
                    ),
                  ),
                ),
              );
            }
          },
          error: (error, stackTrace) {
            return Center(child: Text("Có lỗi xảy ra, vui lòng chờ chút hoặc mở lại ứng dụng của bạn!"));
          },
          loading: () => Center(child: CircularProgressIndicator(color: Colors.orange)),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          heroTag: "addnote", // Nếu có nhiều hơn floatButton/màn hình
          backgroundColor: Colors.orange,
          onPressed: () {
            context.push('/addnote');
          },
          label: Row(
            children: [
              Icon(Icons.add),
              Text(" Thêm mới!"),
            ],
          )),
      drawer: Drawer(
        width: 300,
        child: UserInfo(userId: userId!),
      ),
    );
  }
}
