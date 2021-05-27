import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '1.event.dart';

class AddAnItem extends StatelessWidget {

  List<String> listNameGroupMoney = ['Expenditure', 'Expenditure Fixed', 'Turnover', 'Turnover Fixed'];
  int value = 0;
  Widget makeDropDownButton(BuildContext context, EventAddItem eventAddItem) {
    return
      Container(
        padding: EdgeInsets.only(top: 10, left: 40, right: 40),
        child: DropdownButton(
          value: listNameGroupMoney[value],
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
            value = count;
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

  Widget SetNewItem(BuildContext context, EventAddItem eventAddItem) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: new InputDecoration(
            icon: Icon(Icons.group_add_outlined, color: Colors.redAccent,),
            labelText: "Add new item here",
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(17.0)),
                borderSide: const BorderSide(
                  color: Colors.blueGrey,
                  width: 36.0,
                )
            )
        ),
      ),
    );
  }

  Widget Buttons(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 90),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Back', style: TextStyle(color: Colors.lightGreen),),
              ),
            ),
            Container(
            padding: EdgeInsets.only(left: 20),
            child: ElevatedButton(
                onPressed: null,
                child: Text('SAVE', style: TextStyle(color: Colors.lightGreen),),
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
                )
            ),
          )
          ],
        ),
      ),
    );
  }

  Widget AddItem(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => EventAddItem(),
        child: Consumer<EventAddItem>(
          builder: (context, eventAddItem, child) {
            return Container(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: Flushbar(
                  flushbarPosition: FlushbarPosition.TOP,
                  messageText: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SetNewItem(context, eventAddItem),
                      makeDropDownButton(context, eventAddItem),
                      Buttons(context),
                    ],
                  )
              ),
            );
          },
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return AddItem(context);
  }
}