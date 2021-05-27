import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.settings),
      title: Text('Settings'),
      onTap: () => {Navigator.of(context).pop()},
    );
  }
}