import 'package:dynamic_treeview/dynamic_treeview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DataModel.dart';
class Holiday extends StatelessWidget {
  List<BaseData> getHoliday() {
    return [
      DataModel(
        id: 1,
        name: 'Root',
        parentId: -1,
        extras: {'key': 'extradata1'},
      ),
      DataModel(
        id: 2,
        name: 'Holiday',
        parentId: 1,
        extras: {'key': 'Holiday2'},
      ),
      DataModel(
        id: 3,
        name: 'Wedding',
        parentId: 2,
        extras: {'key': 'Wedding3'},
      ),
      DataModel(
        id: 4,
        name: 'Tet holiday',
        parentId: 2,
        extras: {'key': 'Tet4'},
      ),
      DataModel(
        id: 5,
        name: 'Anniversary',
        parentId: 2,
        extras: {'key': 'Anniversary5'},
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return DynamicTreeView(
      data: getHoliday(),
      config: Config(
          parentTextStyle: TextStyle(fontWeight: FontWeight.w600),
          childrenTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          arrowIcon: Icon(Icons.people_outline, color: Colors.blueGrey),
          rootId: "1",
          parentPaddingEdgeInsets:
          EdgeInsets.only(left: 16, top: 0, bottom: 0)),
      onTap: (m) {
        String s = m['title'];
        Map<String, String> data = {'name': s, 'groupName': 'Holiday', 'frequency': '0'};
        Navigator.pop(context, data);
      },
      width: MediaQuery.of(context).size.width,
    );
    throw UnimplementedError();
  }
}