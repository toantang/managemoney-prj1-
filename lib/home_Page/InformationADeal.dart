import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'EventInformationAdeal.dart';

class InformationADeal extends StatelessWidget {
  String groupMoney;
  String nameDeal;
  String groupName;
  String money;
  String dateDealString;
  int id;
  double frequency;

  InformationADeal({Key key, @required this.groupMoney, @required this.nameDeal, @required this.groupName, @required this.money,
    @required this.dateDealString, @required this.id, @required this.frequency}) : super(key: key);

  void updateMoney(BuildContext context, EventInformationDeal eventInformationDeal) {
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
                        controller: eventInformationDeal.formFieldController,
                        keyboardType: TextInputType.number,
                      )
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      String money = eventInformationDeal.formFieldController.text;
                      Navigator.pop(context);
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => InformationADeal(groupName: this.groupName, nameDeal: this.nameDeal, money: money,
                              dateDealString: this.dateDealString, id: this.id)
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

  //Information when tap on a ListTile
  Widget InforGroupMoney(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventInformationDeal(),
      child: Consumer<EventInformationDeal> (
        builder: (context, eventInformationDeal, child) {
          return Container(
            padding: EdgeInsets.only(top: 10),
            child: ListTile(
              onTap: () {
              },
              leading: Icon(Icons.drive_file_rename_outline, color: Colors.pink[300]),
              title: Text("Group Money: " + this.groupMoney,
                style: TextStyle(fontSize: 20),),
            ),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 1.5, color: Colors.lightGreen[300]),
                    bottom: BorderSide(width: 1.5, color: Colors.lightGreen[300])
                )
            ),
          );
        },
      )
    );
  }

  //Name of Deal
  Widget InforNameDeal(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => EventInformationDeal(),
        child: Consumer<EventInformationDeal>(
          builder: (context, eventInformationDeal, child) {
            return Container(
              padding: EdgeInsets.only(top: 10),
              child: ListTile(
                onTap: () {
                },
                leading: Icon(Icons.shopping_cart, color: Colors.indigo[300]),
                title: Text("Name: " + this.nameDeal,
                  style: TextStyle(fontSize: 20),),
              ),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 1.5, color: Colors.lightGreen[300]),
                      bottom: BorderSide(width: 1.5, color: Colors.lightGreen[300])
                  )
              ),
            );
          },
        ),
    );
  }

  //Information group Name parent of deal
  Widget InforGroupName(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => EventInformationDeal(),
        child: Consumer<EventInformationDeal> (
          builder: (context, eventInformationDeal, child) {
            return Container(
              padding: EdgeInsets.only(top: 10),
              child: ListTile(
                onTap: () {
                },
                leading: Icon(Icons.drive_file_rename_outline, color: Colors.pink[300]),
                title: Text("Group Name: " + this.groupName,
                  style: TextStyle(fontSize: 20),),
              ),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 1.5, color: Colors.lightGreen[300]),
                      bottom: BorderSide(width: 1.5, color: Colors.lightGreen[300])
                  )
              ),
            );
          },
        )
    );
  }

  //Money of Deal
  Widget InforMoney(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => EventInformationDeal(),
        child: Consumer<EventInformationDeal>(
          builder: (context, eventInfomationDeal, child) {

            List<String> listStringMoney = this.money.split('.');
            String phanNguyen = eventInfomationDeal.PhanNguyen(listStringMoney[0]);
            String tachThapPhan = listStringMoney[1];
            String phanThapPhan = '0';
            if (tachThapPhan == '0') {

            }
            else {
              phanThapPhan = eventInfomationDeal.PhanThapPhan(tachThapPhan);
            }

            return Container(
              padding: EdgeInsets.only(top: 10),
              child: ListTile(
                onTap: () {
                  updateMoney(context, eventInfomationDeal);
                },
                leading: Icon(Icons.monetization_on, color: Colors.deepOrange,),
                title: Text(phanNguyen + phanThapPhan + '\$',
                  style: TextStyle(fontSize: 20),),
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1.5, color: Colors.lightGreen[300])
                  )
              ),
            );
          },
        )
    );
  }

  //Information frequency
  Widget InforFrequency(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => EventInformationDeal(),
        child: Consumer<EventInformationDeal>(
          builder: (context, eventInfomationDeal, child) {
            return Container(
              padding: EdgeInsets.only(top: 10),
              child: ListTile(
                onTap: () {
                  updateMoney(context, eventInfomationDeal);
                },
                leading: Icon(Icons.timeline, color: Colors.deepOrange,),
                title: Text(this.frequency.toString() + ' ' + (frequency > 1.0 ? 'months': 'month'),
                  style: TextStyle(fontSize: 20),),
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1.5, color: Colors.lightGreen[300])
                  )
              ),
            );
          },
        )
    );
  }

  //Information Date
  Widget InforDate(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: ListTile(
        leading: Icon(Icons.date_range, color: Colors.brown,),
        title: Text(
          this.dateDealString,
          style: TextStyle(fontSize: 20),
        ),
      ),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1.5, color: Colors.lightGreen[300])
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            //backgroundColor: listColorElevatedButton[Statistic.value],
            leading: IconButton(
              icon: Icon(Icons.clear, color: Colors.blueGrey[900],),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            /*actions: [
              IconButton(
                  icon: Icon(Icons.delete, color: Colors.blueGrey[900]),
                  onPressed: () {
                    (ListUseEveryClass.listObject[Statistic.value]).deleteRow(id);
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => MyHomePage()
                    ));
                    //Navigator.pop(context, true);
                  }
              )
            ],*/
          ),
          body: Column(
            children: [
              InforGroupMoney(context),
              InforNameDeal(context),
              InforGroupName(context),
              InforMoney(context),
              //(this.frequency > 0 ? InforDate(context) : null),
              InforDate(context),
            ],
          ),
        )
    );
  }
}