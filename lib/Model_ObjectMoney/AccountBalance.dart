import 'package:maganemoney/database/AccountBalanceTable.dart';

class AccountBalance {
  int _idUser;
  double _sumCurrentMoney;

  AccountBalance({ int idUser: 0, double sumCurrentMoney: 0.0 }) {
    this._idUser = idUser;
    this._sumCurrentMoney = sumCurrentMoney;
  }

  Map<String, dynamic> toMap() {
    return {
      'ID_USER': this._idUser,
      'SUM_CURRENT_MONEY': this._sumCurrentMoney,
    };
  }

  static AccountBalance accountBalance = new AccountBalance(idUser: 0, sumCurrentMoney: 0.0);

  final dbHelper = AccountBalanceTable.instance;

  Future<List> allRows() async {
    return await dbHelper.queryAllRows();
  }

  void insertAccountBalance(AccountBalance ex) async {
    final insert = await dbHelper.insertAccountBalance(ex.toMap());
    print("chen thanh cong");
  }

  void deleteRows() async {
    final id = await dbHelper.queryRowCount();
    await dbHelper.deleteAccountBalance(id);
  }

  void deleteRow(int id) async {
    await dbHelper.deleteAccountBalance(id);
  }

  void query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows: AccountBalance: ');
    allRows.forEach((row) => print(row));

    print(allRows[0]);
  }

  Future<int> findPrimaryKey(int value, String key) async {
    final rowsVal = await dbHelper.queryAllRows();
    var s = rowsVal[value][key];
    return s;
  }

  void updateSumCurrentMoney(int idUser, double sumCurrentMoney) async {
    var rows = await dbHelper.queryAllRows();
    int idTable = rows[0][AccountBalanceTable.columnIdTable];
    Map<String, dynamic> updateSumCurrentMoney = {
      AccountBalanceTable.columnIdTable : idTable,
      AccountBalanceTable.columnId : idUser,
      AccountBalanceTable.columnSumCurrentMoney : sumCurrentMoney,
    };

    await dbHelper.updateAccountBalance(updateSumCurrentMoney);
    print('update thanh cong class Acccount Balance');
  }
  Future<int> count() async {
    return await dbHelper.queryRowCount();
  }

  Future<List<List>> getAllData() async {
    List<int> listPrimaryKey = new List();
    List<int> listIdUser = new List();
    List<double> listSumCurrentMoney = new List();

    var rows = await dbHelper.queryAllRows();
    int count = rows.length;
    var listAccountBalance = AccountBalanceTable.listColumnAccountBalance;

    for (int i = 0; i < count; i++) {
      var row = rows[i];

      listPrimaryKey.add(row[listAccountBalance[0]]);
      listIdUser.add(row[listAccountBalance[1]]);
      listSumCurrentMoney.add(row[listAccountBalance[2]]);
    }

    List<List> list  = new List();
    list.add(listPrimaryKey);
    list.add(listIdUser);
    list.add(listSumCurrentMoney);

    return list;
  }

  Future<double> getSumCurrentMoney() async {
    final rowsCurrentMoney = await dbHelper.queryAllRows();
    return rowsCurrentMoney[0][AccountBalanceTable.columnSumCurrentMoney];
  }

  double get sumCurrentMoney => _sumCurrentMoney;

  set sumCurrentMoney(double value) {
    _sumCurrentMoney = value;
  }

  int get idUser => _idUser;

  set idUser(int value) {
    _idUser = value;
  }
}