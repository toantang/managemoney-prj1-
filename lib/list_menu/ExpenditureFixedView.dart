import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maganemoney/list_menu/EventMenuView.dart';
import 'package:provider/provider.dart';

class ExpenditureFixedView extends StatefulWidget {
  @override
  _ExpenditureFixedView createState() {
    return _ExpenditureFixedView();
  }
}

class _ExpenditureFixedView extends State<ExpenditureFixedView> {
  List<String> listExpenditureFixed = ['Electrics', 'Water', 'Internet', 'Interest', ];

  Widget SetFrequency(BuildContext context, EventMenuView eventMenuView) {
    return Container(
      child: TextField(
        controller: eventMenuView.frequencyCotroller,
        keyboardType: TextInputType.number,
        decoration: new InputDecoration(
            icon: Icon(Icons.timeline, color: Colors.redAccent,),

            hintText: 'Frequency',
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
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text('EXPENDITURE FIXED'),
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            Map<String, String> data = {'groupName': 'Name of Group Money'};
            Navigator.pop(context, data);
          },
        ),
      ),
      body: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.center,
        children: <Widget> [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: ChangeNotifierProvider(
              create: (context) => EventMenuView(),
              child: Consumer<EventMenuView>(
                builder: (context, eventMenuView, child) {
                  return Column(
                      children: <Widget> [
                        SetFrequency(context, eventMenuView),
                        Expanded(
                          child: ListView.builder(
                              itemCount: listExpenditureFixed.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    title: Text(listExpenditureFixed[index]),
                                    onTap: () {
                                      String s = listExpenditureFixed[index];
                                      String frequency = eventMenuView.frequencyCotroller.text;
                                      if (eventMenuView.checkTextFieldNull(frequency) == true) {
                                        eventMenuView.AddNameFail(context);
                                      }
                                      else {
                                        Map<String, String> data = {'name': s, 'groupName' : s, 'frequency': frequency};
                                        Navigator.pop(context, data);
                                      }
                                    },
                                  ),
                                );
                              }
                          ),
                        ),
                      ],
                    );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}