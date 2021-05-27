import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackView extends StatelessWidget {

  String feedback = "If you have any contributions, please send to …. We are happy to get your feedbacks";
  _launchURL() async {
    const url = 'https://www.facebook.com/profile.php?id=100006470907624';
    if (await canLaunch(url)) {
      await launch(url);
    }
    else {
      throw 'Could not launch $url';
    }
  }

  Widget Feedback(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.clear, size: 30,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text('Feedback'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 15, left: 10, right: 15),
                child: Text(feedback, style: TextStyle(
                    fontSize: 20),),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                child: TextButton(
                  child: Text('https://www.facebook.com/profile/toantang', style: TextStyle(
                      fontSize: 20),),
                  onPressed: _launchURL,
                ),
              )
            ],
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.border_color),
      title: Text('Feedback'),
      onTap: () => {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => Feedback(context),
      )),
      },
    );
  }
}