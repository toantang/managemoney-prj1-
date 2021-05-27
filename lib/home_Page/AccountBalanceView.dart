import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maganemoney/Model_ObjectMoney/AccountBalance.dart';
import 'package:maganemoney/home_Page/EventAccountBalance.dart';
import 'package:provider/provider.dart';

import '../listObjectUseEveryClass.dart';

class AccountBalanceView extends StatefulWidget {
  static AccountBalanceView accountBalanceView;

  @override
  _AcountBalance createState() {
    return _AcountBalance();
  }
}
class _AcountBalance extends State<AccountBalanceView> {

  Future<void> refreshList() async {
    setState(() {
      getSumMoney();
    });
  }

  Future<List<List>> getSumMoney() async {
    double sumMoneyExpenditure = await (ListUseEveryClass.listObject[0]).getSumMoney();
    double sumMoneyExpenditureFixed = await (ListUseEveryClass.listObject[1]).getSumMoney();
    double sumMoneyTurnover = await (ListUseEveryClass.listObject[2]).getSumMoney();
    double sumMoneyTurnoverFixed = await (ListUseEveryClass.listObject[3]).getSumMoney();
    List<List> listDataAccountBalance = await AccountBalance.accountBalance.getAllData();

    double sumMoneyAll = sumMoneyTurnover + sumMoneyTurnoverFixed - sumMoneyExpenditure - sumMoneyExpenditureFixed;

    List<double> listGroupMoney = new List();
    listGroupMoney.add(sumMoneyAll);
    listGroupMoney.add(sumMoneyExpenditure);
    listGroupMoney.add(sumMoneyExpenditureFixed);
    listGroupMoney.add(sumMoneyTurnover);
    listGroupMoney.add(sumMoneyTurnoverFixed);

    List<List> list = new List();
    list.add(listDataAccountBalance);
    list.add(listGroupMoney);

    return list;
  }

  //select Group Money(Expenditure, ExpenditureFixed, Turnover, TurnoverFixed)
  List<String> listNameGroupMoney = ['Expenditure', 'Expenditure Fixed', 'Turnover', 'Turnover Fixed'];

  Widget InforAccountBalance(BuildContext context, List<double> list) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.clear, size: 30),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Information'),
        ),
        body: ChangeNotifierProvider(
          create: (context) => EventAccountBalance(),
          child: Consumer<EventAccountBalance>(
            builder: (context, eventAccountBalance, child) {
              return ListView.builder(
                  itemCount: list.length - 1,
                  itemBuilder: (context, index) {
                    String name = listNameGroupMoney[index];
                    String money = list[index+1].toString();
                    String phanNguyen = '0.';
                    String phanThapPhan = '0';
                    if (money == '0.0') {

                    }
                    else {
                      List<String> listStringMoney = money.split('.');
                      phanNguyen = eventAccountBalance.PhanNguyen(listStringMoney[0]);
                      String tachPhanThapPhan = listStringMoney[1];
                      if (tachPhanThapPhan == '0') {

                      }
                      else {
                        phanThapPhan = eventAccountBalance.PhanThapPhan(tachPhanThapPhan);
                      }
                    }

                    return Card(
                      child: ListTile(
                        title: Text(name + ': ' + phanNguyen + phanThapPhan + '\$', style: TextStyle(fontSize: 20),),
                      ),
                    );
                  }
              );
            }
          )
        ),
      );
    }

  Color colorMoney;
  @override
  Widget build(BuildContext context) {
      return Container(
        //padding: EdgeInsets.only(top: 5, left: 30, right: 30),
        child: RefreshIndicator(
          onRefresh: refreshList,
          child: FutureBuilder(
              future: getSumMoney(),
              builder: (BuildContext context, AsyncSnapshot<List<List>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: Text('Sorry, We can not find data')
                  );
                }
                else {
                  final items = snapshot.data;
                  List<List> listDataSumCurrentMoney = items[0];
                  List<double> listGroupMoney = items[1];

                  List<int> listPrimaryKey = listDataSumCurrentMoney[0];
                  List<int> listIdUser = listDataSumCurrentMoney[1];
                  List<double> listSumCurrentMoney = listDataSumCurrentMoney[2];

                  double sumMoney = listSumCurrentMoney[0];
                  if (sumMoney <= 0) {
                    colorMoney = Colors.red;
                  }
                  else {
                    colorMoney = Colors.brown;
                  }

                  return ChangeNotifierProvider(
                    create: (context) => EventAccountBalance(),
                    child: Consumer<EventAccountBalance> (
                      builder: (context, eventAccountBalance, child) {
                        String convertMoney;

                        if (sumMoney >= 1000) {
                          convertMoney = eventAccountBalance.convertLargeNumber(sumMoney);
                        }
                        else {
                          convertMoney = sumMoney.toStringAsFixed(2);
                        }

                        return TextButton(
                            onPressed: () {
                              //refreshList();
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return InforAccountBalance(context, listGroupMoney);
                                  }
                              ));
                            },
                            child: Column(
                              children: [
                                Text('Account Balance: ', style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline),),
                                Text('$convertMoney \$', style: TextStyle(
                                    fontSize: 20,
                                    color: colorMoney,
                                    decoration: TextDecoration.underline),
                                ),
                              ],
                            )
                        );
                      },
                    ),
                  );
                }
              }
          ),
        ),
      );
    }
}