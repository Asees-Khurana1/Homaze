import 'package:homaze/model/util.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavouritesPage extends StatefulWidget {

  FavouritesPage({Key? key}) : super(key: key);

  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {

  fetchFavourites() {
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance
        .collection('users')
        .doc(Util.appUser!.uid)
        .collection("favourites")
        .snapshots();
    return stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Favourites"),
        ),
        body: StreamBuilder(
          stream: fetchFavourites(),
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
                  map['docId'] = document.id.toString();

                  return Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(map['imageUrl'].toString(),
                              alignment: Alignment.center),
                          SizedBox(height: 5),
                          Divider(),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(5),
                            child: Text(map['about project'],
                                style: TextStyle(
                                    color: Colors.lightBlue, fontSize: 20)),
                          ),
                          // Text(map['about project'], style: TextStyle(color:Colors.lightBlue,fontSize: 20),textAlign:TextAlign.center),
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
                          //           style: TextStyle(
                          //               color: Colors.white, fontSize: 16.0),
                          //         ),
                          //         Icon(Icons.star_rounded,
                          //             color: Colors.white, size: 19.0)
                          //       ]),
                          //   decoration: BoxDecoration(
                          //       color: Colors.green,
                          //       borderRadius: BorderRadius.circular(8.0)),
                          // ),
                          // ]),
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
