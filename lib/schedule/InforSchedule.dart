import 'package:dynamic_treeview/dynamic_treeview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maganemoney/list_catalog_expenditure/DataModel.dart';
import 'package:maganemoney/Model_ObjectMoney/ScheduleObject.dart';

class InforSchedule extends StatelessWidget {
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
      body: HomeInforSchedule(),
    );
  }
}

class HomeInforSchedule extends StatefulWidget {
  @override
  _HomeInforSchedule createState() {
    return _HomeInforSchedule();
  }
}
class _HomeInforSchedule extends State<HomeInforSchedule> {

  @override
  Widget build(BuildContext context) {
    return ShowListSchedule(context);
  }

  Future<List<List>> getData() async {
    List<List> listDataSchedule = new List();
    listDataSchedule = await ScheduleObject.scheduleObject.listDataUnfinished();
    return listDataSchedule;
  }

  Future<void> refreshList(List<String> listName, List<int> listInterval, List<double> listMoney, List<String> listDateStart) async {
    setState(() {
      getData();
      listSchedule(listName, listInterval, listMoney, listDateStart);
    });
  }

  List<BaseData> listSchedule(List<String> listName, List<int> listInterval, List<double> listMoney, List<String> listDateStart) {
    List<BaseData> listSchedule = new List();
    int size = listName.length;

    var s = DataModel(
      id: 1,
      name: 'Root',
      parentId: -1,
      extras: {'key': 'extradata1'},
    );
    listSchedule.add(s);
    for (int i = 0; i < size; i++) {
      DataModel name = new DataModel(
        id: i + 2,
        name: listName[i],
        parentId: 1,
      );
      DataModel money = new DataModel(
        id: i + size + 2,
        name: 'Sum Money:      ' + listMoney[i].toString() + ' \$',
        parentId: i + 2,
      );
      DataModel interval = new DataModel(
        id: i + 2*size + 2,
        name: 'Interval:             ' + listInterval[i].toString() + ' months',
        parentId: i+2,
      );
      DataModel dateStart = new DataModel(
        id: i + 3*size + 2,
        name: "Date Start:        " + listDateStart[i],
        parentId: i + 2,
      );

      listSchedule.add(name);
      listSchedule.add(money);
      listSchedule.add(interval);
      listSchedule.add(dateStart);
    }

    return listSchedule;
  }

  InforSchedule inforSchedule = new InforSchedule();

  void deleteScheduleView(BuildContext context, List<BaseData> list, int index, List<int> listPrimaryKey) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Container(
            child: AlertDialog(
              title: Text("Do you want to cancel this schedule?"),
              actions: [
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      int size = listPrimaryKey.length;
                      int i = index - 1;

                      list.removeAt(i);
                      list.removeAt(i + size - 1);
                      list.removeAt(i + 2*size - 2);
                      list.removeAt(i + 3*size - 3);

                      int id = listPrimaryKey[index-2]; //id_table ứng với vị trí index
                      ScheduleObject.scheduleObject.deleteRow(id);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                ),
              ],
            ),
          );
        }
    );
  }

  Widget ShowListSchedule(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Expanded(
        child: Container(
          child: FutureBuilder(
            future: getData(),
            // ignore: missing_return
            builder: (BuildContext context, AsyncSnapshot<List<List>> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              else {
                final items = snapshot.data;
                List<int> listPrimaryKey = items[0];
                List<String> listName = items[1];
                List<int> listInterval = items[2];
                List<double> listMoney = items[3];
                List<String> listDateStart = items[4];

                List<BaseData> listScheduleBaseData = listSchedule(listName, listInterval, listMoney, listDateStart);
                return RefreshIndicator(
                  onRefresh: () async {
                    return refreshList(listName, listInterval, listMoney, listDateStart);
                  },
                  child: Card(
                    child: DynamicTreeView(
                      data: listScheduleBaseData,
                      config: Config(
                          parentTextStyle: TextStyle(fontWeight: FontWeight.w600, color: Colors.teal[700], decoration: TextDecoration.underline, ),
                          childrenTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                          arrowIcon: Icon(Icons.keyboard_arrow_up, color: Colors.deepOrange, size: 35,),
                          rootId: "1",
                          parentPaddingEdgeInsets: EdgeInsets.only(left: 16, top: 0, bottom: 10)),
                      onTap: (m) {
                        String parent_id = m['parent_id'];
                        int index = int.parse(m['id']);
                        if (parent_id == '1') {
                          deleteScheduleView(context, listScheduleBaseData, index, listPrimaryKey);
                        }
                      },
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}