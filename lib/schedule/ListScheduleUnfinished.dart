import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maganemoney/Model_ObjectMoney/ScheduleObject.dart';
import 'package:maganemoney/schedule/InformationASchedule.dart';
import 'package:maganemoney/Model_ObjectMoney/AccountBalance.dart';

class InformationScheduleUnfinished extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        leading: IconButton(
          icon: Icon(Icons.clear, color: Colors.blueGrey[900],),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Information Schedule', style: TextStyle(color: Colors.black87),),
      ),
      body: HomeInformatonSchedule(),
    );
  }
}

class HomeInformatonSchedule extends StatefulWidget {
  @override
  _HomeInformationSchedule createState() {
    return _HomeInformationSchedule();
  }
}

class _HomeInformationSchedule extends State<HomeInformatonSchedule> {

  Future<List<List>> listDataToShowSchedule() async {
    List<List> listDataUnfinished = await ScheduleObject.scheduleObject.listDataUnfinished();
    List<double> listPercent = new List();

    double sumCurrentMoney = await AccountBalance.accountBalance.getSumCurrentMoney();
    List<double> listMoney = await ScheduleObject.scheduleObject.listCurrentMoneyUnfinishedSchedule();

    int size = listMoney.length;

    for (int i = 0; i < size; i++) {
      double value = listMoney[i];
      double a = value/sumCurrentMoney;
      a = num.parse(a.toStringAsFixed(2));
      a = a*100;
      listPercent.add(a);
    }

    List<List> list = new List();
    list.add(listDataUnfinished);
    list.add(listPercent);

    return list;
  }

  Future<void> refreshListScheduleUnfinished() async {
    setState(() {
      listDataToShowSchedule();
    });
  }

  void deleteItem(BuildContext context, List<List> items, List<int> listPrimaryKey, int index) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Container(
          child: AlertDialog(
            title: Text("Do you want to cancel this schedule?"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      int id = listPrimaryKey[index];
                      listPrimaryKey.removeAt(index);
                      ScheduleObject.scheduleObject.deleteRow(id);
                      Navigator.pop(context);
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => InformationScheduleUnfinished()
                      ));
                    });
                  },
                  child: Text('YES', style: TextStyle(fontSize: 15),)
              )
            ],
          ),
        );
      }
    );
  }

  //Show a schedule
  Widget ShowScheduleItem(BuildContext context, double percent, List<List> items, List<int> listPrimaryKey, String nameSchedule,
      int interval, double moneyForSchedule, String dateStart, double moneyAMonth, double progress, double currentMoney,
      int stateSchedule, int dateUpdateSchedule, int index) {

    double curr_all = currentMoney/moneyForSchedule;
    Color colorFloatingActionButton = Colors.white;
    if (1 - curr_all < 0.05) {
      colorFloatingActionButton = Colors.red;
    }

    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
          color: Colors.greenAccent,
        ),
        child: Card(
            child: ListTile(
              leading: FloatingActionButton(
                heroTag: 'btn' + index.toString(),
                backgroundColor: colorFloatingActionButton,
                child: Expanded(
                  child: Text(percent.toString() + '%', style: TextStyle(
                    color: Colors.black
                  ),),
                ),
              ),
              title: Text(nameSchedule),
              subtitle: Text(moneyForSchedule.toString()),
              trailing: IconButton(
                icon: Icon(Icons.delete_forever, color: Colors.black45, size: 25,),
                onPressed: () {
                  deleteItem(context, items, listPrimaryKey, index);
                },
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => InformationASchedule(id: listPrimaryKey[index], nameSchedule: nameSchedule,
                      interval: interval, moneyForSchedule: moneyForSchedule, dateStart: dateStart,
                      moneyAMonth: moneyAMonth, currentMoney: currentMoney, stateSchedule: stateSchedule,
                      dateUpdateSchedule: dateUpdateSchedule, check: 0,)
                ));
              },
            )
        ),
      ),
    );
  }

  //Show List Schedule Uninished
  Widget ShowListScheduleUnfinished(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Expanded(
        child: Container(
          child: FutureBuilder(
            future: listDataToShowSchedule(),
            builder: (BuildContext context, AsyncSnapshot<List<List>> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text("Don't have finished schedule"));
              }
              else {
                final allItems = snapshot.data;
                final items = allItems[0];
                final itemPercent = allItems[1];

                List<int> listPrimaryKey = items[0];
                List<String> listName = items[2];
                List<int> listInterval = items[3];
                List<double> listMoney = items[4];
                List<String> listDateStart = items[5];
                List<double> listMoneyAMonth = items[6];
                List<double> listCurrentMoney = items[7];
                List<int> listStateSchedule = items[8];
                List<int> listDateUpDateSchedule = items[9];

                return RefreshIndicator(
                  onRefresh: refreshListScheduleUnfinished,
                  child: ListView.builder(
                      itemCount: listName.length,
                      itemBuilder: (context, index) {
                        String nameSchedule = listName[index];
                        int interval = listInterval[index];
                        double moneyForSchedule  = listMoney[index];
                        String dateStart = listDateStart[index];
                        double moneyAMonth = listMoneyAMonth[index];
                        double progress = listMoney[index];
                        double currentMoney = listCurrentMoney[index];
                        int stateSchedule = listStateSchedule[index];
                        int dateUpdateSchedule = listDateUpDateSchedule[index];
                        double percent = itemPercent[index];

                        return ShowScheduleItem(context, percent, items, listPrimaryKey, nameSchedule, interval, moneyForSchedule,
                            dateStart, moneyAMonth, progress, currentMoney, stateSchedule,
                            dateUpdateSchedule, index);
                      }
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShowListScheduleUnfinished(context);
  }
}