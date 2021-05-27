import 'package:maganemoney/database/ScheduleTable.dart';

class ScheduleObject {
  int _idUser;
  String _nameSchedule;
  int _interval;
  double _moneyForSchedule;
  String _dateStartSchedule;
  double _moneyAMonth;
  double _currentMoney;
  int _stateSchedule;
  int _dateUpdateSchedule;

  ScheduleObject({int idUser: 0, String nameSchedule: 'null', int interval: 0,
    double moneyForSchedule: 0, String dateStartSchedule: 'null', double moneyAMonth: 0.0, double currentMoney: 0.0,
    int stateSchedule: -1, int dateUpdateSchedule})
  {
    this._idUser = idUser;
    this._interval = interval;
    this._moneyForSchedule = moneyForSchedule;
    this._dateStartSchedule = dateStartSchedule;
    this._moneyAMonth = moneyAMonth;
    this._currentMoney = currentMoney;
    this._stateSchedule = stateSchedule;
    this._dateUpdateSchedule = dateUpdateSchedule;
  }

  Map<String, dynamic> toMap() {
    return {
      'ID_USER': this._idUser,
      'NAME_SCHEDULE': this._nameSchedule,
      'INTERVAL': this._interval,
      'MONEY_FOR_SCHEDULE': this._moneyForSchedule,
      'DATE_START_SCHEDULE': this._dateStartSchedule,
      'MONEY_A_MONTH': this._moneyAMonth,
      'CURRENT_MONEY': this._currentMoney,
      'STATE_SCHEDULE': this._stateSchedule,
      'DATE_UPDATE_SCHEDULE': this._dateUpdateSchedule,
    };
  }

  static ScheduleObject scheduleObject = new ScheduleObject(
      idUser: 0,
      nameSchedule: 'null',
      interval: 0,
      moneyForSchedule: 0,
      dateStartSchedule: 'null',
      moneyAMonth: 0,
      currentMoney: 0.0,
      stateSchedule: -1,
      dateUpdateSchedule: 0,
  );

  final dbHelper = ScheduleTable.instance;

  Future<List> allRows() async {
    return await dbHelper.queryAllRows();
  }

  void insertSchedule(ScheduleObject ex) async {
    final insert = await dbHelper.insertSchedule(ex.toMap());
    print("chen thanh cong");
  }

  void deleteRows() async {
    final id = await dbHelper.queryRowCount();
    await dbHelper.deleteSchedule(id);
  }

  void deleteRow(int id) async {
    await dbHelper.deleteSchedule(id);
  }

  void query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  Future<int> findPrimaryKey(int value, String key) async {
    final rowsVal = await dbHelper.queryAllRows();
    var s = rowsVal[value][key];
    return s;
  }

  Future<int> getFinalId() async {
    final rows = await dbHelper.queryAllRows();
    int count = await dbHelper.queryRowCount();
    return rows[count-1][listColumnNameSchedule[0]];
  }

  Future<int> count() async {
    return await dbHelper.queryRowCount();
  }

  void update(int id, int idUser, String nameSchedule, int interval, double moneySchedule, String dateStart, double moneyAMonth,
      double currentMoney, int stateSchedule, int dateUpdateDeal) async {
    // row to update
    Map<String, dynamic> updateRows = {
      ScheduleTable.columnIdScheduleTable: id,
      ScheduleTable.columnId : idUser,
      ScheduleTable.columnNameSchedule: nameSchedule,
      ScheduleTable.columnInterval: interval,
      ScheduleTable.columnMoneyforSchedule: moneySchedule,
      ScheduleTable.columnDateStartSchedule: dateStart,
      ScheduleTable.columnMoneyAMonth: moneyAMonth,
      ScheduleTable.columnCurrentMoney: currentMoney,
      ScheduleTable.columnStateSchedule: stateSchedule,
      ScheduleTable.columnDateUpdate: dateUpdateDeal,
    };
    await dbHelper.updateSchedule(updateRows);
    print("update thanh cong");
  }

  //get list Scheduule Unfinished
  Future<List> listCurrentMoneyUnfinishedSchedule() async {
    var rows = await dbHelper.queryAllRows();
    int size = await dbHelper.queryRowCount();
    List<double> listCurrentMoneySchedule = new List();

    for (int i = 0; i < size; i++) {
      var row = rows[i];
      int stateSchedule = row[listColumnNameSchedule[8]];
      if (stateSchedule == -1) {
        listCurrentMoneySchedule.add(row[listColumnNameSchedule[7]]);
      }
    }
    return listCurrentMoneySchedule;
  }

  List<String> listColumnNameSchedule = ScheduleTable.listColumnSchedule;
  //get all data from database, Schedule Unfinished
  Future<List> listDataUnfinished() async {

    List<int> listPrimaryKey = new List();
    List<int> listIdUser = new List();
    List<String> listName = new List();
    List<int> listInterval = new List();
    List<double> listMoney = new List();
    List<String> listDateStart = new List();
    List<double> listMoneyAMonth = new List();
    List<double> listCurrentMoney = new List();
    List<int> listStateSchedule = new List();
    List<int> listDateUpdateSchedule = new List();
    var rows = await dbHelper.queryAllRows();
    int size = await dbHelper.queryRowCount();
    for (int i = 0; i < size; i++) {
      var row = rows[i];
      int stateSchedule = row[listColumnNameSchedule[8]];
      if (stateSchedule == -1) {
        listPrimaryKey.add(row[listColumnNameSchedule[0]]);
        listIdUser.add(row[listColumnNameSchedule[1]]);
        listName.add(row[listColumnNameSchedule[2]]);
        listInterval.add(row[listColumnNameSchedule[3]]);
        listMoney.add(row[listColumnNameSchedule[4]]);
        listDateStart.add(row[listColumnNameSchedule[5]]);
        listMoneyAMonth.add(row[listColumnNameSchedule[6]]);
        listCurrentMoney.add(row[listColumnNameSchedule[7]]);
        listStateSchedule.add(stateSchedule);
        listDateUpdateSchedule.add(row[listColumnNameSchedule[9]]);
      }
    }

    List<List> list = new List();
    list.add(listPrimaryKey);
    list.add(listIdUser);
    list.add(listName);
    list.add(listInterval);
    list.add(listMoney);
    list.add(listDateStart);
    list.add(listMoneyAMonth);
    list.add(listCurrentMoney);
    list.add(listStateSchedule);
    list.add(listDateUpdateSchedule);

    return list;
  }

  //get all data from databse, Schedule Finished
  Future<List> listDataFinished() async {

    List<int> listPrimaryKey = new List();
    List<int> listIdUser = new List();
    List<String> listName = new List();
    List<int> listInterval = new List();
    List<double> listMoney = new List();
    List<String> listDateStart = new List();
    List<double> listMoneyAMonth = new List();
    List<double> listCurrentMoney = new List();
    List<int> listStateSchedule = new List();
    List<int> listDateUpdateSchedule = new List();

    var rows = await dbHelper.queryAllRows();
    int size = await dbHelper.queryRowCount();
    for (int i = 0; i < size; i++) {
      var row = rows[i];
      int stateSchedule = row[listColumnNameSchedule[8]];
      if (stateSchedule == 1) {
        listPrimaryKey.add(row[listColumnNameSchedule[0]]);
        listIdUser.add(row[listColumnNameSchedule[1]]);
        listName.add(row[listColumnNameSchedule[2]]);
        listInterval.add(row[listColumnNameSchedule[3]]);
        listMoney.add(row[listColumnNameSchedule[4]]);
        listDateStart.add(row[listColumnNameSchedule[5]]);
        listMoneyAMonth.add(row[listColumnNameSchedule[6]]);
        listCurrentMoney.add(row[listColumnNameSchedule[7]]);
        listStateSchedule.add(stateSchedule);
        listDateUpdateSchedule.add(row[listColumnNameSchedule[9]]);
      }
    }

    List<List> list = new List();
    list.add(listPrimaryKey);
    list.add(listName);
    list.add(listInterval);
    list.add(listMoney);
    list.add(listDateStart);
    list.add(listMoneyAMonth);
    list.add(listCurrentMoney);
    list.add(listStateSchedule);
    list.add(listDateUpdateSchedule);

    return list;
  }

  int get dateUpdateSchedule => _dateUpdateSchedule;

  set dateUpdateSchedule(int value) {
    _dateUpdateSchedule = value;
  }

  int get stateSchedule => _stateSchedule;

  set stateSchedule(int value) {
    _stateSchedule = value;
  }

  double get currentMoney => _currentMoney;

  set currentMoney(double value) {
    _currentMoney = value;
  }

  double get moneyAMonth => _moneyAMonth;

  set moneyAMonth(double value) {
    _moneyAMonth = value;
  }

  String get dateStartSchedule => _dateStartSchedule;

  set dateStartSchedule(String value) {
    _dateStartSchedule = value;
  }

  double get moneyForSchedule => _moneyForSchedule;

  set moneyForSchedule(double value) {
    _moneyForSchedule = value;
  }

  int get interval => _interval;

  set interval(int value) {
    _interval = value;
  }

  String get nameSchedule => _nameSchedule;

  set nameSchedule(String value) {
    _nameSchedule = value;
  }

  int get idUser => _idUser;

  set idUser(int value) {
    _idUser = value;
  }
}