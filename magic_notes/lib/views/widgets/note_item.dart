import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_notes/utils/style.dart';

import '../../models/note.dart';

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
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
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
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    note.noteState.toString(),
                    style: textContent.copyWith(color: Colors.deepOrangeAccent),
                  ),
                  const Divider(
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
            ),
          ),
        ),
      ),
      onTap: () {
        context.push('/detail', extra: note);
      },
    );
  }
}
