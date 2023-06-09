import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_notes/providers/user_provider.dart';
import 'package:magic_notes/utils/style.dart';
import 'package:mime/mime.dart';
import '../../utils/constants.dart';
import 'dialog_notification.dart';

//Nói chung người ta hay bảo nên dùng ConsumerWidget là đủ
//Tuy nhiên, trong nhiều trường hợp, không nên bó buộc tư duy trong code
class DialogUserPhoto extends ConsumerStatefulWidget {
  late String photoURL;

  DialogUserPhoto({
    required this.photoURL,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _DialogUserPhotoState();
}

class _DialogUserPhotoState extends ConsumerState<DialogUserPhoto> {
  dynamic photo;
  dynamic newPhotoURL;
  bool saveImage = false;

  @override
  void initState() {
    super.initState();
    photo = imageLocal == null ? NetworkImage(widget.photoURL) : MemoryImage(imageLocal!);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.orangeAccent.shade200,
      title: Text(
        "Ảnh đại diện",
        style: textHeadline1,
      ),
      content: SizedBox(
        height: 300,
        width: 500,
        child: Image(image: photo, fit: BoxFit.contain),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            FilePickerResult? pickFile; //Ảnh được chọn
            if (kIsWeb) {
              pickFile = await FilePicker.platform.pickFiles(
                allowMultiple: false, //Chỉ chọn 1 ảnh
                type: FileType.any, // Loại file bất kỳ
              );
              //Kiểm tra loại File
              if (pickFile == null) return; //Không có ảnh thì thôi
              final pickFileType = lookupMimeType(pickFile!.files.first.name);
              // final files = result.files; //EDIT: THIS PROBABLY CAUSED YOU AN ERROR
              newPhotoURL = await pickFile.files.first.bytes;
              final int size = await pickFile!.files.first.bytes!.length;
              if (!pickFileType!.contains("image/jpeg") || size > 1602392) {
                // ignore: use_build_context_synchronously
                showDialog(
                  context: context,
                  builder: (context) {
                    return dialogNotification(context, "CHÚ Ý", "Định dạng ảnh phải là JPG, PNG hoặc JPEG!\nẢnh phải có kích thước dưới 1.5MB!");
                  },
                );
              } else {
                //Cập nhật hiển thị
                imageLocal = newPhotoURL; //Cập nhật thẳng
                setState(() {
                  photo = MemoryImage(imageLocal!);
                  saveImage = true;
                });
              }
            } else {
              pickFile = await FilePicker.platform.pickFiles(
                allowMultiple: false, //Chỉ chọn 1 ảnh
                type: FileType.custom, //Loại custom tùy chỉnh kiểu dữ liệu
                allowedExtensions: ['jpg', 'png', 'jpeg'], //Loại dữ liệu
              );
              if (pickFile == null) return; //Không có ảnh thì thôi
              // final files = result.files; //EDIT: THIS PROBABLY CAUSED YOU AN ERROR
              newPhotoURL = await pickFile.files.first.path.toString();
              var size = await File(newPhotoURL).lengthSync();
              // print(size);
              if (size > 1602392) {
                // ignore: use_build_context_synchronously
                showDialog(
                  context: context,
                  builder: (context) {
                    return dialogNotification(context, "CHÚ Ý", "Ảnh phải có kích thước dưới 1.5MB!");
                  },
                );
              } else {
                //Cập nhật hiển thị
                photo = FileImage(File(newPhotoURL));
                setState(() {
                  //print(newPhotoURL);
                  saveImage = true;
                });
              }
            }
          },
          child: Text(
            "Chọn ảnh đại diện",
            style: textHeadline1,
          ),
        ),
        if (saveImage)
          TextButton(
            onPressed: () {
              if (kIsWeb) {
                final bytes = newPhotoURL; //Định dạng bytes sẵn rồi nên không cần!
                //Định dạng base64
                String img64 = base64Encode(bytes);
                ref.read(userProvider).changeUserPhoto(USER_ID, img64);
                setState(() {
                  //Lưu trữ local để hiển thị
                  //Lí do kỹ thuật!
                  imageLocal = base64Decode(img64);
                  ref.read(userProvider).getUserPhoto(USER_ID); //Chỉnh lại, tăng tốc nhanh hơn!
                  context.pop();
                });
              } else {
                final bytes = File(newPhotoURL).readAsBytesSync();
                //Định dạng base64
                String img64 = base64Encode(bytes);
                ref.read(userProvider).changeUserPhoto(USER_ID, img64);
                setState(() {
                  //Lưu trữ local để hiển thị
                  //Lí do kỹ thuật!
                  imageLocal = base64Decode(img64);
                  ref.read(userProvider).getUserPhoto(USER_ID); //Chỉnh lại, tăng tốc nhanh hơn!
                  context.pop();
                });
              }
            },
            child: Text(
              "Lưu ảnh",
              style: textHeadline1,
            ),
          ),
      ],
    );
  }
}
