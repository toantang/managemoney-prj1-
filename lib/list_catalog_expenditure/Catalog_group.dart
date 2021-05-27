import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:maganemoney/list_catalog_expenditure/getEatFood.dart';
import 'package:maganemoney/list_catalog_expenditure/getHealth.dart';
import 'package:maganemoney/list_catalog_expenditure/getShopping.dart';
import 'package:maganemoney/list_catalog_expenditure/getVehicle.dart';
import 'package:maganemoney/list_catalog_expenditure/getFriends.dart';
import 'package:maganemoney/list_catalog_expenditure/getGift.dart';
import 'package:maganemoney/list_catalog_expenditure/getHoliday.dart';
import 'package:maganemoney/list_catalog_expenditure/getRelax.dart';

class CatalogGroup extends StatelessWidget {
  List<Widget> items = [
    new EatFood(), new Shopping(), new Vehicle(),
    new Health(), new Friends(), new Relax(),
    new Holiday(), new Gift(),
  ];

  @override
  Widget build(BuildContext context) {
     return Scaffold(
         appBar: AppBar(
           leading: IconButton(
             icon: Icon(Icons.clear),
             onPressed: () {
               Map<String, String> data = {'groupName': 'Name of Group Money'};
               Navigator.pop(context, data);
             },
           ),
           title: Text('EXPENDITURE'),
         ),
         body: Column(
           children: <Widget> [
             Expanded(
               child: ListView.builder(
                   itemCount: items.length,
                   itemBuilder: (context, index) {
                     return items[index];
                   }
               ),
             )
           ],
         ),
     );
  }
}








