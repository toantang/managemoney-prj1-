import 'package:dynamic_treeview/dynamic_treeview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DataModel.dart';

class Shopping extends StatelessWidget {
  List<BaseData> getShopping() {
    return [
      DataModel(
        id: 1,
        name: 'Root',
        parentId: -1,
        extras: {'key': 'Shopping'},
      ),
      DataModel(
        id: 2,
        name: 'Shopping',
        parentId: 1,
        extras: {'key': 'Shopping2'},
      ),
      DataModel(
        id: 3,
        name: 'Clothes',
        parentId: 2,
        extras: {'key': 'Clothes3'},
      ),
      DataModel(
        id: 4,
        name: 'Electronics',
        parentId: 2,
        extras: {'key': 'electronics4'},
      ),
      DataModel(
        id: 5,
        name: 'Shoes',
        parentId: 2,
        extras: {'key': 'Shoes5'},
      ),
    ];

  }
  @override
  Widget build(BuildContext context) {
    return DynamicTreeView(
      data: getShopping(),
      config: Config(
          parentTextStyle: TextStyle(fontWeight: FontWeight.w600),
          childrenTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          arrowIcon: Icon(Icons.shopping_cart, color: Colors.lightGreen),
          rootId: "1",
          parentPaddingEdgeInsets:
          EdgeInsets.only(left: 16, top: 0, bottom: 0)),
      onTap: (m) {
        String s = m['title'];
        Map<String, String> data = {'name': s, 'groupName': 'Shopping', 'frequency': '0'};
        Navigator.pop(context, data);
      },
      width: MediaQuery.of(context).size.width,
    );
    throw UnimplementedError();
  }
}