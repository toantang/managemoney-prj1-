import 'dart:io';

import 'package:maganemoney/login/EventLogin.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'UserTable.dart';

class AccountBalanceTable {
  static final _databaseName = "AcountBalance_database.db";
  static final _databaseVersion = 1;

  static final table = 'AcountBalance_Table';

  static final columnIdTable = 'ID_TABLE';
  static final columnId = 'ID_USER'; //id user
  static final columnSumCurrentMoney = 'SUM_CURRENT_MONEY';

  static final listColumnAccountBalance = [AccountBalanceTable.columnIdTable, AccountBalanceTable.columnId,
    AccountBalanceTable.columnSumCurrentMoney];

  AccountBalanceTable._privateConstructor();
  static final AccountBalanceTable instance = AccountBalanceTable._privateConstructor();

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

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (     
            $columnIdTable INTEGER PRIMARY KEY NOT NULL,
            $columnId INTEGER NOT NULL,
            $columnSumCurrentMoney REAL NOT NULL,
            
            FOREIGN KEY ($columnId) REFERENCES $user_table($columnId) 
          )
          ''');
  }

  Future<void> insertAccountBalance(Map<String, dynamic> row) async {
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

  Future<void> deleteAccountBalance(int id) async {
    Database db = await instance.database;
    await db.rawDelete('delete from $table where $columnIdTable = ?', [id]);
  }

  Future<int> updateAccountBalance(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

}