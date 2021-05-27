import 'package:dynamic_treeview/dynamic_treeview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DataModel.dart';

class Gift extends StatelessWidget {
  List<BaseData> getGift() {
    return [
      DataModel(
        id: 1,
        name: 'Root',
        parentId: -1,
        extras: {'key': 'extradata1'},
      ),
      DataModel(
        id: 2,
        name: 'Gift & Donate',
        parentId: 1,
        extras: {'key': 'Gift & Donate'},
      ),
      DataModel(
        id: 3,
        name: 'Gift',
        parentId: 2,
        extras: {'key': 'Gift & Donate'},
      ),
      DataModel(
        id: 4,
        name: 'Donate',
        parentId: 2,
        extras: {'key': 'Gift & Donate'},
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return DynamicTreeView(
      data: getGift(),
      config: Config(
          parentTextStyle: TextStyle(fontWeight: FontWeight.w600),
          childrenTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          arrowIcon: Icon(Icons.card_giftcard, color: Colors.deepOrangeAccent),
          rootId: "1",
          parentPaddingEdgeInsets:
          EdgeInsets.only(left: 16, top: 0, bottom: 0)),
      onTap: (m) {
        String s = m['title'];
        Map<String, String> data = {'name': s, 'groupName': 'Gift & Donate', 'frequency': '0'};
        Navigator.pop(context, data);
      },
      width: MediaQuery.of(context).size.width,
    );
    throw UnimplementedError();
  }
}