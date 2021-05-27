import 'dart:io';

import 'package:maganemoney/login/EventLogin.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'UserTable.dart';

class ScheduleTable {
  static final _databaseName = "ScheduleTable_datebase.db";
  static final _databaseVersion = 1;

  static final table = 'Schedule_Table';

  static final columnIdScheduleTable = 'Id_Table';
  static final columnId = 'ID_USER';
  static final columnNameSchedule = 'NAME_SCHEDULE'; // ten ke hoach
  static final columnInterval = 'INTERVAL'; // khoang thoi gian
  static final columnMoneyforSchedule = 'MONEY_FOR_SCHEDULE'; // so tien cho ke hoach nay
  static final columnDateStartSchedule = 'DATE_START_SCHEDULE';
  static final columnMoneyAMonth = 'MONEY_A_MONTH';
  static final columnCurrentMoney = 'CURRENT_MONEY';
  static final columnStateSchedule = 'STATE_SCHEDULE'; // trạng thái hoàn thành kế hoạch, -1: chưa hoàn thành, 1: đã hoàn thành
  static final columnDateUpdate = 'DATE_UPDATE_SCHEDULE';

  static List<String> listColumnSchedule = [ScheduleTable.columnIdScheduleTable, ScheduleTable.columnId, ScheduleTable.columnNameSchedule,
    ScheduleTable.columnInterval, ScheduleTable.columnMoneyforSchedule, ScheduleTable.columnDateStartSchedule,
    ScheduleTable.columnMoneyAMonth, ScheduleTable.columnCurrentMoney, ScheduleTable.columnStateSchedule,
    ScheduleTable.columnDateUpdate,
  ];

  ScheduleTable._privateConstructor();
  static final ScheduleTable instance = ScheduleTable._privateConstructor();

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
            $columnIdScheduleTable INTEGER NOT NULL PRIMARY KEY,  
            $columnId INTEGER NOT NULL,     
            $columnNameSchedule TEXT NOT NULL,                         
            $columnInterval INTEGER NOT NULL,                                                                   
            $columnMoneyforSchedule REAL NOT NULL,
            $columnDateStartSchedule INTEGER NOT NULL,
            $columnMoneyAMonth REAL NOT NULL,
            $columnCurrentMoney REAL,
            $columnStateSchedule INTEGER NOT NULL, 
            $columnDateUpdate INTEGER NOT NULL,
            
            FOREIGN KEY ($columnId) REFERENCES $user_table($columnId)
          )
          ''');
  }

  Future<void> insertSchedule(Map<String, dynamic> row) async {
    Database db = await instance.database;
    await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.rawQuery('select * from $table where $columnId = ? ', [EventLogin.id]);
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table where $columnId = ?', [EventLogin.id]));
  }

  Future<void> deleteSchedule(int id) async {
    Database db = await instance.database;
    await db.rawDelete('delete from $table where $columnIdScheduleTable = ?', [id]);
  }

  Future<void> updateSchedule(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnIdScheduleTable];
    await db.update(table, row, where: '$columnIdScheduleTable = ?', whereArgs: [id]);
    print('update da thanh cong roi (ScheduleTable)');
  }

}