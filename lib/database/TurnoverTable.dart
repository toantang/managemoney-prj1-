import 'dart:io';

import 'package:maganemoney/login/EventLogin.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'UserTable.dart';

class TurnoverTable {
  static final _databaseName = "Turnover_database.db";
  static final _databaseVersion = 1;

  static final table = 'Turnover_Table';

  static final columnIdTable = 'Id_Table';
  static final columnId = 'ID_USER';
  static final columnNameTurnover = 'NAME_TURNOVER';
  static final columnGroupNameTurnover = 'GROUPNAME_TURNOVER';
  static final columnMoneyTurnover = "MONEY_TURNOVER";
  static final columnDateDealTurnover = 'DATE_DEAL_TURNOVER';

  static List<String> listColumnTurnover = [
    TurnoverTable.columnIdTable, TurnoverTable.columnId, TurnoverTable.columnNameTurnover,
    TurnoverTable.columnGroupNameTurnover, TurnoverTable.columnMoneyTurnover,
    TurnoverTable.columnDateDealTurnover,
  ];

  TurnoverTable._privateConstructor();
  static final TurnoverTable instance = TurnoverTable._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path1 = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path1,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  var user_table = UserTable.table;

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (      
            $columnIdTable INTEGER NOT NULL PRIMARY KEY, 
            $columnId INTEGER NOT NULL,                            
            $columnNameTurnover TEXT NOT NULL,
            $columnGroupNameTurnover TEXT NOT NULL,
            $columnMoneyTurnover REAL NOT NULL,
            $columnDateDealTurnover INTEGER NOT NULL,
            
            FOREIGN KEY ($columnId) REFERENCES $user_table($columnId)
          )
          ''');
  }

  Future<void> insertTurnover(Map<String, dynamic> row) async {
    Database db = await instance.database;
    await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.rawQuery('select * from $table where $columnId = ? ', [EventLogin.id]);
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> updateTurnover(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<void> deleteTurnover(int id) async {
    Database db = await instance.database;
    await db.rawDelete('delete from $table where $columnIdTable = ?', [id]);
  }

  Future<List> queryRowsList(int dateStart, int dateEnd) async {
    Database db = await instance.database;
    return await db.rawQuery('select * from $table '
        'where $columnDateDealTurnover >= ? '
        'and $columnDateDealTurnover <= ? ',
    [dateStart, dateEnd]);
  }

  Future<List> queryRowsKey(String key, int dateStart, int dateEnd) async {
    Database db = await instance.database;
    return await db.rawQuery('select * from $table '
        'where $columnDateDealTurnover >= ? '
        'and $columnDateDealTurnover <= ? '
        'and $columnGroupNameTurnover = ? ',
    [dateStart, dateEnd, key]);
  }

}