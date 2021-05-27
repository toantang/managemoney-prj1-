import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maganemoney/Model_ObjectMoney/Deals.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  CalendarState createState() => CalendarState();

}

class CalendarState extends State<Calendar>{
  CalendarController _controller;
  int _day = 0;
  int _month = 0;
  int _year = 0;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  void _sendDataBack(BuildContext context) {
    if (this._day == 0 || this._month == 0 || this._year == 0) {
      Navigator.pop(context);
    }
    else {
      Map<String, dynamic> dateData = new Map();
      String date; // in ra date dưới dạng year/month/day 2020/09/08
      String dateDeal; // lưu date vào database dưới dạng year_month_day, ví dụ 20200908

      if (this._day >= 1 && this._day <= 9) {
        dateDeal = '0' + this._day.toString();
      }
      else {
        dateDeal = this._day.toString();
      }
      date =  dateDeal + "/";

      if (this._month >= 1 && this._month <= 9) {
        dateDeal = '0' + this._month.toString() + dateDeal;
        date = date + '0' + this._month.toString() + "/";
      }
      else {
        dateDeal = this._month.toString() + dateDeal;
        date = date + this._month.toString() + '/';
      }
      date = date + this._year.toString();
      dateDeal = this._year.toString() + dateDeal;

      dateData['date'] = date;
      int dateDealInteger = int.parse(dateDeal);
      dateData['dateDeal'] = dateDealInteger;
      Deal.deal.dateDeal = dateDealInteger;
      Navigator.pop(context, dateData);
    }
  }

  void setDate(int day, int month, int year) {
    this._day = day;
    this._month = month;
    this._year = year;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            Navigator.pop(context, 'Select Date');
          },
        ),
        title: Text('Calendar'),
        actions: <Widget> [
          FlatButton(
            child: Text('Save'),
            onPressed: () {
              _sendDataBack(context);
              },
          ),
        ]
      ),
      body: Column(
        children: <Widget> [
          SafeArea(
              child: SizedBox(
                height: 482,
                child: TableCalendar(
                  initialCalendarFormat: CalendarFormat.month,
                  calendarStyle: CalendarStyle(
                    todayColor: Colors.blueAccent,
                    selectedColor: Colors.deepOrange,
                  ),
                  headerStyle: HeaderStyle(
                    centerHeaderTitle: true,
                    formatButtonDecoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    formatButtonTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                    formatButtonShowsNext: false,
                  ),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  builders: CalendarBuilders(
                      selectedDayBuilder: (context, date, events) {

                        setDate(date.day, date.month, date.year);

                        return Container(
                            margin: const EdgeInsets.all(4.0),
                            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Text(date.day.toString(), style: TextStyle(
                              color: Colors.white,
                            ),)
                        );
                      },
                      todayDayBuilder: (context, date, events) {
                        return Container(
                            margin: const EdgeInsets.all(4.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Text(date.day.toString(), style: TextStyle(
                              color: Colors.white,
                            ),)
                        );
                      }
                  ),
                  calendarController: _controller,
                ),
              )
          ),
        ],
      )
    );
  }
}


