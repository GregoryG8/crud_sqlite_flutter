import 'package:crud_sqlite_flutter/data_base/tables.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Db {
  String name = "DiaryApp";
  int version = 1;

  Future<Database> open() async {
    String path = join(await getDatabasesPath(), name);
    return openDatabase(path, version: version, onCreate: onCreate, onConfigure: onConfigure);
  }

  onCreate(Database db, int version)async{
    for (var scrip in tables) {
      await db.execute(scrip);
    }
  }

  onConfigure(Database db) async{
    await db.execute("PRAGMA foreign_keys = ON");
  }
}
