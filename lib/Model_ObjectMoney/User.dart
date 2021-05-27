import 'package:maganemoney/database/UserTable.dart';

class User {
  int _id;
  String _name;
  int _age;
  String _mail;
  String _pass;

  User({String name: '', int age: 0, String mail: '', String pass: ''}) {
    this._name = name;
    this._age = age;
    this._mail = mail;
    this._pass = pass;
  }

  Map<String, dynamic> toMap() {
    return {
      'ID_USER': this._id,
      'name': this._name,
      'age': this._age,
      'pass': this._pass,
      'mail': this._mail,
    };
  }

  static User user = new User(name: 'null', age: 0, mail: 'null', pass: 'null');
  @override
  String toString() {
    return 'User{id: $_id, name: $_name, age: $_age, mail: $_mail, pass: $_pass';
  }

  final dbHelper = UserTable.instance;

  void insertUser(User ex) async {
    final insert = await dbHelper.insertUser(ex.toMap());
    print("chen thanh cong");
  }

  Future<int> getCountRows() async {
    return await dbHelper.queryRowCount();
  }

  Future<List> queryAllRows() async {
    List list = new List();
    list = await dbHelper.queryAllRows();
    return list;
  }

  void update(int id, String userName, int age, String mail, String password) async {
    Map<String, dynamic> updateRows = {
      UserTable.columnId: id,
      UserTable.columnName: userName,
      UserTable.columnAge: age,
      UserTable.columnMail: mail,
      UserTable.columnPass: pass,
    };
    await dbHelper.updateUser(updateRows);
  }
  Future<String> getName(int id) async {
    var rows = await dbHelper.queryRows(id);
    String name = rows[0][listColumneName[1]];
    return name;
  }

  List<String> listColumneName = UserTable.listColumnUser;
  Future<List<List>> queryUser(int id) async {
    List<int> listPrimaryKey = new List();
    List<String> listName = new List();
    List<int> listAge = new List();
    List<String> listMail = new List();
    List<String> listPass = new List();

    List s = await dbHelper.queryRows(id);
    int size = s.length;
    for (int i = 0; i < size; i++) {
      var ss = s[i];
      listPrimaryKey.add(ss[listColumneName[0]]);
      listName.add(ss[listColumneName[1]]);
      listAge.add(ss[listColumneName[2]]);
      listMail.add(ss[listColumneName[3]]);
      listPass.add(ss[listColumneName[4]]);
    }

    List<List> list = new List();
    list.add(listPrimaryKey);
    list.add(listName);
    list.add(listAge);
    list.add(listMail);
    list.add(listPass);
    return list;
  }

  String get pass => _pass;

  set pass(String value) {
    _pass = value;
  }

  String get mail => _mail;

  set mail(String value) {
    _mail = value;
  }

  int get age => _age;

  set age(int value) {
    _age = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

}