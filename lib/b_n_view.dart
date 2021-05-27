import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:maganemoney/b_n_controller.dart';
import 'package:maganemoney/home_Page/Statistic.dart';
import 'package:maganemoney/chart_money/chart.dart';
import 'package:maganemoney/schedule/ScheduleView.dart';
import 'package:maganemoney/Model_ObjectMoney/AccountBalance.dart';
import 'package:maganemoney/Model_ObjectMoney/ScheduleObject.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'account_settingapp/nav-drawer.dart';
import 'package:flutter/material.dart';

import 'listObjectUseEveryClass.dart';
import 'list_menu/menu.dart';
import 'login/EventLogin.dart';

//void main() => runApp(MyApp1());

/*class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magane your Money',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}*/

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Widget> _children = [Statistic(), Chart(), Menu(), Schedule()];
  List<Color> listColorAppBar = [Colors.greenAccent, Colors.brown, Colors.greenAccent, Colors.pink[300]];

  @override
  void initState() {
    var androidInitilize = new AndroidInitializationSettings('app_notification_icon');
    var initializationSettings = new InitializationSettings(android: androidInitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initializationSettings,
        onSelectNotification: notificationSelected);

    super.initState();
  }

  FlutterLocalNotificationsPlugin fltrNotification;

  Future _showNotification(String noti, int id) async {
    var androidDetails = new AndroidNotificationDetails("Channel ID", "Desi Programer",
      "this is my chanel", importance: Importance.high, );
    var generalNotificationDetails = new NotificationDetails(android: androidDetails);

    await fltrNotification.show(id, "Task:", noti, generalNotificationDetails);
  }

  void updateSchedule(List<List> items) {
    print("da chay vao ham updateSchedule cua class SignInView");
    List<int> listPrimaryKey = items[0];
    List<String> listName = items[2];
    List<int> listInterval = items[3];
    List<double> listMoney = items[4];
    List<String> listDateStart = items[5];
    List<double> listMoneyAMonth = items[6];
    List<double> listCurrentMoney = items[7];
    List<int> listStateSchedule = items[8];
    List<int> listDateUpdate = items[9];

    int size = listName.length;
    print('size = $size');
    for (int i = 0; i < size; i++) {
      int idTable = listPrimaryKey[i];
      String nameSchedule = listName[i];
      int interval = listInterval[i];
      double moneyForSchedule = listMoney[i];
      String dateStart = listDateStart[i];
      double moneyAMonth = listMoneyAMonth[i];
      double currentMoney = listCurrentMoney[i];
      int stateSchedule = listStateSchedule[i];
      int dateUpdate = listDateUpdate[i];

      DateTime dateTime = DateTime.now();
      int dayNow = dateTime.day;
      int monthNow = dateTime.month;
      int yearNow = dateTime.year;
      int dateNow = yearNow * 10000 + monthNow * 100 + dayNow;
      String noti;

      int subDate = dateNow - dateUpdate;
      if (subDate == 100 || subDate == 8900) {
        currentMoney = currentMoney + moneyAMonth;
        if (currentMoney >= moneyForSchedule) {
          stateSchedule = 1;
          noti = 'Xin chuc mung. Ke hoach ' + nameSchedule + ' da hoan thanh vao ngay ' + dayNow.toString() + ' thang '
              + monthNow.toString() + ' nam ' + yearNow.toString();
          ScheduleObject.scheduleObject.update(idTable, EventLogin.id, nameSchedule, interval, moneyForSchedule, dateStart,
              moneyAMonth, currentMoney, stateSchedule, dateNow);
          _showNotification(noti, i);
        }
        else {
          ScheduleObject.scheduleObject.update(idTable, EventLogin.id, nameSchedule, interval, moneyForSchedule, dateStart,
              moneyAMonth, currentMoney, stateSchedule, dateNow);
        }
      }
    }
  }

  void updateExpenditureFixedLogin(List<List> items, bottomNavigationController) {
    List<int> listPrimaryKey = items[0];
    List<int> listId = items[1];
    List<String> listNameExpenditureFixed = items[2];
    List<String> listGroupNameExpenditureFixed = items[3];
    List<double> listMoneyExpenditureFixed = items[4];
    List<int> listDateDeal = items[5];
    List<double> listFrequency = items[6];
    List<int> listDateUpdate = items[7];
    List<double> listMoneyFrequency = items[8];

    int size = listPrimaryKey.length;
    DateTime dateTime = DateTime.now();
    int dayNow = dateTime.day;
    int monthNow = dateTime.month;
    int yearNow = dateTime.year;

    for (int i = 0; i < size; i++) {
      int id = listPrimaryKey[i];
      int idUser = listId[i];
      String nameExpenditureFixed = listNameExpenditureFixed[i];
      String groupNameExpenditureFixed = listGroupNameExpenditureFixed[i];
      double money = listMoneyExpenditureFixed[i];
      int dateDeal = listDateDeal[i];
      double frequency = listFrequency[i];
      int dateUpdate = listDateUpdate[i];
      double moneyFrequency = listMoneyFrequency[i];

      int dayUpdate = dateUpdate%100;
      int dateDealll = dateUpdate~/100;
      int monthUpdate = dateDealll%100;
      int yearUpdate = dateDealll~/100;

      double cntDays = 365*(yearNow - yearUpdate) + (monthNow - monthUpdate)*30 + (dayNow - dayUpdate) + 0.0;
      double countDays = 30 * frequency;
      print('cntDays = $cntDays, countDays = $countDays');
      if (countDays == cntDays) {
        money = money + moneyFrequency;

        bottomNavigationController.sumCurrentMoney = bottomNavigationController.sumCurrentMoney - moneyFrequency;
        AccountBalance.accountBalance.updateSumCurrentMoney(idUser, bottomNavigationController.sumCurrentMoney);
        int dateUpdateLast = yearNow * 10000 + monthNow * 100 + dayNow;
        print('money = $money');

        ((ListUseEveryClass.listObject)[1]).updateExpenditureFixed(id, idUser, nameExpenditureFixed, groupNameExpenditureFixed,
            money, dateDeal, frequency, dateUpdateLast, moneyFrequency);
      }
    }
  }

  void updateTurnoverFixedLogin(List<List> items, bottomNavigationController) {
    List<int> listPrimaryKey = items[0];
    List<int> listId = items[1];
    List<String> listNameTurnoverFixed = items[2];
    List<String> listGroupNameTurnoverFixed = items[3];
    List<double> listMoneyTurnoverFixed = items[4];
    List<int> listDateDeal = items[5];
    List<double> listFrequency = items[6];
    List<int> listDateUpdate = items[7];
    List<double> listMoneyFrequency = items[8];

    int size = listPrimaryKey.length;
    DateTime dateTime = DateTime.now();
    int dayNow = dateTime.day;
    int monthNow = dateTime.month;
    int yearNow = dateTime.year;

    print("dong 235 class Bottomnavigation, size = $size");

    for (int i = 0; i < size; i++) {
      int id = listPrimaryKey[i];
      int idUser = listId[i];
      String nameTurnoverFixed = listNameTurnoverFixed[i];
      String groupNameTurnoverFixed = listGroupNameTurnoverFixed[i];
      double money = listMoneyTurnoverFixed[i];
      int dateDeal = listDateDeal[i];
      double frequency = listFrequency[i];
      int dateUpdate = listDateUpdate[i];
      double moneyFrequency = listMoneyFrequency[i];

      int dayUpdate = dateUpdate%100;
      int dateDealll = dateUpdate~/100;
      int monthUpdate = dateDealll%100;
      int yearUpdate = dateDealll~/100;

      double cntDays = 360*(yearNow - yearUpdate) + (monthNow - monthUpdate) * 30 + (dayNow - dayUpdate) + 0.0;
      print("253, class bottomnavigation, cntDays = $cntDays");
      double countDays = 30 * frequency;
      print("253, class bottomnavigation, countDays = $countDays");
      if (countDays == cntDays) {
        money = money + moneyFrequency;

        bottomNavigationController.sumCurrentMoney = bottomNavigationController.sumCurrentMoney + moneyFrequency;
        AccountBalance.accountBalance.updateSumCurrentMoney(idUser, bottomNavigationController.sumCurrentMoney);
        int dateUpdateLast = yearNow * 10000 + monthNow * 100 + dayNow;
        ((ListUseEveryClass.listObject)[3]).updateTurnoverFixed(id, idUser, nameTurnoverFixed, groupNameTurnoverFixed,
            money, dateDeal, frequency, dateUpdateLast, moneyFrequency);
      }
    }
  }

  void updateAccountBalance(List<List> items) {
    int check;

    List<int> listPrimaryKey = items[0];
    List<int> listIdUser = items[1];
    List<double> listSumMoneyCurrent = items[2];

    int size = listIdUser.length;

    for (int i = 0; i < size; i++) {
      if (listIdUser[i] == EventLogin.id) {
        break;
      }
      check++;
    }

    if (check == size) {
      AccountBalance.accountBalance.insertAccountBalance(AccountBalance.accountBalance);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BottomNavigationController(),
      child: Consumer<BottomNavigationController> (
        builder: (context, bottomNavigationController, child) {
          return FutureBuilder(
              future: bottomNavigationController.getDataList(),
              builder: (BuildContext context, AsyncSnapshot<List<List>> snapshot) {
                if (!snapshot.hasData) {
                  print('nononono');
                }
                else {
                  final lists = snapshot.data;
                  print('dong 387 class SignInView, lists = $lists');

                  final items = lists[0];
                  final itemsExpenditureFixed = lists[1];
                  final itemsTurnoverFixed = lists[2];
                  final itemsAccountBalance = lists[3];

                  updateSchedule(items);
                  updateExpenditureFixedLogin(itemsExpenditureFixed, bottomNavigationController);
                  updateTurnoverFixedLogin(itemsTurnoverFixed, bottomNavigationController);
                  updateAccountBalance(itemsAccountBalance);
                }

                return SafeArea(
                  child: ChangeNotifierProvider(
                      create: (context) => BottomNavigationController(),
                      child: Consumer<BottomNavigationController> (
                          builder: (context, bottomNavigationController, child) {
                            return Scaffold(
                              resizeToAvoidBottomInset: false,
                              appBar: AppBar(
                                centerTitle: true,
                                backgroundColor: Colors.white,
                                iconTheme: IconThemeData(
                                    color: Colors.black
                                ),
                              ),
                              body: SafeArea(
                                top: false,
                                child: PageView(
                                  controller: bottomNavigationController.pageController,
                                  onPageChanged: (i) {
                                    bottomNavigationController.changePageView(i);
                                  },
                                  children: _children,
                                ),
                              ),
                              drawer: NavDrawer(),
                              bottomNavigationBar: BottomNavigationBar(
                                currentIndex: bottomNavigationController.currentIndex,
                                onTap: (int index) {
                                  bottomNavigationController.changeBottomView(index);
                                },
                                showSelectedLabels: true,
                                selectedIconTheme: IconThemeData(
                                  color: Colors.blueAccent,
                                ),
                                unselectedIconTheme: IconThemeData(
                                  color: Colors.limeAccent[400],
                                ),
                                type: BottomNavigationBarType.fixed,
                                backgroundColor: Colors.blueGrey[200],
                                selectedItemColor: Colors.deepPurple,
                                items: [
                                  BottomNavigationBarItem(
                                    icon: Icon(Icons.home,),
                                    title: Text('Home', style: TextStyle(color: Colors.black, fontSize: 15), ),),
                                  BottomNavigationBarItem(
                                    icon: Icon(Icons.attach_money,),
                                    title: Text('Chart', style: TextStyle(color: Colors.black, fontSize: 15)),
                                  ),
                                  BottomNavigationBarItem(
                                    icon: Icon(Icons.add,),
                                    title: Text('ADD', style: TextStyle(color: Colors.black, fontSize: 15)),
                                  ),
                                  BottomNavigationBarItem(
                                    icon: Icon(Icons.schedule,),
                                    title: Text('Schedule', style: TextStyle(color: Colors.black, fontSize: 15),),
                                  ),
                                ],
                              ),
                            );
                          }
                      )
                  ),
                );
              }
          );
        },
      ),
    );

  }

  Future notificationSelected(String payload) async {

  }
}