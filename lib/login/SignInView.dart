import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maganemoney/Model_ObjectMoney/User.dart';
import 'package:maganemoney/list_menu/menu.dart';
import 'package:provider/provider.dart';

import '../b_n_view.dart';
import 'EventLogin.dart';


class SignInView extends StatefulWidget {
  @override
  _SignInView createState() {
    return _SignInView();
  }
}
class _SignInView extends State<SignInView> {

  void navigatorPushToApp(BuildContext context) {
    //Navigator.pushNamed(context, '/runapp');
    Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return MyHomePage();
        }
    ));
  }

  Widget EmailLogin(BuildContext context, EventLogin eventLogin) {
    return Container(
      child: TextField(
        controller: eventLogin.controllerEmailLogin,
        decoration: new InputDecoration(
          icon: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(Icons.email, color: Colors.black,),
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
            child: Icon(Icons.lock_outlined, color: Colors.black,),
          ),
          labelText: "Password",
        ),
      ),
    );
  }

  Widget EmailLoginAndPassWord(BuildContext context, EventLogin eventLogin) {
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
                    child: EmailLogin(context, eventLogin),
                  ),
                  Container(
                    child: PassWord(context, eventLogin),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget LoginButton(BuildContext context, EventLogin eventLogin) {
    return Container(
      width: MediaQuery.of(context).size.width/2,
      height: MediaQuery.of(context).size.height/8.325,
      padding: EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        child: ElevatedButton(
          onPressed: () async {
            var s = await User.user.queryAllRows();
            print(s);
            navigatorPushToApp(context);

            /*if (eventLogin.checkEmailLoginNULL(eventLogin) == true ) {
              eventLogin.showFlushbarEmailLogin(context, eventLogin, "Email is NULL");
            }
            else if (eventLogin.checkPassWordNULL(eventLogin) == true) {
              eventLogin.showFlushbarPasswordLogin(context, eventLogin, "Password is NULL");
            }
            else if (await eventLogin.checkEmailLoginRight(eventLogin) == false) {
              eventLogin.showFlushbarEmailLogin(context, eventLogin, "Email is not correct");
            }
            else if (await eventLogin.checkPasswordRight(eventLogin) == false) {
              eventLogin.showFlushbarPasswordLogin(context, eventLogin, "Password is not correct");
            }
            else if (await eventLogin.canLoginRight(eventLogin) == true){
              var s = EventLogin.id;
              print("dong 417 class SignInView, eventLogin.id = $s");
              navigatorPushToApp(context);
            }*/
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
                  return 25;
                },
              )
          ),
          child: Text('LOGIN', style: TextStyle(fontSize: 25, color: Colors.white,), ),
        ),
      ),
    );
  }

  Widget fAndGButton(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/1.55, left: MediaQuery.of(context).size.width/4.1),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              heroTag: 'bt1',
              child: Text('f', style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
              )),

            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/1.55, left: MediaQuery.of(context).size.width/8.2),
          child: Text('or', style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            decoration: TextDecoration.underline,
          )),
        ),
        Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/1.55, left: MediaQuery.of(context).size.width/8.2),
          child: Align(
            alignment: Alignment.centerRight,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              heroTag: 'bt2',
              child: Text('G', style: TextStyle(
                color: Colors.blue,
                fontSize: 17,
              )),

            ),
          ),
        ),
      ],
    );
  }

  Widget SignIn(BuildContext context) {
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
                          builder: (context, eventLogin, child) => EmailLoginAndPassWord(context, eventLogin)
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 125, left: 10, right: 10),
                          child: Consumer<EventLogin>(
                            builder: (context, eventLogin, child) {
                              return LoginButton(context, eventLogin);
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
        Container(
          //padding: EdgeInsets.only(top: 440, left: 100, right: 50),
          padding: EdgeInsets.only(top: 550, left: 100, right: 50),
          child: TextButton(
            child: Text('Forgot Password?', style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              decoration: TextDecoration.underline,
            )),
            onPressed: () {

            },
          ),
        ),
        fAndGButton(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SignIn(context);

  }
}