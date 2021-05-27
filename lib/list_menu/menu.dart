import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maganemoney/Model_ObjectMoney/AccountBalance.dart';
import 'package:maganemoney/Model_ObjectMoney/Deals.dart';
import 'package:maganemoney/list_catalog_expenditure/Catalog_group.dart';
import 'package:maganemoney/list_menu/EventMenuView.dart';
import 'package:maganemoney/login/EventLogin.dart';
import 'package:provider/provider.dart';

import 'ExpenditureFixedView.dart';
import 'Table_Calendar.dart';
import 'TurnoverFixedView.dart';
import 'TuronverView.dart';

class Menu extends StatefulWidget {

  @override
  _Menu createState() {
    return _Menu();
  }
}

class _Menu extends State<Menu> {
  int _value = 0;
  List<Widget> listGroupMoney = [CatalogGroup(), ExpenditureFixedView(), TurnoverView(), TurnoverFixedView()];
  List<String> listNameGroupMoney = ['Expenditure', 'Expenditure Fixed', 'Turnover', 'Turnover Fixed'];

  void _awaitReturnValueFromCalendar(BuildContext context, EventMenuView eventMenuView) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Calendar(),
        ));
    String date = result['date'];
    setState(() {
      if (date != null) {
        eventMenuView.textDate = date;
      }
      else {
        eventMenuView.textDate = 'Select Date';
      }
    });
  }

  void _awaitReturnValueFromSelectGroup(BuildContext context, int index, EventMenuView eventMenuView) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => listGroupMoney[index],
        ));
    String name = result['name'];
    String groupName = result['groupName'];
    String frequency = result['frequency'];
    setState(() {
      if (name != null) {
        eventMenuView.textName = name;
        eventMenuView.textGroupName = groupName;
        eventMenuView.frequency = frequency;
      }
      else {
        eventMenuView.textName = 'Name of Group Money';
        eventMenuView.textGroupName = 'Group Name';
      }
    });
  }

  int checkCanSave(EventMenuView eventMenuView) {
    if (eventMenuView.moneyController.text != '' && eventMenuView.textName != 'Name of Group Money' &&
        eventMenuView.textDate != 'Select Date') {
      return 1;
    }
    else {
      return 0;
    }
  }

  int InsertADeal(EventMenuView eventMenuView) {
    int size = listNameGroupMoney.length;
    int i = 0;
    while (i < size) {
      if(eventMenuView.textGroupMoney == listNameGroupMoney[i]) {
        return i;
        break;
      }
      i++;
    }
  }

  final snackBar = SnackBar(
      content: Text('Sucessful'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {

        },
      ),
  );

  Widget SetMoney(BuildContext context, EventMenuView eventMenuView, FocusScopeNode currentFocus) {
    return GestureDetector(
      onTap: () {
        currentFocus.requestFocus();
      },
      child: Container(
        padding: EdgeInsets.only(top: 20, right: 10),
        child: TextField(
          controller: eventMenuView.moneyController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.numberWithOptions(
            decimal: true,
          ),
          decoration: new InputDecoration(
              icon: Icon(Icons.monetization_on, color: Colors.redAccent,),

              hintText: 'Input Money',
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

  Widget makeDropDownButton(BuildContext context, EventMenuView eventMenuView) {
    return
      Container(
        padding: EdgeInsets.only(top: 15),
        child: DropdownButton(
          value: listNameGroupMoney[_value],
          items: listNameGroupMoney.map((String value) {
            return new DropdownMenuItem<String>(
                value: value,
                child: Container(
                  child: Column(
                    children: [
                      new Divider(
                        height: 2.5,
                        color: Colors.black,
                      ),
                      Padding(
                          child: new Text(value, style: TextStyle(fontSize: 15),),
                          padding: EdgeInsets.only(top: 20)
                      ),
                    ],
                  ),
                )
            );
          }).toList(),
          onChanged: (String val) {
            int count = -1;
            for (int i = 0; i < listNameGroupMoney.length; i++) {
              if (listNameGroupMoney[i] == val) {
                count = i;
                break;
              }
            }
            _value = count;
            eventMenuView.textGroupMoney = listNameGroupMoney[_value];
            _awaitReturnValueFromSelectGroup(context, count, eventMenuView);
          },
          icon: Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.deepPurple, fontSize: 30),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
        ),
      );
  }

  //Set Group
  Widget SetGroupMoney(BuildContext context, EventMenuView eventMenuView) {
    return Container(
      padding: EdgeInsets.only(top: 10, right: 10),
      child: Row(
        children: [
          Icon(Icons.group_add_outlined),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 15),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.lightGreen[600],
                ),
                child: ListTile(
                    title: Text(eventMenuView.textName),
                    onTap: () {
                      int size = listNameGroupMoney.length;
                      setState(() {
                        int index;
                        for (int i = 0; i < size; i++) {
                          if (eventMenuView.textGroupMoney == listNameGroupMoney[i]) {
                            index = i;
                            break;
                          }
                        }
                        _awaitReturnValueFromSelectGroup(context, index, eventMenuView);
                      });
                    }
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  //SetDate
  Widget SetDate(BuildContext context, EventMenuView eventMenuView) {
    return Container(
      padding: EdgeInsets.only(top: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          Icon(Icons.date_range, color: Colors.deepPurpleAccent,),
          Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.teal[600],
                  ),
                  child: ListTile( //Input Select Date
                    title: Text(eventMenuView.textDate, style: TextStyle(fontSize: 15),),
                    onTap: () {
                      _awaitReturnValueFromCalendar(context, eventMenuView);
                    },
                  ),
                ),
              )
          )
        ],
      ),
    );
  }

  //Add A Deal false
  void AddFalseDialog(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: (context),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: AlertDialog(
              title: Text('Can not Add A Deal'),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                )
              ],
            ),
          );
        }
    );
  }

  //Save Button and Save Deal in database
  Widget SaveButton(BuildContext context, EventMenuView eventMenuView, FocusScopeNode currentFocus) {
    return GestureDetector(
      child: FloatingActionButton.extended(
        onPressed: () async {
          if (checkCanSave(eventMenuView) == 1) {
            double money = double.parse(eventMenuView.moneyController.text);
            double sumCurrentMoney = await AccountBalance.accountBalance.getSumCurrentMoney();

            int ObjectGroupMoney = InsertADeal(eventMenuView);
            if (ObjectGroupMoney == 2 || ObjectGroupMoney == 3) {
              sumCurrentMoney = sumCurrentMoney + money;
            }
            else {
              sumCurrentMoney = sumCurrentMoney - money;
            }

            AccountBalance.accountBalance.updateSumCurrentMoney(EventLogin.id, sumCurrentMoney);
            eventMenuView.SaveDealInDatabase(eventMenuView, ObjectGroupMoney, money);

            currentFocus.unfocus();
            Scaffold.of(context).showSnackBar(snackBar);
            eventMenuView.moneyController.clear();
            setState(() {
              eventMenuView.textName = 'Name of Group Money';
              eventMenuView.textGroupMoney = 'Expenditure';
              eventMenuView.textDate = "Select Date";
              Deal.deal.nameDeal = "no name Deal";
              Deal.deal.groupNameDeal =  'no Group Name Deal';
              Deal.deal.moneyDeal = 0.0;
              Deal.deal.dateDeal = 0;
              _value = 0;
            });
          }
          else {
            AddFalseDialog(context);
          };
        },
        label: Text('SAVE'),
        icon: Icon(Icons.save),
      ),
    );
  }

  Widget backGround(BuildContext context) {
    return Container(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  //padding: EdgeInsets.only(top: 70, left: MediaQuery.of(context).size.width / 2.47),
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 2.58),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 4.8,
                    height: MediaQuery.of(context).size.height/13.67,
                    //height: MediaQuery.of(context).size.height/14,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                      color: Colors.greenAccent,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 2.47),
                  child: Container(
                    width: MediaQuery.of(context).size.width/4.8,
                    height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height/13.67 - AppBar().preferredSize.height - 87.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(27), topRight: Radius.circular(40)),
                        color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  //padding: EdgeInsets.only(top: 100),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.4,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(75)),
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/6 ),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.4,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(75)),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        )

    );
  }

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      //backgroundColor: Colors.blue,
      backgroundColor: Colors.white70,
      body: Stack(
        children: [
          //BackgroundMenuView(),
          Container(
            //padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/14),
            decoration: BoxDecoration(
              //color: Colors.brown[400],
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(130)
              )
            ),
            child: ChangeNotifierProvider(
              create: (context) {
                return EventMenuView();
              },
              child: Consumer<EventMenuView> (
                builder: (context, eventMenuView, child) {
                  return Column(
                    children: [
                      SetMoney(context, eventMenuView, currentFocus),
                      makeDropDownButton(context, eventMenuView),
                      SetGroupMoney(context, eventMenuView),
                      SetDate(context, eventMenuView),
                      SaveButton(context, eventMenuView, currentFocus),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}