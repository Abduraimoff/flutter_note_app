import 'package:flutter/material.dart';

import '../database/database.dart';
import '../utils/text_styles.dart';

class NoteWidget extends StatelessWidget {
  final Size size;
  final int id;
  final String title;
  final String text;
  final Color color;

  const NoteWidget({
    Key? key,
    required this.size,
    required this.id,
    required this.title,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width / 2,
      height: 150,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleTextStyle.copyWith(fontSize: 20),
            maxLines: 1,
          ),
          const SizedBox(height: 10),
          Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: bodyTextStyle,
            maxLines: 3,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  DBProvider.db.deleteNote(id);
                  DBProvider.db.getNotes();
                },
                icon: const Icon(Icons.delete_outline),
                color: Colors.grey[600],
              ),
            ],
          )
        ],
      ),
    );
  }
}