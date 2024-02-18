import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homaze/model/util.dart';
import 'package:homaze/pages/profile_page.dart';
import 'architects_page.dart';
import 'designing_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  List appBarName = ['Homaze', 'Designs', 'Options'];

  List widgets = [ArchitectsPage(), DesigningPage(), UserProfile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarName[index]),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/favourites");
            },
            icon: Icon(Icons.favorite),
            tooltip: "Favourites",
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Are you sure you want to Sign Out ?'),
                    actions: <Widget>[
                      TextButton(
                        child: Text("YES"),
                        onPressed: () {
                          Util.appUser = null;
                          FirebaseAuth.instance.signOut();
                          Navigator.pushReplacementNamed(context, "/login");
                        },
                      ),
                      TextButton(
                        child: Text("NO"),
                        onPressed: () {
                          Navigator.of(context).pop();

                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.logout),
            tooltip: "Log Out",
          )
        ],
      ),
      body: widgets[index],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Architects"),
          BottomNavigationBarItem(
              icon: Icon(Icons.design_services), label: "Designs"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded), label: "Options")
        ],
        currentIndex: index,
        selectedFontSize: 16,
        selectedItemColor: Colors.amber,
        onTap: (idx) {
          setState(() {
            index = idx;
          });
        },
      ),
    );
  }
}
