import 'package:flutter/cupertino.dart';

class EventTurnoverChart extends ChangeNotifier {
  String textDateStart = "Date Start";
  String textDateEnd = "Date End";

  bool checkLeapYear(int yearNow) {
    if ( (yearNow % 400 == 0) || ((yearNow % 100 == 0) && (yearNow % 4 == 0))) {
      return true;
    }
    else {
      return false;
    }
  }

  bool check31days(int monthNow) {
    if (monthNow == 1 || monthNow == 3 || monthNow == 5 || monthNow == 7 || monthNow == 8 || monthNow == 10 || monthNow == 12) {
      return true;
    }
    else {
      return false;
    }
  }

  bool check(List<String> dateStart, List<String> dateEnd) {
    int sizeStart = dateStart.length;
    int sizeEnd = dateEnd.length;
    if ((sizeStart != sizeEnd) || (sizeStart == sizeEnd && sizeStart == 1 && sizeEnd == 1)) {
      return true;
    }
    else {
      int startDay = int.parse(dateStart[0]);
      int startMonth = int.parse(dateStart[1]);
      int startYear = int.parse(dateStart[2]);

      int endDay = int.parse(dateEnd[0]);
      int endMonth = int.parse(dateEnd[1]);
      int endYear = int.parse(dateEnd[2]);

      if (startYear == endYear) {
        if (startMonth == endMonth) {
          if (startDay > endDay) {
            return false;
          }
          else {
            return true;
          }
        }
        else if (startMonth > endMonth) {
          return false;
        }
        else {
          return true;
        }
      }
      else if (startYear > endYear){
        return false;
      }
      else {
        return true;
      }
    }
  }

  int dayEndofMonthSelect(int monthSelect, int yearSelect) {
    int dayEndSelect = 31;
    if (checkLeapYear(yearSelect) == false) {
      if (check31days(monthSelect) == true) {
        dayEndSelect = 31;
      }
      else {
        dayEndSelect = 30;
      }
    }
    else {
      if (monthSelect == 2) {
        dayEndSelect = 28;
      }
      else if (check31days(monthSelect) == true) {
        dayEndSelect = 31;
      }
      else {
        dayEndSelect = 30;
      }
    }

    return dayEndSelect;
  }
}