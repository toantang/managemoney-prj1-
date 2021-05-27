import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maganemoney/login/EventLogin.dart';
import 'package:maganemoney/login/SignInView.dart';
import 'package:maganemoney/login/SignUpView.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Magane your Money',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginView(),
      /*onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/runapp':
            return MaterialPageRoute(builder: (context)=> MyApp1());
            break;
          case '/loginview':
            return MaterialPageRoute(builder: (context)=> LoginView());
            break;
        }
      },*/
    );

  }
}

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent[400],
      body: HomeLogin(),
    );
  }
}

class HomeLogin extends StatefulWidget {
  @override
  _HomeLogin createState() {
    return _HomeLogin();
  }
}
class _HomeLogin extends State<HomeLogin> {

  String s = 'assets/images/itachi.jpg';

  Widget BackGroundLoginView(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.pink[400],
        ),
        Container(
          color: Colors.pink[300],
          height: MediaQuery.of(context).size.height / 1.6,
        ),
        Container(
          color: Colors.pinkAccent[100],
          height: MediaQuery.of(context).size.height / 2.0,
        ),
        Container(
          color: Colors.pinkAccent[100],
          height: MediaQuery.of(context).size.height / 2.5,
        )
      ],
    );
  }

  Color colorLeft = Colors.white;
  Color colorRight = Colors.black;
  PageController _pageViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.pink[400],
      body: Stack(
        children: [
          BackGroundLoginView(context),
          //_buildMenuBar(context),
          PageView(
            controller: _pageViewController,
            onPageChanged: (i) {
              if (i == 0) {
                setState(() {
                  colorRight = Colors.white;
                  colorLeft = Colors.black;
                });
              }
              else if (i == 1) {
                setState(() {
                  colorRight = Colors.black;
                  colorLeft = Colors.white;
                });
              }
            },
            children: [
              SignInView(),
              SignUpView(),
            ],
          )
          //LoginViewView(),
        ],
      ),
    );
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50),
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SignUpView()
                  ));
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Text(
                  "Existing",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: "WorkSansSemiBold"),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: FlatButton(
                onPressed: () {

                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Text(
                  "New",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: "WorkSansSemiBold"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}