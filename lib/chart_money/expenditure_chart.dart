import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maganemoney/Model_ObjectMoney/AccountBalance.dart';
import 'package:maganemoney/Model_ObjectMoney/Expenditure.dart';
import 'package:maganemoney/home_Page/InformationADeal.dart';
import 'package:maganemoney/list_menu/Table_Calendar.dart';
import 'package:maganemoney/login/EventLogin.dart';
import 'package:maganemoney/chart_money/EventExpenditureChart.dart';

import 'package:provider/provider.dart';

import '../listObjectUseEveryClass.dart';

class ExpenditureChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExpenditureChart();
}

class _ExpenditureChart extends State<ExpenditureChart> {

  int _dateStart = 0;
  int _dateEnd = 22001231;
  int _selectDropdown = 0;

  int touchedIndex = 0;
  Future<List<double>> listMoney;
  List<String> listNameExpenditure = ['Eat & Coffe', 'Shopping', 'Vehicle', 'Health', 'Relax', 'Holiday', 'Gift & Donate',
  ];

  List<Color> listColor = [Color(0xff845bef), Color(0xff13d38e), Color(0xff0293ee), Colors.blueGrey[300],
    Colors.deepOrange, Colors.yellow[700], Colors.cyan[400]
  ];

  Future<List<double>> list() async {
    List list = new List();
    List<double> listPercent = new List();
    list = await Expenditure.expenditure.listMoneyStartEnd(_dateStart, _dateEnd);

    int size = list.length;
    double sum = 0;
    for (int i = 0; i < size; i++) {
      sum = sum + list[i];
    }
    for (int i = 0; i < size; i++) {
      double a = list[i]*100/sum;
      a = num.parse(a.toStringAsFixed(2));
      listPercent.add(a);
    }
    return listPercent;
  }

  Future<List<List>> getData() async {
    List<List> listExpenditureFixed = await Expenditure.expenditure.listData(listNameExpenditure[touchedIndex],
        _dateStart, _dateEnd);

    List<List> list = new List();
    list.add(listExpenditureFixed);

    return list;
  }

  //Retrieve textDayStart from Calendar
  Future<void> _awaitReturnValueFromCalendarStart(BuildContext context, EventExpenditureChart eventExpenditureChart) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Calendar(),
        ));
    this._dateStart = result['dateDeal'];

    setState(() {
      _selectDropdown = 0;

      if (this._dateStart == null) {
        eventExpenditureChart.textDateStart = 'Date Start';
      }
      else {
        if (this._dateStart > this._dateEnd && this._dateEnd != 0) {
          eventExpenditureChart.textDateStart = 'Date Start';
          this._dateStart = 0;
        }
        else {
          eventExpenditureChart.textDateStart = result['date'];
        }
      }
    });
    print(eventExpenditureChart.textDateStart);
  }

  //Retrieve textDayEnd from Calendar
  Future<void> _awaitReturnValueFromCalendarEnd(BuildContext context, EventExpenditureChart eventStatistic) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Calendar(),
        ));
    this._dateEnd = result['dateDeal'];
    setState(() {
      _selectDropdown = 0;

      if (this._dateEnd == null) {
        eventStatistic.textDateEnd = 'Date End';
        this._dateEnd = 0;
      }
      else {
        if (this._dateEnd >= this._dateStart) {
          eventStatistic.textDateEnd = result['date']; // in ra duoi dang string y/m/d
        }
        else {
          this._dateEnd = 0;
          eventStatistic.textDateEnd = 'Date End';
        }
      }
    });
    print(eventStatistic.textDateEnd);
  }

  Widget SetDateStatistic(BuildContext context, EventExpenditureChart eventExpenditureChart) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 5, right: 5),
      child: ChangeNotifierProvider(
        create : (context) {
          return EventExpenditureChart();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 5),
              width: MediaQuery.of(context).size.width/2.1,
              decoration: BoxDecoration(
                  color: Colors.blueGrey[50],
                  border: Border(
                      bottom: BorderSide(width: 2, color: Colors.deepPurpleAccent[700])
                  )
              ),
              child: ListTile(
                leading: Icon(Icons.date_range, color: Colors.deepPurpleAccent,),
                title: Text(eventExpenditureChart.textDateStart),
                onTap: () {
                  _awaitReturnValueFromCalendarStart(context, eventExpenditureChart);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 5),
              child: Container(
                width: MediaQuery.of(context).size.width/2.1, //2.3
                decoration: BoxDecoration(
                  //color: Colors.blueGrey[50],
                    color: Colors.blue,
                    border: Border(
                        bottom: BorderSide(width: 2, color: Colors.deepPurpleAccent[700])
                    )
                ),
                child: ListTile(
                  leading: Icon(Icons.date_range, color: Colors.deepPurpleAccent,),
                  title: Text(eventExpenditureChart.textDateEnd),
                  onTap: () {
                    _awaitReturnValueFromCalendarEnd(context, eventExpenditureChart);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> listSelectDate() {
    List<String> list = new List();
    DateTime dateTime = DateTime.now();
    int monthNow = dateTime.month;
    int yearNow = dateTime.year;

    int cnt = 6;
    int i = 0;
    list.add('Select Month');
    while(i < cnt) {
      if (monthNow == 0) {
        monthNow = 12;
        yearNow = yearNow - 1;
      }
      list.add(monthNow.toString() + '/' + yearNow.toString());
      monthNow--;
      i++;
    }

    return list;
  }

  List<String> dateSelect;
  //Make dropdown Button select Month
  Widget makeDropDownButtonSelectDate(BuildContext context, EventExpenditureChart eventExpenditureChart) {
    dateSelect = listSelectDate();

    return Container(
      padding: EdgeInsets.only(top: 15),
      child: DropdownButton(
        value: dateSelect[_selectDropdown],
        items: dateSelect.map((String value) {
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
                        child: new Text(value, style: TextStyle(color: Colors.black, fontSize: 17),),
                        padding: EdgeInsets.only(top: 10)
                    ),
                  ],
                ),
              )
          );
        }).toList(),
        onChanged: (String val) {

          List<String> listUserSelect = val.split('/');
          String monthSelectString = listUserSelect[0];
          String yearSelectString = listUserSelect[1];

          int monthSelect = int.parse(monthSelectString);
          int yearSelect = int.parse(yearSelectString);
          int dayEndSelect = 30;

          setState(() {
            print("dong 304 class Statistic val = $val");
            int count = -1;
            for (int i = 0; i < dateSelect.length; i++) {
              if (dateSelect[i] == val) {
                count = i;
                break;
              }
            }
            _selectDropdown = count;
            dayEndSelect = eventExpenditureChart.dayEndofMonthSelect(monthSelect, yearSelect);
            String daySelectString = dayEndSelect.toString();

            eventExpenditureChart.textDateStart = '1/' + monthSelectString + '/' + yearSelectString;
            eventExpenditureChart.textDateEnd = daySelectString + '/' + monthSelectString + '/' + yearSelectString;

          });
        },
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.white70, fontSize: 30),
        underline: Container(
          height: 2,
          color: Colors.yellow[100],
        ),
      ),
    );
  }

  Widget ThreeButtonDate(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventExpenditureChart(),
      child: Consumer<EventExpenditureChart> (
        builder: (context, eventChart, child) {
          return Column(
            children: [
              makeDropDownButtonSelectDate(context, eventChart),
              SetDateStatistic(context, eventChart),
            ],
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    listMoney = list();
    getData();
  }

  Future<void> refreshList() async {
    setState(() {
      listMoney = list();
      getData();
    });
  }

  bool checkNaN(var value) {
    if (value.isNaN) {
      return true;
    }
    else {
      return false;
    }
  }

  bool checkListisNaN(List<dynamic> items) {
    int size = items.length; // do dai cua listMoney
    int count = 0;
    for (int i = 0; i < size; i++) {
      if (items[i].isNaN) {
        count++;
      }
    }
    if (count == size) {
      return true;
    }
    else {
      return false;
    }
  }

  List<PieChartSectionData> listChart;

  List<PieChartSectionData> showingSections(BuildContext context, List<double> items, int cnt) {
    return List.generate(cnt, (i)
    {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 20 : 16;
      final double radius = isTouched ? 110 : 100;
      final double widgetSize = isTouched ? 55 : 40;

      var val = items[i];

      if (checkNaN(val)) {
        return null;
      }
      else {
        double value = val;
        if (value == 0) {
          return PieChartSectionData(
            value: 0,
          );
        }
        else {
          return PieChartSectionData(
            color: listColor[i],
            value: value,
            title: value.toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/ophthalmology-svgrepo-com.svg',
              size: widgetSize,
              borderColor: const Color(0xff0293ee),
            ),
            badgePositionPercentageOffset: .98,
          );
        }
      }
    }
    );
  }

  List<PieChartSectionData> makeListWidget(BuildContext context, List<double> items, int cnt) {
    listChart = new List();
    int size = listNameExpenditure.length;
    for (int i = 0; i < size; i++) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 20 : 16;
      final double radius = isTouched ? 110 : 100;
      final double widgetSize = isTouched ? 55 : 40;

      var val = items[i];
      double value = val;
      print('value = $value');
      if (value == 0) {

      }
      else {
        PieChartSectionData widgetChart = new PieChartSectionData(
          color: listColor[i],
          value: value,
          title: value.toString(),
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          badgeWidget: _Badge(
            'assets/ophthalmology-svgrepo-com.svg',
            size: widgetSize,
            borderColor: const Color(0xff0293ee),
          ),
          badgePositionPercentageOffset: .98,
        );
        listChart.add(widgetChart);
      }
    }

    return listChart;
  }

  Widget makePieChart(BuildContext context, List<double> items, int cnt) {
    return RefreshIndicator(
      onRefresh: refreshList,
      child: PieChart(
        PieChartData(
            pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
              setState(() {
                listMoney = list();
                print('touchedIndex = $touchedIndex');
                if (pieTouchResponse.touchInput is FlLongPressEnd ||
                    pieTouchResponse.touchInput is FlPanEnd) {
                } else {
                  touchedIndex = pieTouchResponse.touchedSectionIndex;
                }
              });
            }),
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 0,
            sections: showingSections(context, items, cnt),
       ),
      )
    );
  }

  Widget makeChart(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: AspectRatio(
        aspectRatio: 1.4,
        child: Card(
          color: Colors.deepPurple[100],
          child: AspectRatio(
            aspectRatio: 1,
            child: FutureBuilder<List<double>>(
                future: listMoney,
                builder: (BuildContext context, AsyncSnapshot<List<double>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  else {
                    final items = snapshot.data;
                    int cnt = listNameExpenditure.length;

                    if (checkListisNaN(items)) {
                      return Center(
                        child: Text('No have data'),
                      );
                    }
                    else {
                      return makePieChart(context, items, cnt);
                    }
                  }
                }
            ),
          ),
        ),
      ),
    );
  }

  void deleteItem(List<String> listName, int index, int id) {
    //tim id tai vi tri index
    (ListUseEveryClass.listObject[0]).deleteRow(id);
    listName.removeAt(index);

    setState(() {
      listMoney = list();
    });
  }

  Widget ShowItem(BuildContext context, List<String> listName, int index, String groupMoney, String nameDeal, String groupName,
      String money, String printDateDeal, int id) {
    return Card(
      color: listColor[touchedIndex],
      child: ListTile(
        leading: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Text(nameDeal, style: TextStyle(color: Colors.black87, fontSize: 16, ), ),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 60),
          child: Text('$money\$', style: TextStyle(color: Colors.red),),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_forever, color: Colors.black45, size: 25,),
          onPressed: () async {
            double sumCurrentMoney = await AccountBalance.accountBalance.getSumCurrentMoney();
            sumCurrentMoney = sumCurrentMoney + double.parse(money);

            AccountBalance.accountBalance.updateSumCurrentMoney(EventLogin.id, sumCurrentMoney);

            setState(() {
              deleteItem(listName, index, id);
            });
          },
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return InformationADeal(groupMoney: groupMoney, nameDeal: nameDeal, groupName: groupName,
                    money: money, dateDealString: printDateDeal, id: id);
              }
          ));
        },
      ),
    );
  }

  Widget showListItems(BuildContext context) {
    return Expanded(child: Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      height: MediaQuery.of(context).size.height / 1.7,
      child: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<List<List>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text('Data is null'));
          }
          else {
            final items = snapshot.data; // items la mot List chua cac listName, listMoney, listDay, etc...
            print('list item: $items');
            var item = items[0];
            List<int> listPrimaryKey = item[0];
            List<String> listName = item[2];
            List<String> listGroupName = item[3];
            List<double> listMoney = item[4];
            List<int> listDateDeal = item[5];

            return ListView.builder(
                itemCount: listName.length,
                itemBuilder: (context, index) {
                  int id = listPrimaryKey[index];
                  String nameDeal = listName[index];
                  String groupName = listGroupName[index];
                  String money = listMoney[index].toString();
                  int dateDeal = listDateDeal[index];
                  String groupMoney = 'Expenditure';
                  String dateDealString = dateDeal.toString();
                  String printDateDeal = dateDealString.substring(6, 8) + '/' + dateDealString.substring(4, 6) + '/' +
                      dateDealString.substring(0, 4);

                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.startToEnd,
                    child: ShowItem(context, listName, index, groupMoney, nameDeal, groupName, money, printDateDeal, id),
                    onDismissed: (direction) async {
                      double sumCurrentMoney = await AccountBalance.accountBalance.getSumCurrentMoney();
                      sumCurrentMoney = sumCurrentMoney + double.parse(money);

                      setState(() {
                        deleteItem(listName, index, id);
                      });

                      AccountBalance.accountBalance.updateSumCurrentMoney(EventLogin.id, sumCurrentMoney);
                    },
                  );;
                }
            );
          }
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          ThreeButtonDate(context),
          makeChart(context),
          Expanded(child: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            height: MediaQuery.of(context).size.height / 1.7,
            child: FutureBuilder(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<List<List>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text('Data is null'));
                }
                else {
                  final items = snapshot.data; // items la mot List chua cac listName, listMoney, listDay, etc...
                  print('list item: $items');
                  var item = items[0];
                  List<int> listPrimaryKey = item[0];
                  List<String> listName = item[2];
                  List<String> listGroupName = item[3];
                  List<double> listMoney = item[4];
                  List<int> listDateDeal = item[5];

                  return ListView.builder(
                      itemCount: listName.length,
                      itemBuilder: (context, index) {
                        int id = listPrimaryKey[index];
                        String nameDeal = listName[index];
                        String groupName = listGroupName[index];
                        String money = listMoney[index].toString();
                        int dateDeal = listDateDeal[index];
                        String groupMoney = 'Expenditure';
                        String dateDealString = dateDeal.toString();
                        String printDateDeal = dateDealString.substring(6, 8) + '/' + dateDealString.substring(4, 6) + '/' +
                            dateDealString.substring(0, 4);

                        return Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.startToEnd,
                          child: ShowItem(context, listName, index, groupMoney, nameDeal, groupName, money, printDateDeal, id),
                          onDismissed: (direction) async {
                            double sumCurrentMoney = await AccountBalance.accountBalance.getSumCurrentMoney();
                            sumCurrentMoney = sumCurrentMoney + double.parse(money);

                            setState(() {
                              deleteItem(listName, index, id);
                            });

                            AccountBalance.accountBalance.updateSumCurrentMoney(EventLogin.id, sumCurrentMoney);
                          },
                        );;
                      }
                  );
                }
              },
            ),
          )),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String svgAsset;
  final double size;
  final Color borderColor;

  const _Badge(
      this.svgAsset, {
        Key key,
        @required this.size,
        @required this.borderColor,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      /*child: Center(
        child: SvgPicture.asset(
          svgAsset,
          fit: BoxFit.contain,
        ),
      ),*/
    );
  }
}