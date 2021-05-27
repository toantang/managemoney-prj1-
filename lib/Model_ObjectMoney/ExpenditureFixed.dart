import 'package:maganemoney/database/ExpenditureFixedTable.dart';

import 'Deals.dart';

class ExpenditureFixed extends Deal {
  double _frequencyExpenditureFixed;
  double _moneyFrequencyExpenditureFixed;
  int _dateUpdateDeal;

  ExpenditureFixed({
    int id: 0,
    String nameExpenditureFixed: 'no',
    String groupNameExpenditureFixed: 'no',
    double moneyExpenditureFixed: 0.0,
    int dateDeal,
    double frequencyExpenditureFixed: 0,
    int dateUpdateDeal: 0,
    double moneyFrequencyExpenditureFixed: 0,
  }) {
    this.id = id;
    this.nameDeal = nameExpenditureFixed;
    this.groupNameDeal = groupNameExpenditureFixed;
    this.moneyDeal = moneyExpenditureFixed;
    this.dateDeal = dateDeal;
    this._frequencyExpenditureFixed = frequencyExpenditureFixed;
    this._dateUpdateDeal = dateUpdateDeal;
    this._moneyFrequencyExpenditureFixed = moneyFrequencyExpenditureFixed;
  }

  Map<String, dynamic> toMap() {
    return {
      'ID_USER': this.id,
      'NAME_EXPENDITURE_FIXED': this.nameDeal,
      'GROUPNAME_EXPENDITURE_FIXED': this.groupNameDeal,
      'EXPENDITURE_FIXED': this.moneyDeal,
      'DATE_DEAL_EXPENDITURE_FIXED': this.dateDeal,
      'FREQUENCY_EXPENDITURE_FIXED': this._frequencyExpenditureFixed,
      'DATE_UPDATE_EXPENDITURE_FIXED': this._dateUpdateDeal,
      'MONEY_FREQUENCY': this._moneyFrequencyExpenditureFixed,
    };
  }

  static ExpenditureFixed expenditureFixed = ExpenditureFixed(
    nameExpenditureFixed: 'no',
    groupNameExpenditureFixed: 'no',
    moneyExpenditureFixed: 0.0,
    dateDeal: 0,
    frequencyExpenditureFixed: 0.0,
    dateUpdateDeal: 0,
    moneyFrequencyExpenditureFixed: 0,
  );

  final dbHelper = ExpenditureFixedTable.instance;

  void insertExpenditureFixed(ExpenditureFixed ex) async {
    final insert = await dbHelper.insertExpenditureFixed(ex.toMap());
    print("chen thanh cong");
  }

  void query() async {
    final allRows = await dbHelper.queryAllRows();
  }

  void deleteRows() async {
    final id = await dbHelper.queryRowCount();
    await dbHelper.deleteExpenditureFixed(id);
  }

  void deleteRow(int id) async {
    await dbHelper.deleteExpenditureFixed(id);
  }

  //update Expenditure Fixed of deal
  void updateExpenditureFixed(int id, int idUser, String nameExpenditureFixed, String groupNameExpenditureFixed, double moneyExpenditureFixed,
      int dateDeal, double frequencyExpenditureFixed, int dateUpdate, double moneyFrequencyExpenditureFixed, ) async {
    Map<String, dynamic> updateRows = {
      ExpenditureFixedTable.columnIdFixedTable: id,
      ExpenditureFixedTable.columnId : idUser,
      ExpenditureFixedTable.columnNameExpenditureFixed : nameExpenditureFixed,
      ExpenditureFixedTable.columnGroupNameExpenditureFixed : groupNameExpenditureFixed,
      ExpenditureFixedTable.columnMoneyExpenditureFixed : moneyExpenditureFixed,
      ExpenditureFixedTable.columnDateDealExpenditureFixed: dateDeal,
      ExpenditureFixedTable.columnFrequency : frequencyExpenditureFixed,
      ExpenditureFixedTable.columnDateUpdateExpenditureFixed: dateUpdate,
      ExpenditureFixedTable.columnMoneyFrequency : moneyFrequencyExpenditureFixed,
    };

    await dbHelper.updateExpenditureFixed(updateRows);
  }

  var listExpenditureFixed = ExpenditureFixedTable.listColumnFixed;

  //get data from database with date: from dateStart to dateEnd
  Future<List> list(int dateStart, int dateEnd) async {
    List<List> list = new List();
    List<int> listPrimaryKey = new List();
    List<int> listId = new List();
    List<String> listNameExpenditureFixed = new List();
    List<String> listGroupNameExpenditureFixed = new List();
    List<double> listMoneyExpenditureFixed = new List();
    List<int> listDateDeal = new List();
    List<double> listFrequency = new List();
    List<int> listDateUpdateDeal = new List();
    List<double> listMoneyFrequency = new List();

    var rows = await dbHelper.queryRowsList(dateStart, dateEnd);
    int count = rows.length;

    for (int i = 0; i < count; i++) {
      var row = rows[i];
      listPrimaryKey.add(row[listExpenditureFixed[0]]);
      listId.add(row[listExpenditureFixed[1]]);
      listNameExpenditureFixed.add(row[listExpenditureFixed[2]]);
      listGroupNameExpenditureFixed.add(row[listExpenditureFixed[3]]);
      listMoneyExpenditureFixed.add(row[listExpenditureFixed[4]]);
      listDateDeal.add(row[listExpenditureFixed[5]]);
      listFrequency.add(row[listExpenditureFixed[6]]);
      listDateUpdateDeal.add(row[listExpenditureFixed[7]]);
      listMoneyFrequency.add(row[listExpenditureFixed[8]]);
    }

    list.add(listPrimaryKey);
    list.add(listId);
    list.add(listNameExpenditureFixed);
    list.add(listGroupNameExpenditureFixed);
    list.add(listMoneyExpenditureFixed);
    list.add(listDateDeal);
    list.add(listFrequency);
    list.add(listDateUpdateDeal);
    list.add(listMoneyFrequency);

    return list;
  }

  //get listMoney from databaase with date: from dateStart to dateEnd
  Future<List> listMoneyStartEnd(int dateStart, int dateEnd) async {
    List<double> listMoney = [0.0, 0.0, 0.0, 0.0];

    var rows = await dbHelper.queryRowsList(dateStart, dateEnd);
    int count = rows.length;
    int size = listGroupNameExpenditureFixed.length;
    for (int i = 0; i < count; i++) {
      String nameExpenditureFixed = rows[i][listExpenditureFixed[3]];
      double money = rows[i][listExpenditureFixed[4]];
      for (int j = 0; j < size; j++) {
        if (nameExpenditureFixed == listGroupNameExpenditureFixed[j]) {
          listMoney[j] = listMoney[j] + money;
          break;
        }
      };
    }
    return listMoney;
  }

  List<String> listGroupNameExpenditureFixed = ['Electrics', 'Water', 'Internet', 'Interest', ];

  //get All listMoney from database
  Future<List> listMoney() async {
    List<double> listMoney = [0.0, 0.0, 0.0, 0.0];

    var rows = await dbHelper.queryAllRows();
    int count = rows.length;
    int size = listGroupNameExpenditureFixed.length;
    for (int i = 0; i < count; i++) {
      String nameExpenditureFixed = rows[i][listExpenditureFixed[3]];
      double money = rows[i][listExpenditureFixed[4]];
      for (int j = 0; j < size; j++) {
        if (nameExpenditureFixed == listGroupNameExpenditureFixed[j]) {
          listMoney[j] = listMoney[j] + money;
          break;
        }
      };
    }
    return listMoney;
  }

  //get sum Money from database
  Future<double> getSumMoney() async {
    List list = await listMoney();
    double sumMoney = 0;
    int size = list.length;
    for (int i = 0; i < size; i++) {
      sumMoney = sumMoney + list[i];
    }
    return sumMoney;
  }

  //get data from database with 'key", from dateStart to dateEnd
  Future<List> listData(String key, int dateStart, int dateEnd) async {
    List<List> list = new List();

    List<int> listPrimaryKey = new List();
    List<int> listId = new List();
    List<String> listNameExpenditureFixed = new List();
    List<String> listGroupNameExpenditureFixed = new List();
    List<double> listMoneyExpenditureFixed = new List();
    List<int> listDateDeal = new List();
    List<double> listFrequency = new List();
    List<int> listDateUpdateDeal = new List();
    List<double> listMoneyFrequency = new List();

    var rows = await dbHelper.queryRowsKey(key, dateStart, dateEnd);
    int count = rows.length;

    for (int i = 0; i < count; i++) {
      var row = rows[i];
      listPrimaryKey.add(row[listExpenditureFixed[0]]);
      listId.add(row[listExpenditureFixed[1]]);
      listNameExpenditureFixed.add(row[listExpenditureFixed[2]]);
      listGroupNameExpenditureFixed.add(row[listExpenditureFixed[3]]);
      listMoneyExpenditureFixed.add(row[listExpenditureFixed[4]]);
      listDateDeal.add(row[listExpenditureFixed[5]]);
      listFrequency.add(row[listExpenditureFixed[6]]);
      listDateUpdateDeal.add(row[listExpenditureFixed[7]]);
      listMoneyFrequency.add(row[listExpenditureFixed[8]]);
    }

    list.add(listPrimaryKey);
    list.add(listId);
    list.add(listNameExpenditureFixed);
    list.add(listGroupNameExpenditureFixed);
    list.add(listMoneyExpenditureFixed);
    list.add(listDateDeal);
    list.add(listFrequency);
    list.add(listDateUpdateDeal);
    list.add(listMoneyFrequency);

    return list;
  }

  //load all data from database
  Future<List> getDataExpenditureFixed() async {
    List<List> list = new List();

    List<int> listPrimaryKey = new List();
    List<int> listId = new List();
    List<String> listNameExpenditureFixed = new List();
    List<String> listGroupNameExpenditureFixed = new List();
    List<double> listMoneyExpenditureFixed = new List();
    List<int> listDateDeal = new List();
    List<double> listFrequency = new List();
    List<int> listDateUpdateDeal = new List();
    List<double> listMoneyFrequency = new List();

    var rows = await dbHelper.queryAllRows();
    int count = rows.length;

    for (int i = 0; i < count; i++) {
      var row = rows[i];
      listPrimaryKey.add(row[listExpenditureFixed[0]]);
      listId.add(row[listExpenditureFixed[1]]);
      listNameExpenditureFixed.add(row[listExpenditureFixed[2]]);
      listGroupNameExpenditureFixed.add(row[listExpenditureFixed[3]]);
      listMoneyExpenditureFixed.add(row[listExpenditureFixed[4]]);
      listDateDeal.add(row[listExpenditureFixed[5]]);
      listFrequency.add(row[listExpenditureFixed[6]]);
      listDateUpdateDeal.add(row[listExpenditureFixed[7]]);
      listMoneyFrequency.add(row[listExpenditureFixed[8]]);
    }

    list.add(listPrimaryKey);
    list.add(listId);
    list.add(listNameExpenditureFixed);
    list.add(listGroupNameExpenditureFixed);
    list.add(listMoneyExpenditureFixed);
    list.add(listDateDeal);
    list.add(listFrequency);
    list.add(listDateUpdateDeal);
    list.add(listMoneyFrequency);

    return list;
  }

  int get dateUpdateDeal => _dateUpdateDeal;

  set dateUpdateDeal(int value) {
    _dateUpdateDeal = value;
  }

  double get moneyFrequencyExpenditureFixed => _moneyFrequencyExpenditureFixed;

  set moneyFrequencyExpenditureFixed(double value) {
    _moneyFrequencyExpenditureFixed = value;
  }

  double get frequencyExpenditureFixed => _frequencyExpenditureFixed;

  set frequencyExpenditureFixed(double value) {
    _frequencyExpenditureFixed = value;
  }
}