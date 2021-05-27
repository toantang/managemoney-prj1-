import 'package:dynamic_treeview/dynamic_treeview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DataModel.dart';

class Relax extends StatelessWidget {
  List<BaseData> getRelax() {
    return [
      DataModel(
        id: 1,
        name: 'Root',
        parentId: -1,
        extras: {'key': 'extradata1'},
      ),
      DataModel(
        id: 2,
        name: 'Relax',
        parentId: 1,
        extras: {'key': 'Relax2'},
      ),
      DataModel(
        id: 3,
        name: 'Films',
        parentId: 2,
        extras: {'key': 'Films3'},
      ),
      DataModel(
        id: 4,
        name: 'Games',
        parentId: 2,
        extras: {'key': 'Games4'},
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return DynamicTreeView(
      data: getRelax(),
      config: Config(
          parentTextStyle: TextStyle(fontWeight: FontWeight.w600),
          childrenTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          arrowIcon: Icon(Icons.gamepad, color: Colors.grey,),
          rootId: "1",
          parentPaddingEdgeInsets:
          EdgeInsets.only(left: 16, top: 0, bottom: 0)),
      onTap: (m) {
        String s = m['title'];
        Map<String, String> data = {'name': s, 'groupName': 'Relax', 'frequency': '0'};
        Navigator.pop(context, data);
      },
      width: MediaQuery.of(context).size.width,
    );
    throw UnimplementedError();
  }
}
