import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maganemoney/Model_ObjectMoney/User.dart';
import 'package:maganemoney/Model_ObjectMoney//AccountBalance.dart';
import 'package:provider/provider.dart';

import '../b_n_view.dart';
import 'EventLogin.dart';

class SignUpView extends StatelessWidget {

  void navigatorPushToApp(BuildContext context) {
    //Navigator.pushNamed(context, '/runapp');
    Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return MyHomePage();
        }
    ));
  }
  Widget UserName(BuildContext context, EventLogin eventLogin) {
    return Container(
      child: TextField(
        controller: eventLogin.controllerUserName,
        decoration: new InputDecoration(
          icon: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(Icons.person, color: Colors.black,),
          ),
          labelText: "User Name",
        ),
      ),
    );
  }

  Widget Age(BuildContext context, EventLogin eventLogin) {
    return Container(
      child: TextField(
        controller: eventLogin.controllerAge,
        decoration: new InputDecoration(
          icon: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(Icons.face),
          ),
          labelText: "Age",
        ),
      ),
    );
  }

  Widget EmailLogin(BuildContext context, EventLogin eventLogin) {
    return Container(
      child: TextField(
        controller: eventLogin.controllerEmailLogin,
        decoration: new InputDecoration(
          icon: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(Icons.email_outlined, color: Colors.black,),
          ),
          labelText: "Email",
          suffixText: '@gmail.com',
        ),
      ),
    );
  }

  Widget PassWord(BuildContext context, EventLogin eventLogin) {
    return Container(
      child: TextField(
        obscureText: true,
        controller: eventLogin.controllerPassword,
        decoration: new InputDecoration(
          icon: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(Icons.lock, color: Colors.black,),
          ),
          labelText: "Password",
        ),
      ),
    );
  }

  Widget ConfirmPassWord(BuildContext context, EventLogin eventLogin) {
      return Container(
        child: TextField(
          obscureText: true,
          controller: eventLogin.controllerConfirmPassword,
          decoration: new InputDecoration(
            icon: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(Icons.lock, color: Colors.black,),
            ),
            labelText: "Confirm Password",
          ),
        ),
      );
    }

  Widget SignUpButton(BuildContext context, EventLogin eventLogin) {
    return Container(
      width: 200,
      height: 80,
      padding: EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        child: ElevatedButton(
          onPressed: () async {
            if (eventLogin.checkEmailLoginNULL(eventLogin) == true || eventLogin.checkPassWordNULL(eventLogin) == true ||
            eventLogin.checkUserNameNULL(eventLogin) == true || eventLogin.checkAgeNULL(eventLogin) == true ||
            eventLogin.checkConfirmPasswordNULL(eventLogin) == true) {

            }
            /*else if (await eventLogin.checkEmailLoginRight(eventLogin) == true) {
              eventLogin.controllerEmailLogin.text = 'This Email Existed';
            }*/
            else {
              User.user.mail = eventLogin.controllerEmailLogin.text;
              User.user.pass = eventLogin.controllerPassword.text;
              User.user.name = eventLogin.controllerUserName.text;
              User.user.age = int.parse(eventLogin.controllerAge.text);
              User.user.insertUser(User.user);

              eventLogin.controllerUserName.clear();
              eventLogin.controllerEmailLogin.clear();
              eventLogin.controllerPassword.clear();
              eventLogin.controllerAge.clear();
              eventLogin.controllerConfirmPassword.clear();

              EventLogin.id = await User.user.getCountRows();
              var x = EventLogin.id;
              print('dong 129 class SignUpView, EventLogin.id = $x ');
              AccountBalance.accountBalance.idUser = EventLogin.id;
              AccountBalance.accountBalance.sumCurrentMoney = 0.0;
              AccountBalance.accountBalance.insertAccountBalance(AccountBalance.accountBalance);

              AccountBalance.accountBalance.query();
              navigatorPushToApp(context);
            }
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.black45;
                    }
                    return Colors.pinkAccent[400];
                  }),
              elevation: MaterialStateProperty.resolveWith<double>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)
                      ||  states.contains(MaterialState.disabled)) {
                    return 0;
                  }
                  return 20;
                },
              )
          ),
          child: Text('SIGN UP', style: TextStyle(fontSize: 25, color: Colors.white,), ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget UserName_EmailLogin_PassWord_ConfirmPassword(BuildContext context, EventLogin eventLogin) {
    return Container(
      child: Container(
        padding: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 30),
              child: Column(
                children: [
                  Container(
                    child: UserName(context, eventLogin),
                  ),
                  Container(
                    child: Age(context, eventLogin),
                  ),
                  Container(
                    child: EmailLogin(context, eventLogin),
                  ),
                  Container(
                    child: PassWord(context, eventLogin),
                  ),
                  Container(
                    child: ConfirmPassWord(context, eventLogin),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget SignUp() {
    return Stack(
      children: [
        Center(
          child: ChangeNotifierProvider(
            create: (context) {
              return EventLogin();
            },
            child: Container(
              padding: EdgeInsets.only(left: 50, right: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Consumer<EventLogin>(
                          builder: (context, eventLogin, child) => UserName_EmailLogin_PassWord_ConfirmPassword(context, eventLogin)
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 300, left: 10, right: 10),
                          child: Consumer<EventLogin>(
                            builder: (context, eventLogin, child) {
                              return SignUpButton(context, eventLogin);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SignUp();
  }
}