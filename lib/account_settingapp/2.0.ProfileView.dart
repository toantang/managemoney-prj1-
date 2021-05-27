import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maganemoney/Model_ObjectMoney/User.dart';
import 'package:maganemoney/login/EventLogin.dart';
import 'package:provider/provider.dart';

import '0.0EventSideMenuView.dart';

class ProfileView extends StatefulWidget {
  _ProfileView createState() {
    return _ProfileView();
  }
}
class _ProfileView extends State<ProfileView> {

  int _id;
  String _userName;
  int _age;
  String _mail;
  String _password;

  Future<List<List>> getData() async {
    return await User.user.queryUser(EventLogin.id);
  }

  Future<void> refreshList() async {
    setState(() {
      getData();
    });
  }

  void updateUserName(BuildContext context, EventSideMenuView eventSideMenuView) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Container(
            child: AlertDialog(
              content: new Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: eventSideMenuView.changeNameController,
                      )
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      String userName = eventSideMenuView.changeNameController.text;
                      if (eventSideMenuView.checkTextFieldNull(userName) == true) {
                        eventSideMenuView.UserNameEmpty(context);
                      }
                      else {
                        this._userName = userName;
                        Navigator.pop(context);
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => ProfileView(),
                        ));
                      }
                    },
                    child: Text('YES', style: TextStyle(fontSize: 15),)
                )
              ],
            ),
          );
        }
    );
  }

  void updateAge(BuildContext context, EventSideMenuView eventSideMenuView) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Container(
            child: AlertDialog(
              content: new Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: eventSideMenuView.changeAgeController,
                      )
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      String age = eventSideMenuView.changeAgeController.text;
                      if (eventSideMenuView.checkTextFieldNull(age) == true) {
                        eventSideMenuView.UserNameEmpty(context);
                      }
                      else {
                        setState(() {
                          this._age = int.parse(age);
                          User.user.update(this._id, this._userName, this._age, this._mail, this._password);
                        });
                        Navigator.pop(context);
                        // Navigator.pushReplacement(context, MaterialPageRoute(
                        //   builder: (context) => ProfileView(),
                        // ));
                      }
                    },
                    child: Text('YES', style: TextStyle(fontSize: 15),)
                )
              ],
            ),
          );
        }
    );
  }

  void updagePassword(BuildContext context, EventSideMenuView eventSideMenuView) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Container(
            child: AlertDialog(
              content: new Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: eventSideMenuView.passWordController,
                        decoration: new InputDecoration(
                          hintText: "Pass Word",

                        ),
                      )
                  ),
                  Expanded(
                      child: TextField(
                        controller: eventSideMenuView.newPasswordController,
                        decoration: new InputDecoration(
                          hintText: "New Pass Word",

                        ),
                      )
                  ),
                  Expanded(
                      child: TextField(
                        controller: eventSideMenuView.confirmPassWord,
                        decoration: new InputDecoration(
                          hintText: "Confirm Password",

                        ),
                      )
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      String password = eventSideMenuView.passWordController.text;
                      String newPassword = eventSideMenuView.newPasswordController.text;
                      String confirmPassword = eventSideMenuView.confirmPassWord.text;
                      if (eventSideMenuView.checkTextFieldNull(password) == true || eventSideMenuView.checkTextFieldNull(newPassword) == true ||
                          eventSideMenuView.checkTextFieldNull(confirmPassword) == true) {

                      }
                      else if (newPassword == confirmPassword) {
                        this._password = newPassword;
                        Navigator.pop(context);
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => ProfileView(),
                        ));
                      }
                      else {

                      }
                    },
                    child: Text('YES', style: TextStyle(fontSize: 15),)
                )
              ],
            ),
          );
        }
    );
  }

  //Information UserName
  Widget InforUserName(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Card(
        child: ChangeNotifierProvider(
          create: (context) => EventSideMenuView(),
          child: Consumer<EventSideMenuView> (
            builder: (context, eventSideMenuView, child) {
              return ListTile(
                /*onTap: () {
                  updateUserName(context, eventSideMenuView);
                },*/
                leading: Icon(Icons.person, color: Colors.black,),
                title: Text(this._userName),
              );
            },
          ),
        ),
      ),
    );
  }

  //Information Age
  Widget InforAge(BuildContext  context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Card(
        child: ChangeNotifierProvider(
          create: (context) => EventSideMenuView(),
          child: Consumer<EventSideMenuView> (
            builder: (context, eventSideMenuView, child) {
              return ListTile(
                /*onTap: () {
                  updateAge(context, eventSideMenuView);
                },*/
                leading: Icon(Icons.face, color: Colors.black,),
                title: Text(this._age.toString()),
              );
            },
          ),
        ),
      ),
    );
  }

  //Information Email
  Widget InforEmail(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Card(
        child: ListTile(
          leading: Icon(Icons.email),
          title: Text(this._mail),
        ),
      ),
    );
  }

  Widget ShowListProfileData(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Expanded(
          child: Container(
            child: FutureBuilder(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<List<List>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text('"No Information about User"'));
                }
                else {
                  final items = snapshot.data;
                  this._userName = items[1][0];
                  this._age = items[2][0];
                  this._mail = items[3][0];

                  return Column(
                    children: [
                      InforUserName(context),
                      InforAge(context),
                      InforEmail(context),
                    ],
                  );
                }
              },
            ),
          )
      ),
    );
  }

  Widget ListProfileView(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.clear, size: 30,),
              onPressed: () {

                Navigator.of(context).pop();
              },
            ),
            title: Text('Profile'),
          ),
          body: ShowListProfileData(context),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListProfileView(context);
  }
}