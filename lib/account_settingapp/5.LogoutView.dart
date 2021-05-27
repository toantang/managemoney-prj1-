import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maganemoney/login/EventLogin.dart';

class LogoutView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text('Logout'),
      onTap: () {
        EventLogin.id = 0;
        var s = EventLogin.id;
        print('dong 15 class Logout, EVentLogin.id = $s');
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }
}