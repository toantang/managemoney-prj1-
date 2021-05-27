import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maganemoney/schedule/EventSchedule.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  CalendarState createState() => CalendarState();

}

class CalendarState extends State<Calendar>{
  CalendarController _controller;
  int _day;
  int _month;
  int _year;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  void _sendDataBack(BuildContext context, EventSchedule eventSchedule) {
    Map<String, dynamic> dateData = new Map();

    String dateStartSchedule = this._day.toString() + '/' + this._month.toString() + '/' + this._year.toString();
    int dateStart = this._year*10000 + this._month*100 + this._day;
    dateData['dateStartString'] = dateStartSchedule;
    dateData['dateStart'] = dateStart;
    Navigator.pop(context, dateData);
  }

  void SetDate(int day, int month, int year) {
    this._day = day;
    this._month = month;
    this._year = year;
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return EventSchedule();
        },
      child: Consumer<EventSchedule>(
        builder: (context, eventSchedule, child) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      Navigator.pop(context, 'Select Date Start');
                    },
                  ),
                  title: Text('Calendar'),
                  actions: <Widget> [
                    FlatButton(
                      child: Text('Save'),
                      onPressed: () {
                        _sendDataBack(context, eventSchedule);
                      },
                    ),
                  ]
              ),
              body: Column(
                children: <Widget> [
                  SafeArea(
                      child: SizedBox(
                        height: 400,
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

                                SetDate(date.day, date.month, date.year);

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
        },
      ),

    );
  }
}


