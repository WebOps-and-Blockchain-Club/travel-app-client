import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app_client/Screens/Login/login_screen.dart';
import 'UserProvider.dart';
import 'home.dart';

class WrapperPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<Userprovider>(context);

    return FutureBuilder(
      future: userProvider.getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          if (userProvider.token != null) {
            return MyAppHome();
          } else {
            return LoginScreen();
          }
        }
      },
    );
  }
}
