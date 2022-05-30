import 'package:flutter/material.dart';
import 'package:flutter_todo_app/database/database.dart';
import 'package:flutter_todo_app/models/note.dart';
import 'package:flutter_todo_app/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/text_styles.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _textController = TextEditingController();
  int _selectedIndex = 0;

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'home');
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            )),
        actions: const [
          Icon(Icons.notifications_none_outlined,
              color: Colors.white, size: 30),
          Icon(Icons.grid_view_outlined, color: Colors.white, size: 30),
          SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              style: titleTextStyle,
              cursorColor: Colors.white,
              maxLines: 1,
              minLines: 1,
              decoration: InputDecoration(
                hintText: "Title",
                hintStyle: titleTextStyle.copyWith(color: Colors.grey),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: bgColor),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: bgColor),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: _textController,
              style: bodyTextStyle,
              cursorColor: Colors.white,
              minLines: 3,
              maxLines: 12,
              decoration: InputDecoration(
                hintText: "Type something...",
                hintStyle: bodyTextStyle,
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: bgColor),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: bgColor),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 120,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.black.withOpacity(0.5), width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            noteColors.length,
            (index) => noteColorWidget(
                color: noteColors[index],
                index: index,
                onPressed: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(Icons.check, color: Color(0xFFff8e1b), size: 35),
        onPressed: () {
          if (_titleController.text.isNotEmpty &&
              _textController.text.isNotEmpty) {
            DBProvider.db.insertNote(
              Note(
                title: _titleController.text,
                text: _textController.text,
                color: _selectedIndex,
              ),
            );
            _titleController.clear();
            _textController.clear();
            Navigator.pushReplacementNamed(context, 'home');
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget noteColorWidget({
    required Color color,
    required int index,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60,
        width: 60,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: _selectedIndex == index
            ? const Icon(
                Icons.check,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
