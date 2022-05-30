import 'package:flutter_todo_app/models/note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  Database? _database;

  static int _version = 1;
  static const String _tableName = 'Notes';
  static const String _columnId = 'id';
  static const String _columnTitle = 'title';
  static const String _columnText = 'text';
  static const String _columnColor = 'color';

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDB();

    return _database;
  }

  Future<Database> _initDB() async {
    var directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'note.db');

    return await openDatabase(path, version: _version, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE $_tableName(
        $_columnId INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        $_columnTitle TEXT NOT NULL,
        $_columnText TEXT NOT NULL,
        $_columnColor INTEGER NOT NULL)''');
  }

  // READ
  Future<List<Note>> getNotes() async {
    Database? db = await database;

    final List<Map<String, dynamic>> notesMapList = await db!.query(_tableName);
    final List<Note> notesList = [];

    notesMapList.forEach((noteMap) {
      notesList.add(Note.fromMap(noteMap));
    });

    return notesList;
  }

  // INSERT // ADD

  Future<Note> insertNote(Note note) async {
    Database? db = await database;

    note.id = await db!.insert(_tableName, note.toMap());

    return note;
  }

  // UPDATE

  Future<int> updateNote(Note note) async {
    Database? db = await database;

    return await db!.update(
      _tableName,
      note.toMap(),
      where: '$_columnId = ?',
      whereArgs: [note.id],
    );
  }

  // DELETE
  Future<int> deleteNote(int? id) async {
    Database? db = await database;
    return await db!.delete(
      _tableName,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }
}
