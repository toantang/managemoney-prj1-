import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maganemoney/schedule/MakeAScheduleTextField.dart';
import 'package:maganemoney/schedule/makeAschedule.dart';
import 'package:maganemoney/schedule/ListScheduleUnfinished.dart';

import 'ListScheduleFinished.dart';

class Schedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyHomePage(),
      floatingActionButton: FloatingActionButton(
        heroTag: 'btn1',
        child: Icon(Icons.add, size: 35,),
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return MakeAScheduleTextField();
              }
          ));
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  List<String> listImage = ['assets/images/house.jpg', 'assets/images/car.jpg', 'assets/images/tech-product.jpg',
  'assets/images/travel.jpg', 'assets/images/money.jpg'];
  List<String> listName = ['Buy a house', 'Buy a car?', 'Buy an tech-product', 'To Travel', 'Save up'];
  List<String> listSub = [
      "House is a place, where you'll have moments of relaxation.",
      "Car - It's very great when the weather is rain",
      "Iphone, Laptop, etc. They are very very important and perfect",
      "Travel - If you like traveling, Saving up now",
      "Money - Savaing up to prepare for you future"
  ];

  void PushToMakeScheduleView(BuildContext context, int index) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return MakeASchedule(nameSchedule: listName[index],);
        }
    ));
  }

  //Information Unfinished Schedule Button
  Widget InformationUnfinishedScheduleButton(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => InformationScheduleUnfinished(),
          ));
        },
        child: Row(
          children: [
            Text('Planing doing', style: TextStyle(fontSize: 18),),
            Container(
              padding: EdgeInsets.only(left: 27.3),
              child: Icon(Icons.arrow_forward),
            )
          ],
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.black45;
                  }
                  else {
                    return Colors.lightBlueAccent;
                  }
                }
            )
        ),
      ),
    );
  }

  //Schedule Finished Button
  Widget FinishedScheduleButton(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => HomeInformationFinished(),
          ));
        },
        child: Row(
          children: [
            Text('Planing finished', style: TextStyle(fontSize: 18),),
            Container(
              padding: EdgeInsets.only(left: 7),
              child: Icon(Icons.arrow_forward),
            )
          ],
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.black45;
                  }
                  else {
                    return Colors.lightBlueAccent;
                  }
                }
            )
        ),
      ),
    );
  }

  Widget TwoButton(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10, left: MediaQuery.of(context).size.width/2.4, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              //padding: EdgeInsets.only(left: 5),
              child: InformationUnfinishedScheduleButton(context),
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: FinishedScheduleButton(context),
            )
          ],
        ),
    );
  }

  //Show List Schedule suggest
  Widget ShowListSchedule(BuildContext context) {
    return  Expanded(
      child: ListView.builder(
        itemCount: listImage.length,
        itemBuilder: (context, index) {
          return Container(
            height: 80,
            padding: EdgeInsets.only(top: 5, left: 5, right: 15),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight:Radius.circular(15)),
                color: Colors.cyan[400],
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      PushToMakeScheduleView(context, index);
                    },
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.asset(listImage[index], fit: BoxFit.fill, ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      subtitle: Text(listSub[index]),
                      title: Text(listName[index]),
                      trailing: Container(
                        padding: EdgeInsets.only(bottom: 10),
                        height: 50,
                        width: 7,
                        color: Colors.lime[300],
                      ),
                      onTap: () {
                        if (listName[index] == null) {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('listName[$index] is null'),
                                  actions: [
                                    FloatingActionButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }
                                    ),
                                  ],
                                );
                              }
                          ));
                        }
                        else {
                          PushToMakeScheduleView(context, index);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          color: Colors.white70,
          //color: Colors.brown[400],
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              //color: Colors.pink[300],
            ),
            child: Stack(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    TwoButton(context),
                  ],
                ),
                Container(
                  //padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/4.4),
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/4.6),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/10,
                      child: TextButton(
                        child: Text("Let's make a plan now", style: TextStyle(
                            fontSize: 23,
                            color: Colors.black
                        ),),
                      ),
                    ),
                ),
                Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/3.5),
                  child: Container(
                    height: MediaQuery.of(context).size.height/1.78,
                    child: Column(
                      children: [
                        Expanded(
                          child: ShowListSchedule(context),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
