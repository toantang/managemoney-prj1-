import 'package:dynamic_treeview/dynamic_treeview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DataModel.dart';

class Friends extends StatelessWidget {
  List<BaseData> getFriends() {
    return [
      DataModel(
        id: 1,
        name: 'Root',
        parentId: -1,
        extras: {'key': 'extradata1'},
      ),
      DataModel(
        id: 2,
        name: 'Friends & Girls',
        parentId: 2,
        extras: {'key': 'Friends & Girls'},
      ),
      DataModel(
        id: 3,
        name: 'Friends',
        parentId: -1,
        extras: {'key': 'Friends & Girls'},
      ),
      DataModel(
        id: 4,
        name: 'Girls',
        parentId: 2,
        extras: {'key': 'Friends & Girls'},
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return DynamicTreeView(
      data: getFriends(),
      config: Config(
          parentTextStyle: TextStyle(fontWeight: FontWeight.w600),
          childrenTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          arrowIcon: Icon(Icons.people),
          rootId: "1",
          parentPaddingEdgeInsets:
          EdgeInsets.only(left: 16, top: 0, bottom: 0)),
      onTap: (m) {
        String s = m['title'];
        Map<String, String> data = {'name': s, 'groupName': 'Friends & Girls', 'frequency': '0'};
        Navigator.pop(context, data);
        },
      width: MediaQuery.of(context).size.width,
    );
    throw UnimplementedError();
  }
}