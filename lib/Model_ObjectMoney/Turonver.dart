import 'package:maganemoney/database/TurnoverTable.dart';

import 'Deals.dart';

class Turnover extends Deal {

  Turnover(
      {
        int id : 0,
        String nameTurnover: 'no',
        String groupNameTurnover: 'no',
        double moneyTurnover: 0.0,
        int dateDeal: 0,
      }) {
    this.id = id;
    this.nameDeal = nameTurnover;
    this.groupNameDeal = groupNameTurnover;
    this.moneyDeal = moneyTurnover;
    this.dateDeal = dateDeal;
  }

  Map<String, dynamic> toMap() {
    return {
      'ID_USER': this.id,
      'NAME_TURNOVER': this.nameDeal,
      'GROUPNAME_TURNOVER': this.groupNameDeal,
      'MONEY_TURNOVER': this.moneyDeal,
      'DATE_DEAL_TURNOVER': this.dateDeal,
    };
  }

  static Turnover turnover = Turnover(
    nameTurnover: 'no',
    groupNameTurnover: 'no',
    moneyTurnover: 0.0,
    dateDeal: 0,
  );

  final dbHelper = TurnoverTable.instance;

  void insertTurnover(Turnover ex) async {
    final insert = await dbHelper.insertTurnover(ex.toMap());
    print("chen thanh cong");
  }

  void query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  void deleteRows() async {
    final id = await dbHelper.queryRowCount();
    await dbHelper.deleteTurnover(id);
  }

  void deleteRow(int id) async {
    await dbHelper.deleteTurnover(id);
  }

  var listTurnover = TurnoverTable.listColumnTurnover;

  //get data from database with 'key', from dateStart to dateEnd
  Future<List> listData(String key, int dateStart, int dateEnd) async {
    List<List> list = new List();
    List<int> listPrimaryKey = new List();
    List<int> listId = new List();
    List<String> listNameTurnover= new List();
    List<String> listGroupNameTurnover = new List();
    List<double> listMoneyTurnover = new List();
    List<int> listDateDeal = new List();

    var rows = await dbHelper.queryRowsKey(key, dateStart, dateEnd);
    int count = rows.length;

    for (int i = 0; i < count; i++) {
      var row = rows[i];
      listPrimaryKey.add(row[listTurnover[0]]);
      listId.add(row[listTurnover[1]]);
      listNameTurnover.add(row[listTurnover[2]]);
      listGroupNameTurnover.add(row[listTurnover[3]]);
      listMoneyTurnover.add(row[listTurnover[4]]);
      listDateDeal.add(row[listTurnover[5]]);
    }
    list.add(listPrimaryKey);
    list.add(listId);
    list.add(listNameTurnover);
    list.add(listGroupNameTurnover);
    list.add(listMoneyTurnover);
    list.add(listDateDeal);

    return list;
  }

  //get all data from database from dateStart to dateEnd
  Future<List> list(int dateStart, int dateEnd) async {
    List<List> list = new List();
    List<int> listPrimaryKey = new List();
    List<int> listId = new List();
    List<String> listNameTurnover= new List();
    List<String> listGroupNameTurnover = new List();
    List<double> listMoneyTurnover = new List();
    List<int> listDateDeal = new List();
    var rows = await dbHelper.queryRowsList(dateStart, dateEnd);
    int count = rows.length;

    for (int i = 0; i < count; i++) {
      var row = rows[i];
      listPrimaryKey.add(row[listTurnover[0]]);
      listId.add(row[listTurnover[1]]);
      listNameTurnover.add(row[listTurnover[2]]);
      listGroupNameTurnover.add(row[listTurnover[3]]);
      listMoneyTurnover.add(row[listTurnover[4]]);
      listDateDeal.add(row[listTurnover[5]]);
    }
    list.add(listPrimaryKey);
    list.add(listId);
    list.add(listNameTurnover);
    list.add(listGroupNameTurnover);
    list.add(listMoneyTurnover);
    list.add(listDateDeal);

    return list;
  }

  //get listMoney from dateStart to dateEnd
  Future<List<double>> listMoneyStartEnd(int dateStart, int dateEnd) async {
    List<double> listMoney = [0, 0, 0, 0];

    var rows = await dbHelper.queryRowsList(dateStart, dateEnd);
    int count = rows.length;
    int size = listGroupNameTurnover.length;

    for (int i = 0; i < count; i++) {
      for (int j = 0; j < size; j++) {
        if (rows[i][listTurnover[3]] == listGroupNameTurnover[j]) {
          listMoney[j] = listMoney[j] + rows[i][listTurnover[4]];
          break;
        }
      };
    }

    return listMoney;
  }

  List<String> listGroupNameTurnover = ['Business', 'Invest', 'Gift', 'OverTime'];

  // get Al listMoney from database
  Future<List> listMoney() async {
    List<double> listMoney = [0, 0, 0, 0];

    var rows = await dbHelper.queryAllRows();
    int count = rows.length;
    int size = listGroupNameTurnover.length;

    for (int i = 0; i < count; i++) {
      for (int j = 0; j < size; j++) {
        if (rows[i][listTurnover[3]] == listGroupNameTurnover[j]) {
          listMoney[j] = listMoney[j] + rows[i][listTurnover[4]];
          break;
        }
      };
    }

    return listMoney;
  }

  //get sumMoney fromd database
  Future<double> getSumMoney() async {
    List list = await listMoney();
    double sumMoney = 0;
    int size = list.length;
    for (int i = 0; i < size; i++) {
      sumMoney = sumMoney + list[i];
    }
    return sumMoney;
  }

}