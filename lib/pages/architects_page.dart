import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'designs_page.dart';

class ArchitectsPage extends StatefulWidget {
  const ArchitectsPage({Key? key}) : super(key: key);

  @override
  _ArchitectsPageState createState() => _ArchitectsPageState();
}

class _ArchitectsPageState extends State<ArchitectsPage> {

  fetchArchitects() {
    Stream<QuerySnapshot> stream =
        FirebaseFirestore.instance.collection("Architects").snapshots();
    return stream;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: fetchArchitects(),
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
            children:
                snapshot.data!.docs.map<Widget>((DocumentSnapshot document) {
          Map<String, dynamic> map = document.data()! as Map<String, dynamic>;
          return InkWell(
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              margin: EdgeInsets.all(10.0),
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage:
                            NetworkImage(map['imageUrl'].toString()),
                      ),
                      SizedBox(width: 20),
                      Text(map['name'], style: TextStyle(fontSize: 18)),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(6.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                map['rating'].toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.0),
                              ),
                              Icon(Icons.star_rounded,
                                  color: Colors.white, size: 16.0)
                            ]),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                    ]),
                    // Text(
                    //   map['no.'].toString() + '.',
                    //   style: TextStyle(fontSize: 18),
                    // ),
                    SizedBox(height: 20),
                    Row(children: [
                      Text("City - " + map['city'].toString(),
                          style:
                              TextStyle(color: Colors.black54, fontSize: 15)),
                      Spacer(),
                      Container(
                        child: Text("Contact : "+map['contact'].toString(),style: TextStyle(fontSize: 15,color: Colors.black54),),
                      )

                    ]),
                    Divider(),
                    Text("Number of Designs = " + map['designs'].toString(),
                        style:
                            TextStyle(fontSize: 15, color: Colors.indigoAccent)),
                    SizedBox(height: 6)
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DesignPage(architectId: document.id)));
            },
          );
        }).toList());
      },
    );
  }
}
