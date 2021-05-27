import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maganemoney/login/EventLogin.dart';
import 'package:maganemoney/Model_ObjectMoney/ScheduleObject.dart';

class EventSchedule extends ChangeNotifier {

  TextEditingController myControllerMoney = new TextEditingController();
  TextEditingController myControllerMoneyAMonth = new TextEditingController();
  TextEditingController myControllerTime = new TextEditingController();
  TextEditingController myControllerNameSchedule = new TextEditingController();

  String dateStartSchedule = 'Select Date To Start';
  int dateStartSchduleInteger = 0;

  String nameSchedule = 'Name of Schedule';
  List<String> listNameSchedule = ['House', 'Car', 'Tech-product', 'Travel'];

  int checkCanSave(EventSchedule eventSchedule) {
    if (eventSchedule.myControllerMoney.text == '' || eventSchedule.myControllerTime.text == ''
        || eventSchedule.dateStartSchedule == 'Select Date To Start' || myControllerMoneyAMonth.text == '') {
      return 0;
    }
    else {
      return 1;
    }
  }

  int checkCanSavewithMakeNameSchedule(EventSchedule eventSchedule) {
    if (eventSchedule.myControllerMoney.text == '' || eventSchedule.myControllerTime.text == ''
        || eventSchedule.dateStartSchedule == 'Select Date To Start' || eventSchedule.myControllerNameSchedule.text == ''
        || myControllerMoneyAMonth.text == '' || myControllerMoneyAMonth.text == '') {
      return 0;
    }
    else {
      return 1;
    }
  }

  int checkThisScheduleHaved(EventSchedule eventSchedule, List<String> listName) {
    int size = listName.length;
    for (int i = 0; i < size; i++) {
      if (listName[i] == this.nameSchedule) {
        return 1;
      }
    }
    return 0;
  }

  void SaveSchedule(BuildContext context, EventSchedule eventSchedule, String nameOfSchedule) {
    String dateStart = eventSchedule.dateStartSchedule;
    double moneyAMonth = double.parse(eventSchedule.myControllerMoneyAMonth.text);

    ScheduleObject.scheduleObject.idUser = EventLogin.id;
    ScheduleObject.scheduleObject.nameSchedule = nameOfSchedule;
    ScheduleObject.scheduleObject.interval = int.parse(eventSchedule.myControllerTime.text);
    ScheduleObject.scheduleObject.moneyForSchedule = double.parse(eventSchedule.myControllerMoney.text);
    ScheduleObject.scheduleObject.dateStartSchedule = dateStart;
    ScheduleObject.scheduleObject.moneyAMonth = moneyAMonth;
    ScheduleObject.scheduleObject.currentMoney = moneyAMonth;
    ScheduleObject.scheduleObject.stateSchedule = -1;
    ScheduleObject.scheduleObject.dateUpdateSchedule = this.dateStartSchduleInteger;

    ScheduleObject.scheduleObject.insertSchedule(ScheduleObject.scheduleObject);

    eventSchedule.myControllerMoney.clear();
    eventSchedule.myControllerTime.clear();
    eventSchedule.myControllerNameSchedule.clear();
    eventSchedule.myControllerMoneyAMonth.clear();
    Navigator.pop(context);
    flushbarSucessful.show(context);
  }

  final flushbarSucessful = Flushbar(
    duration: Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.TOP,
    messageText: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('NOTIFICATION',
            style: TextStyle(color: Colors.tealAccent[400], fontWeight: FontWeight.bold)),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text("You've created a successful plan. Good luck", style: TextStyle(color: Colors.lightBlue[50])),
        ),
      ],
    ),
    padding: const EdgeInsets.only(top: 10, bottom: 20),
    isDismissible: true,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    backgroundColor: Colors.blueGrey[700],
    leftBarIndicatorColor: Colors.tealAccent[400],
  );

  final flushbarFalse = Flushbar(
    duration: Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.TOP,
    messageText: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('NOTIFICATION',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text("Planing a chedule is failed", style: TextStyle(color: Colors.lightBlue[50])),
        ),
      ],
    ),

    padding: const EdgeInsets.only(top: 10, bottom: 20),
    isDismissible: true,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    backgroundColor: Colors.blueGrey[700],
    leftBarIndicatorColor: Colors.red,
  );

  final flustBarMoneyFailed = Flushbar(
    duration: Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.TOP,
    messageText: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('NOTIFICATION',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text("Account Balance is not enough", style: TextStyle(color: Colors.lightBlue[50])),
        ),
      ],
    ),

    padding: const EdgeInsets.only(top: 10, bottom: 20),
    isDismissible: true,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    backgroundColor: Colors.blueGrey[700],
    leftBarIndicatorColor: Colors.red,
  );

  void changeDateStartSchedule(BuildContext context, String s) {
    this.dateStartSchedule = s;
    notifyListeners();
  }

  void changeDateStartScheduleInteger(BuildContext context, int dateStart) {
    this.dateStartSchduleInteger = dateStart;
    notifyListeners();
  }
  void changeName(BuildContext context, int index) {
    this.nameSchedule = this.listNameSchedule[index];
    notifyListeners();
  }

  String NameSchedule() {
    return this.nameSchedule;
  }
}