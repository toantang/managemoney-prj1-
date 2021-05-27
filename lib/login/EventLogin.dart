import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maganemoney/Model_ObjectMoney//User.dart';
import 'package:flushbar/flushbar.dart';

class EventLogin extends ChangeNotifier {
  User user = new User();
  List list = new List();
  static int id = 1;
  bool errorEmail = false;
  bool errorPassword = false;
  bool errorUserName = false;
  bool errorAge = false;
  bool errorConfirmPassword = false;

  void ChangeErrorEmail(EventLogin eventLogin, bool x) {
    eventLogin.errorEmail = x;
    notifyListeners();
  }
  void ChangeErrorPassword(EventLogin eventLogin, x) {
    eventLogin.errorPassword = x;
    notifyListeners();
  }
  void ChangeErrorUserName(EventLogin eventLogin) {
    eventLogin.errorUserName = true;
    notifyListeners();
  }
  void ChangeErrorAge(EventLogin eventLogin) {
    eventLogin.errorAge = true;
    notifyListeners();
  }
  void ChangeErrorConfirmPassword(EventLogin eventLogin) {
    eventLogin.errorConfirmPassword = true;
    notifyListeners();
  }

  TextEditingController controllerUserName = new TextEditingController();
  TextEditingController controllerAge = new TextEditingController();
  TextEditingController controllerEmailLogin = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();
  TextEditingController controllerConfirmPassword = new TextEditingController();

  //Sign up App
  Future<bool> canLoginAndInsert(EventLogin eventLogin) async {
    list = await user.queryAllRows();
    int size = list.length;
    if (size == 0 ) {
      return true;
    }
    else if (await checkEmailLoginRight(eventLogin) == false) {
      return true;
    }
    else {
      return false;
    }
  }

  // Sign In App
  Future<bool> canLoginRight(EventLogin eventLogin) async {
    list = await user.queryAllRows();
    if (await checkEmailLoginRight(eventLogin) == true && await checkPasswordRight(eventLogin) == true) {
      return true;
    }
    else {
      return false;
    }
  }
  // kiem tra xem Email nay co ton tai trong database hay khong
  Future<bool> checkEmailLoginRight(EventLogin eventLogin) async {
    list = await user.queryAllRows();
    int size = list.length;
    for (int i = 0; i < size; i++) {
      if (list[i]['mail'] == eventLogin.controllerEmailLogin.text) {
        EventLogin.id = list[i]['ID_USER'];
        User.user.id = list[i]['ID_USER'];
        EventLogin.id = User.user.id;
        return true;
      }
    }
    return false;
  }

  Future<bool> checkPasswordRight(EventLogin eventLogin) async {
    list = await user.queryAllRows();
    int size = list.length;
    for (int i = 0; i < size; i++) {
      if (list[i]['pass'] == eventLogin.controllerPassword.text) {
        return true;
      }
    }
    return false;
  }

  bool checkEmailLoginNULL(EventLogin eventLogin) {
    // ignore: unrelated_type_equality_checks
    if (eventLogin.controllerEmailLogin.text == "") {
      return true;
    }
    else {
      return false;
    }
  }
  void showFlushbarEmailLogin(BuildContext context, EventLogin eventLogin, String noti) async {
    final flushbarEmailnotRight = Flushbar(
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      messageText: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('NOTIFICATION',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text("$noti", style: TextStyle(color: Colors.lightBlue[50])),
          ),
        ],
      ),
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      isDismissible: true,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      backgroundColor: Colors.blueGrey[700],
      leftBarIndicatorColor: Colors.red,
    );
    flushbarEmailnotRight.show(context);
  }

  bool checkPassWordNULL(EventLogin eventLogin) {
    // ignore: unrelated_type_equality_checks
    if (eventLogin.controllerPassword.text == "") {
      return true;
    }
    else {
      return false;
    }
  }
  void showFlushbarPasswordLogin(BuildContext context, EventLogin eventLogin, String noti) async {
    final flushbarPasswordnotRight = Flushbar(
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      messageText: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('NOTIFICATION',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text("$noti", style: TextStyle(color: Colors.lightBlue[50])),
          ),
        ],
      ),
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      isDismissible: true,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      backgroundColor: Colors.blueGrey[700],
      leftBarIndicatorColor: Colors.red,
    );
    flushbarPasswordnotRight.show(context);
  }

  bool checkUserNameNULL(EventLogin eventLogin) {
    if (eventLogin.controllerUserName.text == '') {
      return true;
    }
    else {
      return false;
    }
  }

  bool checkAgeNULL(EventLogin eventLogin) {
    if (eventLogin.controllerAge.text == '') {
      return true;
    }
    else {
      return false;
    }
  }

  bool checkConfirmPasswordNULL(EventLogin eventLogin) {
    if (eventLogin.controllerConfirmPassword.text == '') {
      return true;
    }
    else {
      return false;
    }
  }
}