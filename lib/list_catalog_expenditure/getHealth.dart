import 'package:dynamic_treeview/dynamic_treeview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DataModel.dart';

class Health extends StatelessWidget {
  List<BaseData> getHealth() {
    return [
      DataModel(
        id: 1,
        name: 'Root',
        parentId: -1,
        extras: {'key': 'Health'},
      ),
      DataModel(
        id: 2,
        name: 'Health',
        parentId: 1,
        extras: {'key': 'Health'},
      ),
      DataModel(
        id: 3,
        name: 'Examination',
        parentId: 2,
        extras: {'key': 'Examination3'},
      ),
      DataModel(
        id: 4,
        name: 'Insurance',
        parentId: 2,
        extras: {'key': 'Insurance4'},
      ),
      DataModel(
        id: 5,
        name: 'Medicine',
        parentId: 2,
        extras: {'key': 'Medicine5'},
      ),
      DataModel(
        id: 6,
        name: 'Sport',
        parentId: 2,
        extras: {'key': 'Sport6'},
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return DynamicTreeView(
      data: getHealth(),
      config: Config(
          parentTextStyle: TextStyle(fontWeight: FontWeight.w600),
          childrenTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          arrowIcon: Icon(Icons.local_hospital, color: Colors.redAccent,),
          rootId: "1",
          parentPaddingEdgeInsets:
          EdgeInsets.only(left: 16, top: 0, bottom: 0)),
      onTap: (m) {
        String s = m['title'];
        Map<String, String> data = {'name': s, 'groupName': 'Health', 'frequency': '0'};
        Navigator.pop(context, data);
      },
      width: MediaQuery.of(context).size.width,
    );
    throw UnimplementedError();
  }
}