import 'package:maganemoney/database/TurnoverFixedTable.dart';

import 'Deals.dart';

class TurnoverFixed extends Deal {
  double _frequencyTurnoverFixed;
  double _moneyFrequencyTurnoverFixed;
  int _dateUpdateDeal;

  TurnoverFixed({
    int id: 0,
    String nameTurnoverFixed: 'no',
    String groupNameTurnoverFixed: 'no',
    double moneyTurnoverFixed: 0.0,
    int dateDeal: 0,
    double frequencyTurnoverFixed: 0.0,
    int dateUpdateDeal: 0,
    double moneyFrequencyTurnoverFixed: 0,
  }) {
    this.id = id;
    this.nameDeal = nameTurnoverFixed;
    this.groupNameDeal = groupNameTurnoverFixed;
    this.moneyDeal = moneyTurnoverFixed;
    this.dateDeal = dateDeal;
    this._frequencyTurnoverFixed = frequencyTurnoverFixed;
    this._dateUpdateDeal = dateUpdateDeal;
    this._moneyFrequencyTurnoverFixed = moneyFrequencyTurnoverFixed;
  }

  Map<String, dynamic> toMap() {
    return {
      'ID_USER': this.id,
      'NAME_TURNOVER_FIXED': this.nameDeal,
      'GROUPNAME_TURNOVER_FIXED': this.groupNameDeal,
      'TURNOVER_FIXED': this.moneyDeal,
      'DATE_DEAL_TURNOVER_FIXED': this.dateDeal,
      'FREQUENCY_TURNOVER_FIXED': this._frequencyTurnoverFixed,
      'DATE_UPDATE_TURNOVER_FIXED': this._dateUpdateDeal,
      'MONEY_FREQUENCY': this._moneyFrequencyTurnoverFixed,
    };
  }

  static TurnoverFixed turnoverFixed = TurnoverFixed(
    nameTurnoverFixed: 'no',
    groupNameTurnoverFixed: 'no',
    moneyTurnoverFixed: 0.0,
    dateDeal: 0,
    frequencyTurnoverFixed: 0.0,
    dateUpdateDeal: 0,
    moneyFrequencyTurnoverFixed: 0.0,
  );

  final dbHelper = TurnoverFixedTable.instance;

  void insertExpenditureFixed(TurnoverFixed ex) async {
    final insert = await dbHelper.insertTurnoverFixed(ex.toMap());
    print("chen thanh cong");
  }

  void query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  void deleteRows() async {
    final id = await dbHelper.queryRowCount();
    await dbHelper.deleteTurnoverFixed(id);
  }

  void deleteRow(int id) async {
    await dbHelper.deleteTurnoverFixed(id);
  }

  var listTurnoverFixed = TurnoverFixedTable.listColumnTurnoverFixed;

  void updateTurnoverFixed(int id, int idUser, String nameTurnoverFixed, String groupNameTurnoverFixed, double money,
      int dateDeal, double frequencyTurnoverFixed, int dateUpdateDeal,
      double moneyFrequencyTurnoverFixed) async {
    Map<String, dynamic> updateRows = {
      TurnoverFixedTable.columnIdFixedTable: id,
      TurnoverFixedTable.columnId : idUser,
      TurnoverFixedTable.columnNameTurnoverFixed : nameTurnoverFixed,
      TurnoverFixedTable.columnGroupnameTurnoverFixed : groupNameTurnoverFixed,
      TurnoverFixedTable.columnMoneyTurnoverFixed : money,
      TurnoverFixedTable.columnDateDealTurnoverFixed: dateDeal,
      TurnoverFixedTable.columnFrequencyTurnoverFixed : frequencyTurnoverFixed,
      TurnoverFixedTable.columnDateUpdateTurnoverFixed: dateUpdateDeal,
      TurnoverFixedTable.columnMoneyFrequency : moneyFrequencyTurnoverFixed,
    };

    await dbHelper.updateTurnoverFixed(updateRows);
  }

  //get data from database from dateStart to dateEnd
  Future<List> list(int dateStart, int dateEnd) async {
    List<List> list = new List();
    List<int> listPrimaryKey = new List();
    List<int> listId = new List();
    List<String> listNameTurnoverFixed = new List();
    List<String> listGroupNameTurnoverFixed = new List();
    List<double> listMoneyTurnoverFixed = new List();
    List<int> listDateDeal = new List();
    List<double> listFrequencyTurnoverFixed = new List();
    List<int> listDateUpdateDeal = new List();
    List<double> listMoneyFrequency = new List();

    var rows = await dbHelper.queryRowsList(dateStart, dateEnd);
    int count = rows.length;
    for (int i = 0; i < count; i++) {
      var row = rows[i];
      listPrimaryKey.add(row[listTurnoverFixed[0]]);
      listId.add(row[listTurnoverFixed[1]]);
      listNameTurnoverFixed.add(row[listTurnoverFixed[2]]);
      listGroupNameTurnoverFixed.add(row[listTurnoverFixed[3]]);
      listMoneyTurnoverFixed.add(row[listTurnoverFixed[4]]);
      listDateDeal.add(row[listTurnoverFixed[5]]);
      listFrequencyTurnoverFixed.add(row[listTurnoverFixed[6]]);
      listDateUpdateDeal.add(row[listTurnoverFixed[7]]);
      listMoneyFrequency.add(row[listTurnoverFixed[8]]);
    }
    list.add(listPrimaryKey);
    list.add(listId);
    list.add(listNameTurnoverFixed);
    list.add(listGroupNameTurnoverFixed);
    list.add(listMoneyTurnoverFixed);
    list.add(listDateDeal);
    list.add(listFrequencyTurnoverFixed);
    list.add(listDateUpdateDeal);
    list.add(listMoneyFrequency);

    return list;
  }

  //get data from database from dateStart to dateEnd with 'key'
  Future<List> listData(String key, int dateStart, int dateEnd) async {
    List<List> list = new List();
    List<int> listPrimaryKey = new List();
    List<int> listId = new List();
    List<String> listNameTurnoverFixed = new List();
    List<String> listGroupNameTurnoverFixed = new List();
    List<double> listMoneyTurnoverFixed = new List();
    List<int> listDateDeal = new List();
    List<double> listFrequencyTurnoverFixed = new List();
    List<int> listDateUpdateDeal = new List();
    List<double> listMoneyFrequency = new List();

    var rows = await dbHelper.queryRowsKey(key, dateStart, dateEnd);
    int count = rows.length;
    for (int i = 0; i < count; i++) {
      var row = rows[i];
      listPrimaryKey.add(row[listTurnoverFixed[0]]);
      listId.add(row[listTurnoverFixed[1]]);
      listNameTurnoverFixed.add(row[listTurnoverFixed[2]]);
      listGroupNameTurnoverFixed.add(row[listTurnoverFixed[3]]);
      listMoneyTurnoverFixed.add(row[listTurnoverFixed[4]]);
      listDateDeal.add(row[listTurnoverFixed[5]]);
      listFrequencyTurnoverFixed.add(row[listTurnoverFixed[6]]);
      listDateUpdateDeal.add(row[listTurnoverFixed[7]]);
      listMoneyFrequency.add(row[listTurnoverFixed[8]]);
    }
    list.add(listPrimaryKey);
    list.add(listId);
    list.add(listNameTurnoverFixed);
    list.add(listGroupNameTurnoverFixed);
    list.add(listMoneyTurnoverFixed);
    list.add(listDateDeal);
    list.add(listFrequencyTurnoverFixed);
    list.add(listDateUpdateDeal);
    list.add(listMoneyFrequency);

    return list;
  }

  //get listMoney from dateStart to dateEnd
  Future<List> listMoneyStartEnd(int dateStart, int dateEnd) async {
    List<double> listMoney = [0, 0, 0];

    var rows = await dbHelper.queryRowsList(dateStart, dateEnd);
    int count = rows.length;
    int size = listGroupNameTurnoverFixed.length;
    var listTurnoverFixed = TurnoverFixedTable.listColumnTurnoverFixed;
    for (int i = 0; i < count; i++) {
      for (int j = 0; j < size; j++) {
        if (rows[i][listTurnoverFixed[3]] == listGroupNameTurnoverFixed[j]) {
          listMoney[j] = listMoney[j] + rows[i][listTurnoverFixed[4]];
        }
      };
    }
    return listMoney;
  }

  //load all data from database
  Future<List> getDataTurnoverFixed() async {
    List<List> list = new List();
    List<int> listPrimaryKey = new List();
    List<int> listId = new List();
    List<String> listNameTurnoverFixed = new List();
    List<String> listGroupNameTurnoverFixed = new List();
    List<double> listMoneyTurnoverFixed = new List();
    List<int> listDateDeal = new List();
    List<double> listFrequencyTurnoverFixed = new List();
    List<int> listDateUpdateDeal = new List();
    List<double> listMoneyFrequency = new List();

    var rows = await dbHelper.queryAllRows();
    int count = rows.length;
    for (int i = 0; i < count; i++) {
      var row = rows[i];
      listPrimaryKey.add(row[listTurnoverFixed[0]]);
      listId.add(row[listTurnoverFixed[1]]);
      listNameTurnoverFixed.add(row[listTurnoverFixed[2]]);
      listGroupNameTurnoverFixed.add(row[listTurnoverFixed[3]]);
      listMoneyTurnoverFixed.add(row[listTurnoverFixed[4]]);
      listDateDeal.add(row[listTurnoverFixed[5]]);
      listFrequencyTurnoverFixed.add(row[listTurnoverFixed[6]]);
      listDateUpdateDeal.add(row[listTurnoverFixed[7]]);
      listMoneyFrequency.add(row[listTurnoverFixed[8]]);
    }

    list.add(listPrimaryKey);
    list.add(listId);
    list.add(listNameTurnoverFixed);
    list.add(listGroupNameTurnoverFixed);
    list.add(listMoneyTurnoverFixed);
    list.add(listDateDeal);
    list.add(listFrequencyTurnoverFixed);
    list.add(listDateUpdateDeal);
    list.add(listMoneyFrequency);

    return list;
  }

  List<String> listGroupNameTurnoverFixed = ['Earnings', 'Business', 'Invest',];

  //get all listMoney from database
  Future<List> listMoney() async {
    List<double> listMoney = [0, 0, 0];

    var rows = await dbHelper.queryAllRows();
    int count = rows.length;
    int size = listGroupNameTurnoverFixed.length;
    var listTurnoverFixed = TurnoverFixedTable.listColumnTurnoverFixed;
    for (int i = 0; i < count; i++) {
      for (int j = 0; j < size; j++) {
        if (rows[i][listTurnoverFixed[3]] == listGroupNameTurnoverFixed[j]) {
          listMoney[j] = listMoney[j] + rows[i][listTurnoverFixed[4]];
        }
      };
    }
    return listMoney;
  }

  //get sumMoney from database
  Future<double> getSumMoney() async {
    List list = await listMoney();
    double sumMoney = 0;
    int size = list.length;
    for (int i = 0; i < size; i++) {
      sumMoney = sumMoney + list[i];
    }
    return sumMoney;
  }

  int get dateUpdateDeal => _dateUpdateDeal;

  set dateUpdateDeal(int value) {
    _dateUpdateDeal = value;
  }

  double get moneyFrequencyTurnoverFixed => _moneyFrequencyTurnoverFixed;

  set moneyFrequencyTurnoverFixed(double value) {
    _moneyFrequencyTurnoverFixed = value;
  }

  double get frequencyTurnoverFixed => _frequencyTurnoverFixed;

  set frequencyTurnoverFixed(double value) {
    _frequencyTurnoverFixed = value;
  }
}