import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  navigateToHome(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    Future.delayed(Duration(seconds: 3), () {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        Navigator.pushReplacementNamed(context, "/login");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Util.fetchUserDetails();
    navigateToHome(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("homaze.png"),
            SizedBox(height: 12),
            Text(
              "Homaze",
              style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Divider(color: Colors.black, thickness: 4.0),
            SizedBox(height: 12),
            Text(
              "Welcome to Homaze, The World of Architecture",
              style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
