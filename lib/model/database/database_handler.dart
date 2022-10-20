import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHandler {

  Future <Database> initDatabase() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'habit.db'),
      onCreate: (database, version) async {
        await onCreate(database, version);
      },
      version: 1,
    );
  }

  Future onCreate(Database db, int version) async {
    await db.execute("create table Habit("
        "idHabit INTEGER primary key not null,"
        "Fk_idRepeat INTEGER not null"
        "habitName TEXT,"
        "startDate TEXT,"
        "endDate TEXT,"
        "image TEXT,"
        "note TEXT,"
        "nbDateFinish long,"
        "FOREIGN KEY (Fk_idRepeat) REFERENCES Repeat (idRepeat),"
        ")");

    await db.execute("create table Repeat("
        "idRepeat INTEGER primary key not null,"
        "nbOfDateRepeat INTEGER,"
        "startDate TEXT,"
        "endDate TEXT,"
        "image TEXT,"
        "note TEXT,"
        "FOREIGN KEY (Fk_idRepeat) REFERENCES Repeat (idRepeat),"
        ")");
  }

}
