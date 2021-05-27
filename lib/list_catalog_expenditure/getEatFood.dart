import 'package:dynamic_treeview/dynamic_treeview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DataModel.dart';

class EatFood extends StatefulWidget {
  @override
  _EatFood createState() {
    return _EatFood();
  }
}
class _EatFood extends State<EatFood> {

  List<BaseData> getEatFood() {
    return [
      DataModel(
        id: 1,
        name: 'Root',
        parentId: -1,
        extras: {'key': 'extradata1'},
      ),
      DataModel(
        id: 2,
        name: 'Eat & Coffe',
        parentId: 1,
        extras: {'key': 'Eat & Coffe'},
      ),
      DataModel(
        id: 3,
        name: 'Eat',
        parentId: 2,
        extras: {'key': 'Eat & Coffe'},
      ),
      DataModel(
        id: 4,
        name: 'Coffee',
        parentId: 2,
        extras: {'key': 'Eat & Coffe'},
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: DynamicTreeView(
        data: getEatFood(),
        config: Config(
            parentTextStyle: TextStyle(fontWeight: FontWeight.w600),
            childrenTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            arrowIcon: Icon(Icons.fastfood, color: Colors.deepOrange,),
            rootId: "1",
            parentPaddingEdgeInsets: EdgeInsets.only(left: 16, top: 0, bottom: 0)),
        onTap: (m) {
          String s = m['title'];
          Map<String, String> data = {'name': s, 'groupName': 'Eat & Coffe', 'frequency': '0'};
          Navigator.pop(context, data);
        },
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}