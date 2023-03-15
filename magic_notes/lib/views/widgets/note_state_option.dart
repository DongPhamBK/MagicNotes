import 'dart:io';

import 'package:flutter/material.dart';

final List<String> noteStates = ['Unstarted', 'In Process', 'Done'];
final List<String> noteStateTitles = ['Chưa bắt đầu', 'Đang thực hiện', 'Hoàn thành'];

class NoteStateOption extends StatefulWidget {
  var currentState = noteStates[0];

  NoteStateOption({Key? key}) : super(key: key);

  @override
  State<NoteStateOption> createState() => _NoteStateOptionState();

  String getState() {
    return currentState;
  }

  setState(String state) {
    noteStates.forEach((element) {
      if (element == state) {
        currentState = element;
      }
    });
  }
}

class _NoteStateOptionState extends State<NoteStateOption> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getWith(),
      height: 65,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Row(
            children: [
              Container(
                color: Colors.white,
                width: getWith()/3,
                height: 65,
                child: RadioListTile(
                  title: Text(noteStateTitles[index]),
                  value: noteStates[index],
                  groupValue: widget.currentState,
                  onChanged: (value) {
                    setState(() {
                      widget.currentState = value.toString();
                    });
                  },
                ),
              ),
              const SizedBox(
                width: 1,
              ),
            ],
          );
        },
        itemCount: noteStates.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  double getWith() {
    final width = MediaQuery.of(context).size.width;
    if (Platform.isAndroid || Platform.isIOS) {
      return width - 10.0;
    } else {
      if (width > 510.0) {
        return 500.0;
      } else {
        return width - 10;
      }
    }
  }
}
