import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class UserTable {

  static final _databaseName = "User_database.db";
  static final _databaseVersion = 1;

  static final table = 'User_Table';

  static final columnId = 'ID_USER';
  static final columnName = 'name';
  static final columnAge = 'age';
  static final columnMail = 'mail';
  static final columnPass = 'pass';

  static final listColumnUser = [UserTable.columnId, UserTable.columnName, UserTable.columnAge, UserTable.columnMail, UserTable.columnPass];

  // make this a singleton class
  UserTable._privateConstructor();
  static final UserTable instance = UserTable._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path1 = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path1,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnAge INTEGER NOT NULL,
            $columnMail TEXT NOT NULL,
            $columnPass TEXT NOT NULL
          )
          ''');
  }

  // Helper methods
  Future<void> insertUser(Map<String, dynamic> row) async {
    Database db = await instance.database;
    await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List> queryRows(int id) async {
    Database db = await instance.database;
    return await db.rawQuery('select * from $table where $columnId = ?', [id]);
  }
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<void> updateUser(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteUser(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

}

