import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:app/config/config.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper _instance = DatabaseHelper._();
  factory DatabaseHelper() {
    return _instance;
  }

  Database _db;
  Future<Database> get db async {
    if (_db == null) {
      _db = await initDb();
    }
    return _db;
  }

  Future<Database> initDb() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, Config.dbName);
    return await openDatabase(path,
        version: Config.dbVersion,
        readOnly: false,
        singleInstance: true,
        onOpen: (Database db) {},
        onCreate: (Database db, int version) {},
        onConfigure: (Database db) {},
        onUpgrade: (Database db, int oldVersion, int newVersion) {},
        onDowngrade: (Database db, int oldVersion, int newVersion) {});
  }
}
