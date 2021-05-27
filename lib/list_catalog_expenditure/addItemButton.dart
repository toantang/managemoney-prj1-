import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '2.AddAnItem.dart';

class AddItemButton extends StatelessWidget {
  Widget addItem(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => AddAnItem()
        ));
      },
      child: Text('Add an item', style: TextStyle(color: Colors.green, fontSize: 17),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return addItem(context);
  }
}