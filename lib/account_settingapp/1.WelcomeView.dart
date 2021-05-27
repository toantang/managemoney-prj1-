import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget{
  String welcome = "Manager Application has been founded with a desire to help you manage personal finance scientifically and "
      "logically for your future.  You can add a transaction in the day, view transaction history or reckon transaction chart "
      "in a visual way. Even you can make plans for your future. And Manager Money will go with you to do this.";

  String welcome1 = "Your success is our development team’s happiness.";
      //"If you have any contributions, please send to …. We are happy to get your feedbacks";
  Widget Welcome(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.clear, size: 30,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text('Welcome'),
          ),
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 15, left: 10, right: 20),
                child: Text(welcome, style: TextStyle(
                  fontSize: 20),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 20),
                child: Text(welcome1, style: TextStyle(
                    fontSize: 20),),
              )
            ],
          ),
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.input),
      title: Text('welcome'),
      onTap: () => {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => Welcome(context)
        )),
      },
    );
  }
}