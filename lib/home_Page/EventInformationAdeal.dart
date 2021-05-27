import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventInformationDeal extends ChangeNotifier {

  TextEditingController formFieldController = new TextEditingController();

  String PhanNguyen(String s) {
    int size = s.length;
    String moneyDeal = '';

    if (size > 3) {
      List<String> listMoney = new List();
      String ss;

      for (int i = size - 1; i > 2; i = i-3) {
        String value = s[i-2] + s[i-1] + s[i];
        listMoney.add(value);
        ss = s.substring(0, i-2);
      }
      listMoney.add(ss);
      int cnt = listMoney.length;
      for (int i = cnt-1; i >= 0; i--) {
        if (i == 0) {
          moneyDeal = moneyDeal + listMoney[i] + '.';
        }
        else {
          moneyDeal = moneyDeal + listMoney[i] + ',';
        }
      }
    }
    else {
      moneyDeal = s + '.';
    }
    return moneyDeal;
  }

  String PhanThapPhan(String s) {
    int size = s.length;
    List<String> listMoney = new List();
    String ss;

    for (int i = 0; i < size - 2; i = i + 3) {
      String value = s[i] + s[i+1] + s[i+2];
      listMoney.add(value);
      ss = s.substring(i+3, size);
      print('ss = $ss');
    }
    if (ss == '') {

    }
    else {
      listMoney.add(ss);
    }

    int cnt = listMoney.length;
    String phanThapPhan = '';
    for (int i = 0; i < cnt; i++) {
      if (i == cnt -1) {
        phanThapPhan = phanThapPhan + listMoney[i];
      }
      else {
        phanThapPhan = phanThapPhan + listMoney[i] + ',';
      }
    }
    return phanThapPhan;
  }

  String convertLargeNumber(double moneyDeal) {
    double money = 0;
    String convertMoney = moneyDeal.toString();
    if (moneyDeal >= 1000 && moneyDeal < 999999) {
      money = moneyDeal/1000;
      convertMoney = money.toStringAsFixed(2);
      return convertMoney + 'K';
    }
    else if (moneyDeal >= 1000000 && moneyDeal < 999999999) {
      money = moneyDeal/1000000;
      convertMoney = money.toStringAsFixed(2);
      return convertMoney + 'M';
    }
    else if (moneyDeal >= 1000000000 && moneyDeal < 999999999999) {
      money = moneyDeal/1000000000;
      convertMoney = money.toStringAsFixed(2);
      return convertMoney + 'B';
    }

    return convertMoney;
  }
}