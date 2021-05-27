import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maganemoney/Model_ObjectMoney/User.dart';
import 'package:maganemoney/account_settingapp/2.0.ProfileView.dart';
import 'package:maganemoney/login/EventLogin.dart';

class SideMenu extends StatelessWidget {

  Future<String> getName() async {
    String s = await User.user.getName(EventLogin.id);
    return s;
  }

  Widget ShowName(BuildContext context) {
    return Expanded(
        child: FutureBuilder(
          future: getName(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            else {
              final items = snapshot.data;
              return TextButton(
                  child: Text(items, style: TextStyle(color: Colors.cyan[600], fontSize: 20, decoration: TextDecoration.underline),),
                onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ProfileView(),
                    ));
                }
              );
            }
          },
        )
    );
}

  String backGroundImage = 'assets/images/pexels-aviv-perets-3274903.jpg';
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(0.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
            ),
            child: Image.asset(backGroundImage, fit: BoxFit.fill, ),
          ),
          Center(
            child: DrawerHeader(
              child: Column(
                children: [
                  Text(
                    'Side menu',
                    style: TextStyle(color: Colors.purpleAccent[100], fontSize: 25),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 60),
                    child: ShowName(context),
                  )
                ],
              ),
              //decoration: BoxDecoration(color: Colors.black12),
            ),
          )
        ],
      ),
    );
  }
}