import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maganemoney/list_menu/EventMenuView.dart';
import 'package:provider/provider.dart';


class TurnoverFixedView extends StatefulWidget {
  @override
  _TurnoverFixedView createState() {
    return _TurnoverFixedView();
  }
}

class _TurnoverFixedView extends State<TurnoverFixedView> {
  List<String> listTurnoverFixedView = ['Earnings', 'Business', 'Invest', ];

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
        title: Text('TURNOVER FIXED'),
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            Navigator.pop(context, 'Name of Group Money');
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
              //color: Colors.lightBlue
            ),
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            //padding: EdgeInsets.fromLTRB(50, top, right, bottom),
            child: ChangeNotifierProvider(
              create: (context) => EventMenuView(),
              child: Consumer<EventMenuView>(
                builder: (context, eventMenuView, child) {
                  return Column(
                    children: <Widget> [
                      SetFrequency(context, eventMenuView),
                      Expanded(
                        child: ListView.builder(
                            itemCount: listTurnoverFixedView.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  title: Text(listTurnoverFixedView[index]),
                                  onTap: () {
                                    String s = listTurnoverFixedView[index];
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