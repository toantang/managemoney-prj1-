import 'dart:io';

import 'package:maganemoney/database/UserTable.dart';
import 'package:maganemoney/login/EventLogin.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ExpenditureTable {
  static final _databaseName = "Expenditure_database.db";
  static final _databaseVersion = 1;

  static final table = 'Expenditure_Table';

  static final columnIdTable = 'Id_Table';
  static final columnId = 'ID_USER';
  static final columnNameExpenditure = 'NAME_EXPENDITURE';
  static final columnGroupNameExpenditure = 'GROUP_NAME_EXPENDITURE';
  static final columnMoneyExpenditure = 'EXPENDITURE';
  static final columnDateDealExpenditure = "DATE_DEAL_EXPENDITURE";

  static List<String> listColumnExpenditure = [
    ExpenditureTable.columnIdTable, ExpenditureTable.columnId, ExpenditureTable.columnNameExpenditure,
    ExpenditureTable.columnGroupNameExpenditure, ExpenditureTable.columnMoneyExpenditure, ExpenditureTable.columnDateDealExpenditure,
  ];


  ExpenditureTable._privateConstructor();
  static final ExpenditureTable instance = ExpenditureTable._privateConstructor();

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
            $columnNameExpenditure TEXT NOT NULL,
            $columnGroupNameExpenditure TEXT NOT NULL,
            $columnMoneyExpenditure REAL NOT NULL,
            $columnDateDealExpenditure INTEGER NOT NULL,
            
            FOREIGN KEY ($columnId) REFERENCES $user_table($columnId) 
          )
          ''');
  }

  Future<void> insertExpenditure(Map<String, dynamic> row) async {
    Database db = await instance.database;
    await db.insert(table, row);
  }

  Future<List> queryAllRows() async {
    Database db = await instance.database;
    return await db.rawQuery('select * from $table where $columnId = ? ', [EventLogin.id]);
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<void> deleteExpenditure(int id) async {
    Database db = await instance.database;
    await db.rawDelete('delete from $table where $columnIdTable = ?', [id]);
  }

  Future<int> updateExpenditure(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List> queryRowsKey(String key, int dateStart, int dateEnd) async {
    Database db = await instance.database;
    return await db.rawQuery('select * from $table '
        'where $columnDateDealExpenditure >= ? '
        'and $columnDateDealExpenditure <= ? '
        'and $columnGroupNameExpenditure = ? ',
    [dateStart, dateEnd, key]);
  }

  Future<List> queryRowsList(int dateStart, int dateEnd) async {
    Database db = await instance.database;
    return await db.rawQuery(
        'select * from $table '
        'where $columnDateDealExpenditure >= ? '
        'and $columnDateDealExpenditure <= ? ',
    [dateStart, dateEnd]);
  }

  static get databaseName => _databaseName;
}