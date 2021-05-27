import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maganemoney/login/EventLogin.dart';
import 'package:maganemoney/Model_ObjectMoney/AccountBalance.dart';
import 'package:maganemoney/schedule/EventSchedule.dart';
import 'package:provider/provider.dart';

import 'Table_Calendar_Schedule.dart';

class MakeAScheduleTextField extends StatelessWidget {

  void _awaitReturnValueFromScheduleToCalendar_Schedule(BuildContext context, EventSchedule eventSchedule) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Calendar(),
        ));
    String dateDealStart = result['dateStartString'];
    if (dateDealStart != null) {
      eventSchedule.changeDateStartSchedule(context, dateDealStart);
      eventSchedule.changeDateStartScheduleInteger(context, result['dateStart']);
    }
    else {
      eventSchedule.changeDateStartSchedule(context, 'Select Date To Start');
    }
  }

  Widget SetMoney(BuildContext context, EventSchedule eventSchedule, FocusScopeNode currentFocus) {
    return GestureDetector(
      onTap: () {
        currentFocus.requestFocus();
      },
      child: Container(
        padding: EdgeInsets.only(top: 20, right: 5),
        child: TextField(
          controller: eventSchedule.myControllerMoney,
          keyboardType: TextInputType.numberWithOptions(
            decimal: true,
          ),
          decoration: new InputDecoration(
              icon: Icon(Icons.monetization_on, color: Colors.greenAccent, size: 25),
              hintText: "Money",
              suffixText: '\$',
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 36.0,
                  )
              )
          ),
        ),
      ),
    );
  }

  Widget SetTime(BuildContext context, EventSchedule eventSchedule, FocusScopeNode currentFocus) {
    return GestureDetector(
      onTap: () {
        currentFocus.requestFocus();
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, right: 5),
        child: TextField(
          controller: eventSchedule.myControllerTime,
          keyboardType: TextInputType.numberWithOptions(
            decimal: true,
          ),
          decoration: new InputDecoration(
              icon: Icon(Icons.timer, color: Colors.lightGreen[600], size: 25,),
              hintText: "Time (How long will you do it?)",
              suffixText: 'months',
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 36.0,
                  )
              )
          ),
        ),
      ),
    );
  }

  Widget SetMoneyAMonth(BuildContext context, EventSchedule eventSchedule, FocusScopeNode currentFocus) {
    return GestureDetector(
      onTap: () {
        currentFocus.requestFocus();
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, right: 5),
        child: TextField(
          controller: eventSchedule.myControllerMoneyAMonth,
          keyboardType: TextInputType.numberWithOptions(
            decimal: true,
          ),
          decoration: new InputDecoration(
              icon: Icon(Icons.monetization_on, color: Colors.redAccent, size: 25),
              hintText: "How much money a month will you save?",
              suffixText: '\$',
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 36.0,
                  )
              )
          ),
        ),
      ),
    );
  }

  Widget SetTimeStart(BuildContext context, EventSchedule eventSchedule) {
    return Container(
      padding: EdgeInsets.only(top: 10, right: 5),
      child: Row(
        children: [
          Icon(Icons.date_range, color: Colors.deepPurpleAccent,),
          Expanded(child: Container(
            padding: EdgeInsets.only(left: 15),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.greenAccent,
              ),
              child: ListTile( //Input Select Date
                //leading:
                title: Text(eventSchedule.dateStartSchedule, style: TextStyle(fontSize: 15),),
                onTap: () {
                  _awaitReturnValueFromScheduleToCalendar_Schedule(context, eventSchedule);
                },
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget SetNameSchedule(BuildContext context, EventSchedule eventSchedule, FocusScopeNode currentFocus) {
    return GestureDetector(
      onTap: () {
        currentFocus.requestFocus();
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, right: 5),
        child: TextField(
          controller: eventSchedule.myControllerNameSchedule,
          decoration: new InputDecoration(
              icon: Icon(Icons.schedule_sharp, color: Colors.lightGreen[600], size: 25,),
              hintText: "What is your schedule?",
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 36.0,
                  )
              )
          ),
        ),
      ),
    );
  }

  Widget makeSchedule(BuildContext context, EventSchedule eventSchedule, FocusScopeNode currentFocus) {
    return Container(
      child: Column(
        children: [
          SetMoney(context, eventSchedule, currentFocus),
          SetMoneyAMonth(context, eventSchedule, currentFocus),
          SetTime(context, eventSchedule, currentFocus),
          SetTimeStart(context, eventSchedule),
          SetNameSchedule(context, eventSchedule, currentFocus),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    return SafeArea(
        child: ChangeNotifierProvider(
          create: (context) {
            return EventSchedule();
          },
          child: Consumer<EventSchedule>(
            builder: (context, eventSchedule, child) {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.clear, size: 30,),
                    onPressed: () {
                      Navigator.pop(context);
                      currentFocus.unfocus();
                    },
                  ),
                  title: Text('Planing a schedule'),
                  actions: [
                    FlatButton(
                      child: Text('SAVE'),
                      onPressed: () async {
                        String nameSchedule = eventSchedule.myControllerNameSchedule.text;
                        double moneyAMonth = double.parse(eventSchedule.myControllerMoneyAMonth.text);

                        if (eventSchedule.checkCanSavewithMakeNameSchedule(eventSchedule) == 1) {
                          double sumCurrentMoney = await AccountBalance.accountBalance.getSumCurrentMoney();
                          if (sumCurrentMoney - moneyAMonth <= 0) {
                            eventSchedule.flustBarMoneyFailed.show(context);
                          }
                          else {
                            sumCurrentMoney = sumCurrentMoney - moneyAMonth;
                            AccountBalance.accountBalance.updateSumCurrentMoney(EventLogin.id, sumCurrentMoney);

                            eventSchedule.SaveSchedule(context, eventSchedule, nameSchedule);
                            currentFocus.unfocus();
                          }
                        }
                        else {
                          eventSchedule.flushbarFalse.show(context);
                        }
                      },
                    ),
                  ],
                ),
                body: makeSchedule(context, eventSchedule, currentFocus),
              );
            },
          ),
        )
    );
  }
}