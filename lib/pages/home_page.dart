import 'package:flutter/material.dart';
import 'package:flutter_todo_app/database/database.dart';
import 'package:flutter_todo_app/models/note.dart';
import 'package:flutter_todo_app/utils/colors.dart';
import 'package:flutter_todo_app/utils/text_styles.dart';

import '../widgets/note_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Note>>? _noteObj;

  @override
  void initState() {
    super.initState();
    updateNotes();
  }

  Future<void> updateNotes() async {
    setState(() {
      _noteObj = DBProvider.db.getNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Reminders',
          style: titleTextStyle,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: updateNotes,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<List<Note>>(
                future: _noteObj,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data;
                    return Expanded(
                      child: GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        children: data!
                            .map<Widget>(
                              (note) => NoteWidget(
                                size: size,
                                id: note.id!,
                                title: note.title,
                                text: note.text,
                                color: noteColors[note.color],
                              ),
                            )
                            .toList(),
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bgColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu, color: Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.grey),
            label: '',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Color(0xFFff8e1b), size: 35),
        onPressed: () {
          Navigator.pushReplacementNamed(context, 'add');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}


