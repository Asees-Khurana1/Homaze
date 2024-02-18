import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:homaze/pages/favourites_page.dart';
// import 'package:homaze/pages/favourites_page.dart';
import 'package:homaze/pages/home_page.dart';
import 'package:homaze/pages/login_page.dart';
import 'package:homaze/pages/ongoing-projects-page.dart';
import 'package:homaze/pages/payment_methods_page.dart';
import 'package:homaze/pages/razorpay_page.dart';
import 'package:homaze/pages/register_page.dart';
import 'package:homaze/pages/splash_page.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (context) => SplashPage(),
        "/home": (context) => HomePage(),
        "/login": (context) => LoginPage(),
        "/register": (context) => RegisterUserPage(),
        "/favourites": (context) => FavouritesPage(),
        "/payments": (context) => PaymentMethodsPage(),
        "/razorpay": (context) => RazorPayPaymentPage(),
        "/ongoing-projects": (context) => OngoingProjectsPage(),
      },
      initialRoute: "/",
    );
  }
}
