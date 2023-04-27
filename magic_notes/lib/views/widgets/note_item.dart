import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_notes/utils/constants.dart';
import 'package:magic_notes/utils/style.dart';

import '../../models/note.dart';
import '../responsive.dart';

class NoteItem extends StatelessWidget {
  late Note note;

  NoteItem({
    required this.note,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        height: 250,
        width: 250,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10.0,
          shadowColor: Colors.orange,
          child: SizedBox(
            height: 50,
            child: Responsive.isDesktop(context) || Responsive.isTablet(context) ? noteItemWindows() : noteItemMobile(),
          ),
        ),
      ),
      onTap: () {
        context.push('/detail', extra: note);
      },
    );
  }

  Widget noteItemWindows() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              //color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
              gradient: LinearGradient(colors: [
                Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.8)
              ]),
            ),
            padding: EdgeInsets.only(left: 5.5, right: 2.5),
            child: Text(
              note.noteTitle.toString(),
              style: textHeadline1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 102,
            child: Text(
              note.noteDescription.toString(),
              style: textContent,
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            (note.noteState.toString()).toVietnamese(),
            style: textContent.copyWith(color: Colors.deepOrangeAccent),
          ),
          Divider(
            color: Colors.pink,
            thickness: 1.5,
            indent: 1,
            endIndent: 10,
          ),
          Text(
            note.noteCreatedTime.toString(),
            style: textContent.copyWith(color: Colors.deepOrange),
          )
        ],
      ),
    );
  }

  Widget noteItemMobile() {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              //color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
              gradient: LinearGradient(colors: [
                Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.8)
              ]),
            ),
            padding: EdgeInsets.only(left: 5.5, right: 2.5),
            child: Text(
              note.noteTitle.toString(),
              style: textHeadline1.copyWith(fontSize: 18),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 82,
            child: Text(
              note.noteDescription.toString(),
              style: textContent.copyWith(fontSize: 14),
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            (note.noteState.toString()).toVietnamese(),
            style: textContent.copyWith(color: Colors.deepOrangeAccent, fontSize: 12.5),
          ),
          Divider(
            color: Colors.pink,
            thickness: 1.5,
            indent: 1,
            endIndent: 10,
          ),
          Text(
            note.noteCreatedTime.toString(),
            style: textContent.copyWith(color: Colors.deepOrange, fontSize: 12.5),
          )
        ],
      ),
    );
  }
}
