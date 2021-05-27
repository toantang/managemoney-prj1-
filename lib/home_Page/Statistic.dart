import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maganemoney/Model_ObjectMoney/AccountBalance.dart';
import 'package:maganemoney/home_Page/statistic_controller.dart';
import 'package:maganemoney/home_Page/EventInformationAdeal.dart';
import 'package:maganemoney/home_Page/InformationADeal.dart';
import 'package:maganemoney/list_menu/Table_Calendar.dart';
import 'package:maganemoney/login/EventLogin.dart';
import 'package:provider/provider.dart';

import 'AccountBalanceView.dart';

class Statistic extends StatefulWidget {
  //static int value = 0;
  @override
  State createState() => new ListDisplay();
}

class ListDisplay extends State<Statistic> {

  //Retrieve textDayStart from Calendar
  Future<void> _awaitReturnValueFromCalendarStart(BuildContext context, StatisticController statisticController) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Calendar(),
        ));
    statisticController.dateStart = result['dateDeal'];

    setState(() {
      statisticController.selectDropdown = 0;

      if (statisticController.dateStart == null) {
        statisticController.textDateStart = 'Date Start';
      }
      else {
        if (statisticController.dateStart < statisticController.dateEnd || statisticController.dateEnd == 0) {
          statisticController.textDateStart = result['date'];
        }
        else {
          statisticController.textDateStart = 'Date Start';
          statisticController.dateStart = 0;
        }
      }
    });
    print(statisticController.textDateStart);

  }

  //Retrieve textDayEnd from Calendar
  Future<void> _awaitReturnValueFromCalendarEnd(BuildContext context, StatisticController statisticController) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Calendar(),
        ));
    statisticController.dateEnd = result['dateDeal'];
    setState(() {
      statisticController.selectDropdown = 0;

      if (statisticController.dateEnd == null) {
        statisticController.textDateEnd = 'Date End';
        statisticController.dateEnd = 0;
      }
      else {
        if (statisticController.dateEnd > statisticController.dateStart || statisticController.dateStart == 0) {
          statisticController.textDateEnd = result['date'];
        }
        else {
          statisticController.dateEnd = 0;
          statisticController.textDateEnd = 'Date End';
        }
      }
    });

    print(statisticController.textDateEnd);
  }

  //select Group Money(Expenditure, ExpenditureFixed, Turnover, TurnoverFixed)
  List<String> listNameGroupMoney = ['Expenditure', 'Expenditure Fixed', 'Turnover', 'Turnover Fixed'];

  Widget moneyGroup(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      //height: 50,
      height: 70,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: listNameGroupMoney.length,
          itemBuilder: (context, index) {
            return Container(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.read<StatisticController>().changeIndexIsTrue(index);
                        context.read<StatisticController>().defaultObject(index);
                        context.read<StatisticController>().changeCurrentIndexButton(index);
                        print(Provider.of<StatisticController>(context, listen: false).listCheck[index]);
                        print("currentIndexButton = ${Provider.of<StatisticController>(context, listen: false).currentIndexButton}");
                      },
                      child: Text(listNameGroupMoney[index]),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.black45;
                                }
                                else {
                                  //return Colors.lightBlueAccent;
                                  return listColorElevatedButton[index];
                                }
                              }
                          )
                      ),
                    ),
                    Container(
                      height: 4.5,
                      width: 50,
                      child: Consumer<StatisticController>(
                        builder: (_, statisticController, child) {
                          return Container(
                            color: ((statisticController.listCheck[index] == true) ? statisticController.changeColorIndex(index) : Colors.white),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                padding: EdgeInsets.only(left: 10),
              );
          }
      ),
    );
  }

  Widget setDateStatistic(BuildContext context, StatisticController statisticController) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 5, right: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 5),
            width: MediaQuery.of(context).size.width/2.1,
            decoration: BoxDecoration(
                color: Colors.blueGrey[50],
                border: Border(
                    bottom: BorderSide(width: 2, color: Colors.deepPurpleAccent[700])
                )
            ),
            child: ListTile(
              leading: Icon(Icons.date_range, color: Colors.deepPurpleAccent,),
              title: Consumer<StatisticController> (
                builder: (_, statisticController, child) {
                  return Text(statisticController.textDateStart);
                },
              ),
              onTap: () {
                _awaitReturnValueFromCalendarStart(context, statisticController);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 5),
            child: Container(
              width: MediaQuery.of(context).size.width/2.1, //2.3
              decoration: BoxDecoration(
                //color: Colors.blueGrey[50],
                  color: Colors.blue,
                  border: Border(
                      bottom: BorderSide(width: 2, color: Colors.deepPurpleAccent[700])
                  )
              ),
              child: ListTile(
                leading: Icon(Icons.date_range, color: Colors.deepPurpleAccent,),
                title: Consumer<StatisticController> (
                  builder: (_, statisticController, child) {
                    return Text(statisticController.textDateEnd);
                  },
                ),
                onTap: () {
                  _awaitReturnValueFromCalendarEnd(context, statisticController);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Make dropdown Button select Month
  Widget makeDropDownButtonSelectDate(BuildContext context, StatisticController statisticController) {
    List<String> dateSelect = statisticController.listSelectDate();
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: DropdownButton(
        value: dateSelect[statisticController.selectDropdown],
        items: dateSelect.map((String value) {
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
                        child: new Text(value, style: TextStyle(color: Colors.black, fontSize: 17),),
                        padding: EdgeInsets.only(top: 10)
                    ),
                  ],
                ),
              )
          );
        }).toList(),
        onChanged: (String val) {
          List<String> listUserSelect = val.split('/');
          statisticController.changeDateSelectDropdownButton(listUserSelect, val);
        },
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.white70, fontSize: 30),
        underline: Container(
          height: 2,
          color: Colors.yellow[100],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget threeButtonDate(BuildContext context, StatisticController statisticController) {
    return Column(
      children: [
        makeDropDownButtonSelectDate(context, statisticController),
        setDateStatistic(context, statisticController),
      ],
    );
  }

  List<Color> listColorElevatedButton = [Colors.deepPurple[100], Color(0xff13d38e), Colors.indigo[400], Colors.blueGrey[600]];

  //show Item from database
  Widget showItem(BuildContext context, List<List> items, List<String> listName, List<double> listMoney, int index,
      String nameDeal, String groupName, String money, String printDateDeal, int id, int currentIndexButton) {
    return Card(
      child: ListTile(
        leading: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(nameDeal, style: TextStyle(color: Colors.black87, fontSize: 16, ), ),
        ),
        title: ChangeNotifierProvider(
          create: (context) => EventInformationDeal(),
          child: Consumer<EventInformationDeal> (
            builder: (context, eventInformationDeal, child) {
              String money1 = money;
              double moneyDeal = double.parse(money1);
              String convertMoney = eventInformationDeal.convertLargeNumber(moneyDeal);

              return Padding(
                padding: EdgeInsets.only(left: 60),
                child: Text('$convertMoney \$', style: TextStyle(color: Colors.red),),
              );
            },
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_forever, color: Colors.black45, size: 25,),
          onPressed: () async {
            double sumCurrentMoney = await AccountBalance.accountBalance.getSumCurrentMoney();
            if (currentIndexButton == 0 || currentIndexButton == 1) {
              sumCurrentMoney = sumCurrentMoney + double.parse(money);
            }
            else {
              sumCurrentMoney = sumCurrentMoney - double.parse(money);
            }
            AccountBalance.accountBalance.updateSumCurrentMoney(EventLogin.id, sumCurrentMoney);
            context.read<StatisticController>().deleteItem(listName, index, id);
          },
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return InformationADeal(groupMoney: listNameGroupMoney[currentIndexButton], nameDeal: nameDeal,
                  groupName: groupName, money: money, dateDealString: printDateDeal, id: id, frequency: null,);
              }
          ));
        },
      ),
    );
  }

  //Show ListItem from database
  Widget showListItem(BuildContext context, StatisticController statisticController) {

    return FutureBuilder(
      future: statisticController.getData(),
      builder: (_, AsyncSnapshot<List<List>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        else {
          final items = snapshot.data; //Một List là items chứa các List (listName, listMoney, listDay, etc)
          print('dong 338 class Statistic: $items');
          int indexGroupMoney = statisticController.currentIndexButton;
          print('indexGroupMoney = $indexGroupMoney');

          List<int> listPrimaryKey = items[indexGroupMoney][0];
          List<String> listName = items[indexGroupMoney][2];
          List<String> listGroupName = items[indexGroupMoney][3];
          List<double> listMoney = items[indexGroupMoney][4];
          List<int> listDateDeal = items[indexGroupMoney][5];

          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: listName.length,
            itemBuilder: (_, index) {
              int id = listPrimaryKey[index];
              String nameDeal = listName[index];
              String groupName = listGroupName[index];
              String money = listMoney[index].toString();
              int dateDeal = listDateDeal[index];
              String dateDealString = dateDeal.toString();
              String printDateDeal = dateDealString.substring(6, 8) + '/' + dateDealString.substring(4, 6) + '/' +
                  dateDealString.substring(0, 4);

              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                child: showItem(context, items, listName, listMoney, index, nameDeal, groupName, money,
                    printDateDeal, id, indexGroupMoney),

                onDismissed: (direction) async {
                  double sumCurrentMoney = await AccountBalance.accountBalance.getSumCurrentMoney();
                  if (indexGroupMoney == 0 || indexGroupMoney == 1) {
                    sumCurrentMoney = sumCurrentMoney + double.parse(money);
                  }
                  else {
                    sumCurrentMoney = sumCurrentMoney - double.parse(money);
                  }
                  AccountBalance.accountBalance.updateSumCurrentMoney(EventLogin.id, sumCurrentMoney);

                  statisticController.deleteItem(listName, index, id);
                },
              );
            },
          );
        }
      },
    );
  }

  Widget showGroupAndItem(BuildContext context, StatisticController statisticController) {
    return Column(
      children: [
        threeButtonDate(context, statisticController),
        //setDateStatistic(context, statisticController),
        //makeDropDownButtonSelectDate(context, statisticController),
        showListItem(context, statisticController),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    AccountBalanceView.accountBalanceView = new AccountBalanceView();

    //
    return Scaffold(
      backgroundColor: Colors.white70,
      body:ChangeNotifierProvider(
        create: (context) => StatisticController(),
        child: Column(
          children: [
            AccountBalanceView.accountBalanceView,
            moneyGroup(context),
            Consumer<StatisticController> (
              builder: (_, statisticController, child) {
                return showGroupAndItem(context, statisticController);
              },
            )
          ],
        ),
      ),
    );
  }
}

/*class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Statistic(),
    );
  }
}

void main() {
  runApp(MyApp());
}*/
