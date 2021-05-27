import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '2.0.ProfileView.dart';

class ProfileTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.verified_user),
      title: Text('Profile'),
      onTap: () => {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return ProfileView();
            }
        ))
      },
    );
  }
}