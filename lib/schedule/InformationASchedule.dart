import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maganemoney/login/EventLogin.dart';
import 'package:maganemoney/Model_ObjectMoney/ScheduleObject.dart';
import 'package:provider/provider.dart';

import 'EventInformationASchedule.dart';
import 'ListScheduleUnfinished.dart';

class InformationASchedule extends StatelessWidget {
  final String nameSchedule;
  final int interval;
  final double moneyForSchedule;
  final String dateStart;
  final double moneyAMonth;
  final int id;
  final double currentMoney;
  final int stateSchedule;
  final int dateUpdateSchedule;
  final int check; // check = 0 thi chuyen ve UnfinishedScheduleView, check = 1 thi chuyen ve FinishedScheduleView

  InformationASchedule({Key key, @required this.nameSchedule, @required this.interval, @required this.moneyForSchedule, @required this.dateStart,
    @required this.moneyAMonth, @required this.id, @required this.currentMoney, @required this.stateSchedule,
    @required this.dateUpdateSchedule, @required this.check}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              backgroundColor: Colors.lightGreenAccent,
              leading: IconButton(
                icon: Icon(Icons.clear, color: Colors.blueGrey[900],),
                onPressed: () {
                  if (this.check == 1) {
                    Navigator.pop(context);
                  }
                  else {
                    ScheduleObject.scheduleObject.update(this.id, EventLogin.id, this.nameSchedule, this.interval,
                        this.moneyForSchedule, this.dateStart, this.moneyAMonth, this.currentMoney, this.stateSchedule,
                        this.dateUpdateSchedule);
                    Navigator.pop(context);
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => InformationScheduleUnfinished(),
                    ));
                  }
                },
              ),
              actions: [
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      ScheduleObject.scheduleObject.deleteRow(this.id);
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => InformationScheduleUnfinished(),
                      ));
                    }
                ),
              ]
          ),
          body: Column(
            children: [
              InformationNameSchedule(context),
              InformationInterval(context),
              InformationMoneyForSchedule(context),
              InformationDateStart(context),
              InformationMoneyAMonth(context),
              InformationCurrentMoney(context),
            ],
          )
      ),
    );
  }

  void updateNameSchedule(BuildContext context, EventInformationSchedule eventInformationSchedule) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Container(
            child: AlertDialog(
              content: new Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: eventInformationSchedule.textFieldController,
                      )
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      String nameSchedule = eventInformationSchedule.textFieldController.text;
                      Navigator.pop(context);
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return InformationASchedule(nameSchedule: nameSchedule, interval: this.interval,
                              moneyForSchedule: this.moneyForSchedule, dateStart: this.dateStart, moneyAMonth: this.moneyAMonth,
                              id: this.id, currentMoney: this.currentMoney, stateSchedule: this.stateSchedule,
                              dateUpdateSchedule: this.dateUpdateSchedule,
                            );
                          }
                      ));
                    },
                    child: Text('YES', style: TextStyle(fontSize: 15),)
                )
              ],
            ),
          );
        }
    );
  }

  void updateInterval(BuildContext context, EventInformationSchedule eventInformationSchedule) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Container(
            child: AlertDialog(
              content: new Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: eventInformationSchedule.textFieldController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                      )
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      String inter = eventInformationSchedule.textFieldController.text;
                      int interval = int.parse(inter);
                      Navigator.pop(context);
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            print('interval changed: $interval');
                            return InformationASchedule(nameSchedule: this.nameSchedule, interval: interval,
                              moneyForSchedule: this.moneyForSchedule,
                              dateStart: this.dateStart, moneyAMonth: this.moneyAMonth, id: this.id,
                              currentMoney: this.currentMoney, stateSchedule: this.stateSchedule,
                              dateUpdateSchedule: this.dateUpdateSchedule,
                            );
                          }
                      ));
                    },
                    child: Text('YES', style: TextStyle(fontSize: 15),)
                )
              ],
            ),
          );
        }
    );
  }
  void updateMoneyForSchedule(BuildContext context, EventInformationSchedule eventInformationSchedule) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Container(
            child: AlertDialog(
              content: new Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: eventInformationSchedule.textFieldController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                      )
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      String money = eventInformationSchedule.textFieldController.text;
                      double moneyForSchedule = double.parse(money);
                      Navigator.pop(context);
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return InformationASchedule(nameSchedule: this.nameSchedule, interval: this.interval,
                              moneyForSchedule: moneyForSchedule,
                              dateStart: this.dateStart, moneyAMonth: this.moneyAMonth, id: this.id,
                              currentMoney: this.currentMoney, stateSchedule: this.stateSchedule,
                              dateUpdateSchedule: this.dateUpdateSchedule,
                            );
                          }
                      ));
                    },
                    child: Text('YES', style: TextStyle(fontSize: 15),)
                )
              ],
            ),
          );
        }
    );
  }
  void updateMoneyAMonth(BuildContext context, EventInformationSchedule eventInformationSchedule) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Container(
            child: AlertDialog(
              content: new Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: eventInformationSchedule.textFieldController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                      )
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      String money = eventInformationSchedule.textFieldController.text;
                      double moneyAMonth = double.parse(money);
                      Navigator.pop(context);
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            DateTime dateTime = DateTime.now();
                            int dayNow = dateTime.day;
                            int monthNow = dateTime.month;
                            int yearNow = dateTime.year;

                            return InformationASchedule(nameSchedule: this.nameSchedule, interval: this.interval,
                              moneyForSchedule: this.moneyForSchedule,
                              dateStart: this.dateStart, moneyAMonth: moneyAMonth, id: this.id,
                              currentMoney: this.currentMoney, stateSchedule: this.stateSchedule,
                              dateUpdateSchedule: this.dateUpdateSchedule,
                            );
                          }
                      ));
                    },
                    child: Text('YES', style: TextStyle(fontSize: 15),)
                )
              ],
            ),
          );
        }
    );
  }

  //Information name Schedule
  Widget InformationNameSchedule(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventInformationSchedule(),
      child: Consumer<EventInformationSchedule> (
        builder: (context, eventInformationSchedule, child) {
          return Container(
            padding: EdgeInsets.only(top: 10),
            child: ListTile(
              onTap: () {
                updateNameSchedule(context, eventInformationSchedule);
              },
              leading: Icon(Icons.shopping_cart, color: Colors.indigo[300]),
              title: Text("Name: " + this.nameSchedule,
                style: TextStyle(fontSize: 20),),
            ),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 1.5, color: Colors.lightGreen[300]),
                    bottom: BorderSide(width: 1.5, color: Colors.lightGreen[300])
                )
            ),
          );
        }
      )
    );
  }

  //Information Interval
  Widget InformationInterval(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => EventInformationSchedule(),
        child: Consumer<EventInformationSchedule> (
            builder: (context, eventInformationSchedule, child) {
              return Container(
                padding: EdgeInsets.only(top: 10),
                child: ListTile(
                  onTap: () {
                    updateInterval(context, eventInformationSchedule);
                  },
                  leading: Icon(Icons.timelapse, color: Colors.greenAccent,),
                  title: Text("Interval: " + this.interval.toString(),
                    style: TextStyle(fontSize: 20),),
                ),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 1.5, color: Colors.lightGreen[300]),
                        bottom: BorderSide(width: 1.5, color: Colors.lightGreen[300])
                    )
                ),
              );
            }
        )
    );
  }


  //Information Money for sChedule
  Widget InformationMoneyForSchedule(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => EventInformationSchedule(),
        child: Consumer<EventInformationSchedule> (
            builder: (context, eventInformationSchedule, child) {
              List<String> moneyString = this.moneyForSchedule.toString().split('.');
              String phanNguyen = eventInformationSchedule.PhanNguyen(moneyString[0]);
              String tachThapPhan = moneyString[1];
              String phanThapPhan = '0';
              if (tachThapPhan == '0') {

              }
              else {
                phanThapPhan = eventInformationSchedule.PhanThapPhan(tachThapPhan);
              }

              return Container(
                padding: EdgeInsets.only(top: 10),
                child: ListTile(
                  onTap: () {
                    updateMoneyForSchedule(context, eventInformationSchedule);
                  },
                  leading: Icon(Icons.money),
                  title: Text("Money for Schedule: " + phanNguyen + phanThapPhan,
                    style: TextStyle(fontSize: 20),),
                ),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 1.5, color: Colors.lightGreen[300]),
                        bottom: BorderSide(width: 1.5, color: Colors.lightGreen[300])
                    )
                ),
              );
            }
        )
    );

  }

  //Information Date start Schedule
  Widget InformationDateStart(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => EventInformationSchedule(),
        child: Consumer<EventInformationSchedule> (
            builder: (context, eventInformationSchedule, child) {
              return Container(
                padding: EdgeInsets.only(top: 10),
                child: ListTile(
                  leading: Icon(Icons.date_range),
                  title: Text('Date Start: ' + this.dateStart, style: TextStyle(fontSize: 20),),
                ),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 1.5, color: Colors.lightGreen[300]),
                        bottom: BorderSide(width: 1.5, color: Colors.lightGreen[300])
                    )
                ),
              );
            }
        )
    );

  }

  //Information Money a Month
  Widget InformationMoneyAMonth(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => EventInformationSchedule(),
        child: Consumer<EventInformationSchedule> (
            builder: (context, eventInformationSchedule, child) {
              return Container(
                padding: EdgeInsets.only(top: 10),
                child: ListTile(
                  onTap: () {
                    updateMoneyAMonth(context, eventInformationSchedule);
                  },
                  leading: Icon(Icons.monetization_on_outlined),
                  title: Text("Money a Month: " + this.moneyAMonth.toString()),
                ),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 1.5, color: Colors.lightGreen[300]),
                        bottom: BorderSide(width: 1.5, color: Colors.lightGreen[300])
                    )
                ),
              );
            }
        )
    );

  }

  //Information Current Money for Schedule
  Widget InformationCurrentMoney(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => EventInformationSchedule(),
        child: Consumer<EventInformationSchedule> (
            builder: (context, eventInformationSchedule, child) {
              return Container(
                padding: EdgeInsets.only(top: 10),
                child: ListTile(
                  onTap: () {
                    updateMoneyAMonth(context, eventInformationSchedule);
                  },
                  leading: Icon(Icons.monetization_on_outlined, color: Colors.blue,),
                  title: Text("Current Money: " + this.currentMoney.toString()),
                ),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 1.5, color: Colors.lightGreen[300]),
                        bottom: BorderSide(width: 1.5, color: Colors.lightGreen[300])
                    )
                ),
              );
            }
        )
    );

  }

}