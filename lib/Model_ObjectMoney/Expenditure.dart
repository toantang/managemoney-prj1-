import 'package:maganemoney/database/ExpenditureTable.dart';

import 'Deals.dart';

class Expenditure extends Deal {

  Expenditure(
      {
        int id : 0,
        String nameExpenditure: 'no',
        String groupNameExpenditure: 'no',
        double moneyExpenditure: 0.0,
        int dateDeal: 0,
      }) {
    this.id = id;
    this.nameDeal = nameExpenditure;
    this.groupNameDeal = groupNameExpenditure;
    this.moneyDeal = moneyExpenditure;
    this.dateDeal = dateDeal;
  }

  Map<String, dynamic> toMap() {
    return {
      'ID_USER': this.id,
      'NAME_EXPENDITURE': this.nameDeal,
      'GROUP_NAME_EXPENDITURE': this.groupNameDeal,
      'EXPENDITURE': this.moneyDeal,
      "DATE_DEAL_EXPENDITURE": this.dateDeal,
    };
  }

  static Expenditure expenditure = new Expenditure(
      id: 0,
      nameExpenditure: 'no name Expenditure',
      groupNameExpenditure: 'no group name Ex',
      moneyExpenditure: 0.0, dateDeal: 0
  );

  final dbHelper = ExpenditureTable.instance;

  Future<List> allRows() async {
    return await dbHelper.queryAllRows();
  }

  void insertExpenditure(Expenditure ex) async {
    final insert = await dbHelper.insertExpenditure(ex.toMap());
    print("chen thanh cong");
  }

  void deleteRows() async {
    final id = await dbHelper.queryRowCount();
    await dbHelper.deleteExpenditure(id);
  }

  void deleteRow(int id) async {
    await dbHelper.deleteExpenditure(id);
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

  Future<int> count() async {
     return await dbHelper.queryRowCount();
  }

  //get all data from database
  Future<List> list(int dateStart, int dateEnd) async {
    List<List> list = new List();
    List<int> listPrimaryKey = new List();
    List<int> listId = new List();
    List<String> listNameExpenditure = new List();
    List<String> listGroupNameExpenditure = new List();
    List<double> listMoneyExpenditure = new List();
    List<int> listDateDeal = new List();

    var rows = await dbHelper.queryRowsList(dateStart, dateEnd);
    int count = rows.length;
    var listExpenditure = ExpenditureTable.listColumnExpenditure;
    for (int i = 0; i < count; i++) {
      var row = rows[i];
      listPrimaryKey.add(row[listExpenditure[0]]);
      listId.add(row[listExpenditure[1]]);
      listNameExpenditure.add(row[listExpenditure[2]]);
      listGroupNameExpenditure.add(row[listExpenditure[3]]);
      listMoneyExpenditure.add(row[listExpenditure[4]]);
      listDateDeal.add(row[listExpenditure[5]]);

    }
    list.add(listPrimaryKey);
    list.add(listId);
    list.add(listNameExpenditure);
    list.add(listGroupNameExpenditure);
    list.add(listMoneyExpenditure);
    list.add(listDateDeal);

    return list;
  }

  var listExpenditure = ExpenditureTable.listColumnExpenditure;
  List<String> listGroupNameExpenditure = ['Eat & Coffe', 'Shopping', 'Vehicle', 'Health', 'Relax', 'Holiday', 'Gift & Donate', ];

  //get data from database with "key"
  Future<List> listData(String key, int dateStart, int dateEnd) async {
    List<List> list = new List();

    List<int> listPrimaryKey = new List();
    List<int> listId = new List();
    List<String> listNameExpenditureFixed = new List();
    List<String> listGroupNameExpenditureFixed = new List();
    List<double> listMoneyExpenditureFixed = new List();
    List<int> listDateDeal = new List();

    var rows = await dbHelper.queryRowsKey(key, dateStart, dateEnd);
    int count = rows.length;

    for (int i = 0; i < count; i++) {
      var row = rows[i];
      listPrimaryKey.add(row[listExpenditure[0]]);
      listId.add(row[listExpenditure[1]]);
      listNameExpenditureFixed.add(row[listExpenditure[2]]);
      listGroupNameExpenditureFixed.add(row[listExpenditure[3]]);
      listMoneyExpenditureFixed.add(row[listExpenditure[4]]);
      listDateDeal.add(row[listExpenditure[5]]);
    }

    list.add(listPrimaryKey);
    list.add(listId);
    list.add(listNameExpenditureFixed);
    list.add(listGroupNameExpenditureFixed);
    list.add(listMoneyExpenditureFixed);
    list.add(listDateDeal);

    return list;
  }

  //lấy listMoney từ ngày "dateStart" đến ngày "dateEnd"
  Future<List> listMoneyStartEnd(int dateStart, int dateEnd) async {
    List<double> listMoney = [0, 0, 0, 0, 0, 0, 0];

    var rows = await dbHelper.queryRowsList(dateStart, dateEnd);
    int count = rows.length;
    int size = listGroupNameExpenditure.length;

    for (int i = 0; i < count; i++) {
      String nameGroup = rows[i][listExpenditure[3]];
      double money = rows[i][listExpenditure[4]];
      for (int j = 0; j < size; j++) {
        if (nameGroup == listGroupNameExpenditure[j]) {
          listMoney[j] = listMoney[j] + money;
          break;
        }
      }
    }
    return listMoney;
  }

  //get all listMoney from database
  Future<List> listMoney() async {
    List<double> listMoney = [0, 0, 0, 0, 0, 0, 0];

    var rows = await dbHelper.queryAllRows();
    int count = rows.length;
    int size = listGroupNameExpenditure.length;

    for (int i = 0; i < count; i++) {
      String nameGroup = rows[i][listExpenditure[3]];
      double money = rows[i][listExpenditure[4]];
      for (int j = 0; j < size; j++) {
        if (nameGroup == listGroupNameExpenditure[j]) {
          listMoney[j] = listMoney[j] + money;
          break;
        }
      }
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

}