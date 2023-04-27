import 'package:flutter/material.dart';

import '../responsive.dart';

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
    for (var element in noteStates) {
      if (element == state) {
        currentState = element;
      }
    }
  }
}

class _NoteStateOptionState extends State<NoteStateOption> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(10),
      // ),
      height: 125,
      width: getWith() + 20,
      child: Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Responsive.isDesktop(context) ? noteStateOptionWindows(index): noteStateOption(index);
          },
          itemCount: noteStates.length,
          scrollDirection: Responsive.isDesktop(context)? Axis.horizontal : Axis.vertical,
        ),
      ),
    );
  }

  double getWith() {
    final width = MediaQuery.of(context).size.width;
    if (Responsive.isMobile(context)) {
      return width - 10.0;
    } else {
      if (width > 510.0) {
        return 500.0;
      } else {
        return width - 10;
      }
    }
  }

  Widget noteStateOptionWindows(int index){
    return Center(
      child: Row(
        children: [
          Container(
            color: Colors.white,
            width: getWith()/3,
            height: 75,
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
        ],
      ),
    );
  }
  Widget noteStateOption(int index){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          color: Colors.white,
          height: 39,
          child: RadioListTile(
            title: Text(noteStateTitles[index], style: TextStyle(fontSize: 12),),
            value: noteStates[index],
            groupValue: widget.currentState,
            onChanged: (value) {
              setState(() {
                widget.currentState = value.toString();
              });
            },
          ),
        ),
      ],
    );
  }
}
