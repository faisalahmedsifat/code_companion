import 'package:flutter/material.dart';

import '../models/users/user.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage(this.user);
  User? user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(child: Text(user?.handle as String)),
      ),
    );
  }
}
