import 'package:flutter/material.dart';
import 'package:maganemoney/account_settingapp/1.WelcomeView.dart';
import 'package:maganemoney/account_settingapp/3.SettingsView.dart';
import 'package:maganemoney/account_settingapp/4.FeedbackView.dart';
import 'package:maganemoney/account_settingapp/5.LogoutView.dart';

import '0.SideMenuView.dart';
import '2.1.ProfileTitle.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SideMenu(),
          WelcomeView(),
          Divider(),
          ProfileTitle(),
          Divider(),
          SettingsView(),
          Divider(),
          FeedbackView(),
          Divider(),
          LogoutView(),
          Divider(),
        ],
      ),
    );
  }
}