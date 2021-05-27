import 'dart:io';

import 'package:maganemoney/login/EventLogin.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'UserTable.dart';

class TurnoverFixedTable {

  static final _databaseName = "TurnoverFixed_database.db";
  static final _databaseVersion = 1;

  static final table = 'TurnoverFixed_Table';

  static final columnIdFixedTable = 'Id_Table';
  static final columnId = 'ID_USER';
  static final columnNameTurnoverFixed = 'NAME_TURNOVER_FIXED';
  static final columnGroupnameTurnoverFixed = 'GROUPNAME_TURNOVER_FIXED';
  static final columnMoneyTurnoverFixed = 'TURNOVER_FIXED';
  static final columnDateDealTurnoverFixed = 'DATE_DEAL_TURNOVER_FIXED';
  static final columnFrequencyTurnoverFixed = 'FREQUENCY_TURNOVER_FIXED';
  static final columnDateUpdateTurnoverFixed = 'DATE_UPDATE_TURNOVER_FIXED';
  static final columnMoneyFrequency = 'MONEY_FREQUENCY';

  static List<String> listColumnTurnoverFixed = [
    TurnoverFixedTable.columnIdFixedTable, TurnoverFixedTable.columnId, TurnoverFixedTable.columnNameTurnoverFixed,
    TurnoverFixedTable.columnGroupnameTurnoverFixed, TurnoverFixedTable.columnMoneyTurnoverFixed,
    TurnoverFixedTable.columnDateDealTurnoverFixed, TurnoverFixedTable.columnFrequencyTurnoverFixed,
    TurnoverFixedTable.columnDateUpdateTurnoverFixed, TurnoverFixedTable.columnMoneyFrequency,
  ];

  TurnoverFixedTable._privateConstructor();
  static final TurnoverFixedTable instance = TurnoverFixedTable._privateConstructor();

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
  // ignore: non_constant_identifier_names
  var user_table = UserTable.table;
  // ignore: non_constant_identifier_names

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (     
            $columnIdFixedTable INTEGER NOT NULL PRIMARY KEY, 
            $columnId INTEGER NOT NULL,                                     
            $columnNameTurnoverFixed TEXT NOT NULL,
            $columnGroupnameTurnoverFixed TEXT NOT NULL,
            $columnMoneyTurnoverFixed REAL NOT NULL,
            $columnDateDealTurnoverFixed INTEGER NOT NULL,
            $columnFrequencyTurnoverFixed REAL NOT NULL,
            $columnDateUpdateTurnoverFixed INTEGER NOT NULL,  
            $columnMoneyFrequency REAL NOT NULL,
            
            FOREIGN KEY ($columnId) REFERENCES $user_table($columnId)
          )
          ''');
  }
  Future<void> insertTurnoverFixed(Map<String, dynamic> row) async {
    Database db = await instance.database;
    await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.rawQuery('select * from $table where $columnId = ? ', [EventLogin.id]);
  }

  Future<List<Map<String, dynamic>>> queryFullRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> updateTurnoverFixed(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.update(table, row, where: '$columnId = ?');
  }

  Future<void> deleteTurnoverFixed(int id) async {
    Database db = await instance.database;
    await db.rawDelete('delete from $table where $columnIdFixedTable = ?', [id]);
  }

  Future<List> queryRowsList(int dateStart, int dateEnd) async {
    Database db = await instance.database;
    return await db.rawQuery('select * from $table '
        'where $columnDateDealTurnoverFixed >= ? '
        'and $columnDateDealTurnoverFixed <= ? ',
    [dateStart, dateEnd]);
  }

  var listTurnoverFixed = TurnoverFixedTable.listColumnTurnoverFixed;

  Future<List> queryRowsKey(String key, int dateStart, int dateEnd) async {
    Database db = await instance.database;
    return await db.rawQuery('select * from $table '
        'where $columnDateDealTurnoverFixed >= ? '
        'and $columnDateDealTurnoverFixed <= ? '
        'and $columnGroupnameTurnoverFixed = ? ',
    [dateStart, dateEnd, key]);
  }

}