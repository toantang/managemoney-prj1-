import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maganemoney/Model_ObjectMoney/Expenditure.dart';
import 'package:maganemoney/Model_ObjectMoney/ExpenditureFixed.dart';
import 'package:maganemoney/Model_ObjectMoney/Turonver.dart';
import 'package:maganemoney/Model_ObjectMoney/TuronverFixed.dart';

import '../listObjectUseEveryClass.dart';

// ignore: camel_case_types
class StatisticController with ChangeNotifier {
  String _textDateStart = "Date Start";
  String _textDateEnd = "Date End";
  int _dateStart = 0;
  int _dateEnd = 22001231;
  int _selectDropdown = 0;
  int _currentIndexButton = 0;
  List<String> _listSelect = new List();

  PageController _pageControllerDivider = new PageController(
    keepPage: true,
    initialPage: 0,
  );

  List<bool> listCheck = [false, false, false, false]; //used in MoneyGroup method

  List<List> _listAllData = new List();

  //get Data From Database
  Future<List<List>> getData() async {
    List<List> listExpenditure = await Expenditure.expenditure.list(_dateStart, _dateEnd);
    List<List> listExpenditureFixed = await ExpenditureFixed.expenditureFixed.list(_dateStart, _dateEnd);
    List<List> listTurnover = await Turnover.turnover.list(_dateStart, _dateEnd);
    List<List> listTurnoverFixed = await TurnoverFixed.turnoverFixed.list(_dateStart, _dateEnd);

    List<List> list = new List();
    list.add(listExpenditure);
    list.add(listExpenditureFixed);
    list.add(listTurnover);
    list.add(listTurnoverFixed);

    this._listAllData = list;
    return this._listAllData;
  }

  //delete an Item
  void deleteItem(List<String> listName, int index, int id) {
    int currentValue = this._currentIndexButton;
     listName.removeAt(index);
     (ListUseEveryClass.listObject[currentValue]).deleteRow(id);
     notifyListeners();
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

    this._listSelect = list;
    return this._listSelect;
  }

  void changeIndexIsTrue(int index) {
    listCheck[index] = true;
    notifyListeners();
  }

  Color changeColorIndex(int index) {
    listCheck[index] = false;
    return Colors.black;
  }

  void changeCurrentIndexButton(int index) {
    this._currentIndexButton = index;
    notifyListeners();
  }
  void changeTextDateStart(String s) {
    this._textDateStart = s;
    notifyListeners();
  }
  void changeDateEnd(String s) {
    this._textDateEnd = s;
    notifyListeners();
  }

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


  void defaultObject(int index) {
    _dateStart = 0;
    _dateEnd = 22001231;
    _textDateStart = "Date Start";
    _textDateEnd = "Date End";
    _selectDropdown = 0;
    //_currentIndexButton = index;
    listCheck[index] = true;
    notifyListeners();
  }

  void changeDateSelectDropdownButton(List<String> listUserSelect, String val) {
    String monthSelectString = listUserSelect[0];
    String yearSelectString = listUserSelect[1];

    int monthSelect = int.parse(monthSelectString);
    int yearSelect = int.parse(yearSelectString);
    int dayEndSelect = 30;

    print("dong 304 class Statistic val = $val");
    int count = -1;
    for (int i = 0; i < _listSelect.length; i++) {
      if (_listSelect[i] == val) {
        count = i;
        break;
      }
    }

    _selectDropdown = count;
    dayEndSelect = dayEndofMonthSelect(monthSelect, yearSelect);
    String daySelectString = dayEndSelect.toString();

    _textDateStart = '1/' + monthSelectString + '/' + yearSelectString;
    _textDateEnd = daySelectString + '/' +
        monthSelectString + '/' + yearSelectString;

    int c = yearSelect*10000 + monthSelect*100;
    _dateStart = c + 1;
    _dateEnd = c + dayEndSelect;
    notifyListeners();
  }

  PageController get pageControllerDivider => _pageControllerDivider;

  set pageControllerDivider(PageController value) {
    _pageControllerDivider = value;
  }

  List<String> get listSelect => _listSelect;


  int get currentIndexButton => _currentIndexButton;

  set currentIndexButton(int value) {
    _currentIndexButton = value;
  }

  set listSelect(List<String> value) {
    _listSelect = value;
  }

  int get selectDropdown => _selectDropdown;

  set selectDropdown(int value) {
    _selectDropdown = value;
  }

  List<List> get listAllData => _listAllData;

  set listAllData(List<List> value) {
    _listAllData = value;
  }

  int get dateEnd => _dateEnd;

  set dateEnd(int value) {
    _dateEnd = value;
  }

  int get dateStart => _dateStart;

  set dateStart(int value) {
    _dateStart = value;
  }

  String get textDateEnd => _textDateEnd;

  set textDateEnd(String value) {
    _textDateEnd = value;
  }

  String get textDateStart => _textDateStart;

  set textDateStart(String value) {
    _textDateStart = value;
  }

}

