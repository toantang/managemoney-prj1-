import 'package:flutter/cupertino.dart';

import 'Model_ObjectMoney/AccountBalance.dart';
import 'Model_ObjectMoney/ScheduleObject.dart';
import 'listObjectUseEveryClass.dart';

class BottomNavigationController with ChangeNotifier {

  List<List> _listData = new List();

  double _sumCurrentMoney = 0;
  int _currentIndex = 0;
  PageController _pageController = new PageController(
    initialPage: 0,
    keepPage: true,
  );

  Future<List<List>> getDataList() async {

    List<List> list = new List();
    this._sumCurrentMoney = await AccountBalance.accountBalance.getSumCurrentMoney();
    List<List> listDataSchedule = await ScheduleObject.scheduleObject.listDataUnfinished();
    List<List> listDataExpenditureFixed = await ((ListUseEveryClass.listObject)[1]).getDataExpenditureFixed();
    List<List> listDataTurnoverFixed = await ((ListUseEveryClass.listObject)[3]).getDataTurnoverFixed();
    List<List> listDataAccountBalance = await AccountBalance.accountBalance.getAllData();

    list.add(listDataSchedule);
    list.add(listDataExpenditureFixed);
    list.add(listDataTurnoverFixed);
    list.add(listDataAccountBalance);

    this._listData = list;
    return this._listData;
  }

  void changePageView(int i) {
    this._currentIndex = i;
    notifyListeners();
  }

  void changeBottomView(int index) {
    this._currentIndex = index;
    this._pageController.animateToPage(index, duration: Duration(milliseconds: 100), curve: Curves.ease);
    notifyListeners();
  }

  PageController get pageController => _pageController;

  set pageController(PageController value) {
    _pageController = value;
  }

  int get currentIndex => _currentIndex;

  set currentIndex(int value) {
    _currentIndex = value;
  }
}