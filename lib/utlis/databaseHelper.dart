import 'dart:io';

import 'package:notekeeper/moels/note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;
  String noteTable = 'Note_Table';
  String colId = "id";
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';
  DatabaseHelper._createInstance();
  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }
  Future<Database?> get database async {
    _database ??= await intializeDatabase();

    return _database;
  }

  Future intializeDatabase() async {
    Directory directory = await getApplicationCacheDirectory();
    String path = directory.path + 'notes.db';
    var notesDatabase = await (path, version: 1, onCreate: _creatDb);
    return notesDatabase;
  }

  void _creatDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colTitle TEXT,$colDescription TEXT,$colPriority INTEGER, $colDate TEXT)");
  }

  getNoteMapList() async {
    Database? db = await this.database;
    // var result = await db!
    //     .rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db!.query(noteTable, orderBy: '$colPriority ASC');
    return result;
  }

  Future<int> insertNote(Note note) async {
    Database? db = await this.database;
    var result = await db!.insert(noteTable, note.toMap());
    return result;
  }

  Future<int> updateNote(Note note) async {
    var db = await this.database;
    var result = await db!.update(noteTable, note.toMap(),
        where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result =
        await db!.rawDelete("DELETE FROM $noteTable WHERE $colId = $id");
    return result;
  }

  Future<int?> getCount() async {
    Database? db = await this.database;
    List<Map<String, dynamic>> x =
        await db!.rawQuery('SELECT COUNT (*) FROM $noteTable');
    int? result = Sqflite.firstIntValue(x);
    return result;
  }
}
