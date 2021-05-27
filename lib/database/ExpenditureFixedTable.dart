import 'dart:io';

import 'package:maganemoney/login/EventLogin.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'UserTable.dart';

class ExpenditureFixedTable {
  static final _databaseName = "ExpenditureFixed_database.db";
  static final _databaseVersion = 1;

  static final table = 'ExpenditureExpenditureFixed_Table';

  static final columnIdFixedTable = 'Id_Table';
  static final columnId = 'ID_USER';
  static final columnNameExpenditureFixed = 'NAME_EXPENDITURE_FIXED';
  static final columnGroupNameExpenditureFixed = 'GROUPNAME_EXPENDITURE_FIXED';
  static final columnMoneyExpenditureFixed = 'EXPENDITURE_FIXED';
  static final columnDateDealExpenditureFixed = "DATE_DEAL_EXPENDITURE_FIXED";
  static final columnFrequency = 'FREQUENCY_EXPENDITURE_FIXED'; // đơn vị thời gian
  static final columnDateUpdateExpenditureFixed = "DATE_UPDATE_EXPENDITURE_FIXED";
  static final columnMoneyFrequency = 'MONEY_FREQUENCY'; // x tiền trên một đơn vị thời gian, vdu frequency = 2, x = 100 => 100$/2 tháng

  static List<String> listColumnFixed = [
    ExpenditureFixedTable.columnIdFixedTable, ExpenditureFixedTable.columnId, ExpenditureFixedTable.columnNameExpenditureFixed,
    ExpenditureFixedTable.columnGroupNameExpenditureFixed, ExpenditureFixedTable.columnMoneyExpenditureFixed,
    ExpenditureFixedTable.columnDateDealExpenditureFixed, ExpenditureFixedTable.columnFrequency,
    ExpenditureFixedTable.columnDateUpdateExpenditureFixed, ExpenditureFixedTable.columnMoneyFrequency,
  ];

  ExpenditureFixedTable._privateConstructor();
  static final ExpenditureFixedTable instance = ExpenditureFixedTable._privateConstructor();

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

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (     
            $columnIdFixedTable INTEGER NOT NULL PRIMARY KEY, 
            $columnId INTEGER NOT NULL,                                     
            $columnNameExpenditureFixed TEXT NOT NULL,
            $columnGroupNameExpenditureFixed TEXT NOT NULL,
            $columnMoneyExpenditureFixed REAL,
            $columnDateDealExpenditureFixed INTEGER NOT NULL,
            $columnFrequency REAL NOT NULL,
            $columnDateUpdateExpenditureFixed INTEGER,
            $columnMoneyFrequency REAL NOT NULL,
            
            FOREIGN KEY ($columnId) REFERENCES $user_table($columnId)
          )
          ''');
  }
  Future<void> insertExpenditureFixed(Map<String, dynamic> row) async {
    Database db = await instance.database;
    await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.rawQuery('select * from $table where $columnId = ? ', [EventLogin.id]);
  }

  Future<void> deleteExpenditureFixed(int id) async {
    Database db = await instance.database;
    await db.rawDelete('delete from $table where $columnIdFixedTable = ?', [id]);
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> updateExpenditureFixed(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnIdFixedTable = ?', whereArgs: [id]);
  }

  Future<List> queryRowsList(int dateStart, int dateEnd) async {
    Database db = await instance.database;
    return await db.rawQuery('select * from $table '
        'where $columnDateDealExpenditureFixed >= ? '
        'and $columnDateDealExpenditureFixed <= ? ', [dateStart, dateEnd]);
  }

  Future<List> queryRowsKey(String key, int dateStart, int dateEnd) async {
    Database db = await instance.database;
    return await db.rawQuery('select * from $table '
        'where $columnDateDealExpenditureFixed >= ? '
        'and $columnDateDealExpenditureFixed <= ? '
        'and $columnGroupNameExpenditureFixed = ? ', [dateStart, dateEnd, key]);
  }
}