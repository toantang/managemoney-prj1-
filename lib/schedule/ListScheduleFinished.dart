import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maganemoney/Model_ObjectMoney/ScheduleObject.dart';

import 'InformationASchedule.dart';

class HomeInformationFinished extends StatelessWidget {
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
      body: HomeInformatonFinishedSchedule(),
    );
  }
}

class HomeInformatonFinishedSchedule extends StatefulWidget {
  @override
  _HomeInformatonFinishedSchedule createState() {
    return _HomeInformatonFinishedSchedule();
  }
}

class _HomeInformatonFinishedSchedule extends State<HomeInformatonFinishedSchedule> {
  Future<List<List>> getDataFinished() async {
    List<List> listDataSchedule = new List();
    listDataSchedule = await ScheduleObject.scheduleObject.listDataFinished();

    return listDataSchedule;
  }

  Future<void> refreshListScheduleFinished() async {
    setState(() {
      getDataFinished();
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
  Widget ShowScheduleItem(BuildContext context, List<List> items, List<int> listPrimaryKey, String nameSchedule, int interval,
      double moneyForSchedule, String dateStart, double moneyAMonth, double progress, double currentMoney, int stateSchedule,
      int dateUpdateSchedule, int index) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
          color: Colors.greenAccent,
        ),
        child: Card(
            child: ListTile(
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
                      dateUpdateSchedule: dateUpdateSchedule, check: 1,)
                ));
              },
            )
        ),
      ),
    );
  }

  //Show List Schedule Finished
  Widget ShowListScheduleFinished(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Expanded(
        child: Container(
          child: FutureBuilder(
            future: getDataFinished(),
            builder: (BuildContext context, AsyncSnapshot<List<List>> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text("Don't have finished schedule"));
              }
              else {
                final items = snapshot.data;
                List<int> listPrimaryKey = items[0];
                List<String> listName = items[1];
                List<int> listInterval = items[2];
                List<double> listMoney = items[3];
                List<String> listDateStart = items[4];
                List<double> listMoneyAMonth = items[5];
                List<double> listCurrentMoney = items[6];
                List<int> listStateSchedule = items[7];
                List<int> listDateUpdateSchedule = items[8];

                return RefreshIndicator(
                  onRefresh: refreshListScheduleFinished,
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
                        int dateUpdateSchedule = listDateUpdateSchedule[index];

                        return ShowScheduleItem(context, items, listPrimaryKey, nameSchedule, interval, moneyForSchedule,
                            dateStart, moneyAMonth, progress, currentMoney, stateSchedule,
                            dateUpdateSchedule, index);
                      }
                  ),
                );
              };
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShowListScheduleFinished(context);
  }
}