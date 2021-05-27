import 'package:flutter/cupertino.dart';

class EventCheckSchedule extends ChangeNotifier {
  bool checkSchedule(List<int> listDateStart, int interval) {
    final timeStart = DateTime(listDateStart[2], listDateStart[1], listDateStart[0]);
    final date2 = DateTime.now();
    int difference = date2.difference(timeStart).inDays;
    if (difference > interval*30 + 3) {
      return true;
    }
    else {
      return false;
    }
  }
}