import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DesigningPage extends StatefulWidget {

  DesigningPage({Key? key}) : super(key: key);

  @override
  _DesigningPageState createState() => _DesigningPageState();
}

class _DesigningPageState extends State<DesigningPage> {
  fetchDesigns() {
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance
        .collection("Designs")
        .snapshots();
    return stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          //Row(children: [
                            //Text("\u20b9"+map['price'].toString(),
                            //style: TextStyle(color: Colors.black54, fontSize: 14)),
                            // Container(
                            //   padding: EdgeInsets.all(6.0),
                            //   child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       children: [
                            //         Text(
                            //           map['rating'].toString(),
                            //           style: T
                            //           extStyle(
                            //               color: Colors.white, fontSize: 16.0),
                            //         ),
                            //         Icon(Icons.star_rounded,
                            //             color: Colors.white, size: 19.0)
                            //       ]),
                            //   decoration: BoxDecoration(
                            //       color: Colors.green,
                            //       borderRadius: BorderRadius.circular(8.0)),
                            // ),
                          //]),
                          //Text(map['category'], style: TextStyle(fontSize: 12, color: Colors.lightBlue)),
                        ],
                      ),
                    ),
                  );
                }).toList());
          },
        ));
  }
}
