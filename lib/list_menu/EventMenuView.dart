import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maganemoney/Model_ObjectMoney/Expenditure.dart';
import 'package:maganemoney/Model_ObjectMoney/ExpenditureFixed.dart';
import 'package:maganemoney/Model_ObjectMoney/Turonver.dart';
import 'package:maganemoney/Model_ObjectMoney/TuronverFixed.dart';

import 'package:maganemoney/login/EventLogin.dart';
import '../listObjectUseEveryClass.dart';
import 'package:maganemoney/Model_ObjectMoney/Deals.dart';

class EventMenuView with ChangeNotifier {
  String textGroupMoney = 'Expenditure';
  String textName = 'Name of Group Money';
  String textGroupName = 'Group Name'; //example: GroupName: Eat&Food, Name: Eat, Food
  String frequency = '';
  TextEditingController moneyController = new TextEditingController();
  TextEditingController frequencyCotroller = new TextEditingController();
  String textDate = 'Select Date';

  void SaveDealInDatabase(EventMenuView eventMenuView, int ObjectGroupMoney, double money) {
    int idUser = EventLogin.id;

    ((ListUseEveryClass.listObject)[ObjectGroupMoney]).id = idUser;
    ((ListUseEveryClass.listObject)[ObjectGroupMoney]).nameDeal = eventMenuView.textName;
    ((ListUseEveryClass.listObject)[ObjectGroupMoney]).groupNameDeal = eventMenuView.textGroupName;
    ((ListUseEveryClass.listObject)[ObjectGroupMoney]).moneyDeal = money;
    ((ListUseEveryClass.listObject)[ObjectGroupMoney]).dateDeal = Deal.deal.dateDeal;


    if (ObjectGroupMoney == 0) {
      Expenditure.expenditure.insertExpenditure(Expenditure.expenditure);
      print('chen thanh cong Expenditure');
    }
    else if (ObjectGroupMoney == 1) {

      ExpenditureFixed.expenditureFixed.frequencyExpenditureFixed = double.parse(eventMenuView.frequency);
      ExpenditureFixed.expenditureFixed.moneyFrequencyExpenditureFixed = money;
      ExpenditureFixed.expenditureFixed.insertExpenditureFixed(ExpenditureFixed.expenditureFixed);
      print("chen thanh cong Expenditure Fixed");
    }
    else if (ObjectGroupMoney == 2) {
      Turnover.turnover.insertTurnover(Turnover.turnover);
      print('chen thanh cong Turnover');
    }
    else if (ObjectGroupMoney == 3) {

      TurnoverFixed.turnoverFixed.frequencyTurnoverFixed = double.parse(eventMenuView.frequency);
      TurnoverFixed.turnoverFixed.moneyFrequencyTurnoverFixed = money;
      TurnoverFixed.turnoverFixed.insertExpenditureFixed(TurnoverFixed.turnoverFixed);
      print("chen thanh cong Turnover Fixed");
    }
  }

  //two method used in TurnoverViewFixed and ExpenditureViewFixed
  bool checkTextFieldNull(frequency) {
    if (frequency == "") {
      return true;
    }
    else {
      return false;
    }
  }
  void AddNameFail(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Container(
            child: AlertDialog(
              title: Text('Frequency is Empty'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('YES', style: TextStyle(fontSize: 15),)
                )
              ],
            ),
          );
        }
    );
  }

}