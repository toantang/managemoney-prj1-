import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maganemoney/chart_money/expenditureFixed_chart.dart';
import 'package:maganemoney/chart_money/expenditure_chart.dart';
import 'package:maganemoney/chart_money/turnoverFixed_chart.dart';
import 'package:maganemoney/chart_money/turnover_chart.dart';

class Chart extends StatefulWidget {
  static int value = 0;
  @override
  _Chart createState() {
    return _Chart();
  }
}

class _Chart extends State<Chart> {

  List<Widget> listWidget = [ExpenditureChart(), ExpenditureFixedChart(), TurnoverChart(), TurnoverFixedChart()];
  List<String> listName = ['Expenditure', 'Expenditure Fixed', 'Turnover', 'Turnover Fixed'];
  List<Color> listColorElevatedButton = [Colors.deepPurple[100], Color(0xff13d38e), Colors.indigo[400], Colors.blueGrey[600]];

  Widget makeElevaButton(BuildContext context, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          Chart.value = index;
        });
      },
      child: Text(listName[index]),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.black45;
                }
                else {
                  return listColorElevatedButton[index];
                }
              }
          )
      ),
    );
  }

  Widget listSelectGroupMoney(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      height: 50,
      child: Expanded(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: listName.length,
              itemBuilder: (context, index) {
                return Container(
                  child: makeElevaButton(context, index),
                  padding: EdgeInsets.only(left: 10),
                );
              }
          )
      ),
    );
  }

  Future<void> refreshPage() async {
    setState(() {
      listWidget[Chart.value];
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white70,
      //backgroundColor: Colors.brown[400],
      body: Column(
        children: [
          listSelectGroupMoney(context),
          Expanded(child: listWidget[Chart.value]),
        ],
      ),
    );
  }
}