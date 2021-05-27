import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventSideMenuView extends ChangeNotifier {
  TextEditingController changeNameController = new TextEditingController();
  TextEditingController changeAgeController = new TextEditingController();
  TextEditingController passWordController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();
  TextEditingController confirmPassWord = new TextEditingController();

  bool checkTextFieldNull(String s) {
    if (s == '') {
      return true;
    }
    else {
      return false;
    }
  }

  void UserNameEmpty(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Container(
            child: AlertDialog(
              title: Text('UserName is Empty'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('YES', style: TextStyle(fontSize: 15),)
                )
              ],
            ),
          );
        }
    );
  }

  void AgeEmpty(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Container(
            child: AlertDialog(
              title: Text('Age is not correct'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('YES', style: TextStyle(fontSize: 15),)
                )
              ],
            ),
          );
        }
    );
  }

  void PassWordNull(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Container(
            child: AlertDialog(
              title: Text("Change Password failed"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('YES', style: TextStyle(fontSize: 15),)
                )
              ],
            ),
          );
        }
    );
  }
}