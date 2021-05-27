import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TurnoverView extends StatefulWidget {
  @override
  _TurnoverView createState() {
    return _TurnoverView();
  }
}

class _TurnoverView extends State<TurnoverView> {
  List<String> listTurnoverView = ['Business', 'Invest', 'Gift', 'OverTime'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text('TURNOVER'),
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
            //padding: EdgeInsets.fromLTRB(50, top, right, bottom),
            child: Column(
              children: <Widget> [
                Expanded(
                  child: ListView.builder(
                      itemCount: listTurnoverView.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(listTurnoverView[index]),
                            onTap: () {
                              String s = listTurnoverView[index];
                              Map<String, String> data = {'name': s, 'groupName' : s, 'frequency': '0'};
                              Navigator.pop(context, data);
                            },
                          ),
                        );
                      }
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

