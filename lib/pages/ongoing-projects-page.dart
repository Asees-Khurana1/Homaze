import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OngoingProjectsPage extends StatefulWidget {
  OngoingProjectsPage({Key? key}) : super(key: key);

  @override
  _OngoingProjectsPageState createState() => _OngoingProjectsPageState();
}

class _OngoingProjectsPageState extends State<OngoingProjectsPage> {
  fetchDesigns() {
    Stream<QuerySnapshot> stream =
        FirebaseFirestore.instance.collection("Ongoing Projects").snapshots();
    return stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ongoing Projects")
        ),
        body: StreamBuilder(
          stream: fetchDesigns(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "SOMETHING WENT WRONG",
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
                padding: EdgeInsets.all(8),
                children: snapshot.data!.docs
                    .map<Widget>((DocumentSnapshot document) {
                  Map<String, dynamic> map =
                      document.data()! as Map<String, dynamic>;

                  return Card(
                    elevation: 5.0,
                    margin: EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(map['imageUrl'].toString(),
                              alignment: Alignment.center),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  );
                }).toList());
          },
        ));
  }
}
