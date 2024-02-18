import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homaze/model/designs.dart';
import 'package:homaze/model/util.dart';

class Counter extends StatefulWidget {
  Map<String, dynamic>? design;

  Counter({Key? key, @required this.design}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {

  addFavouriteInCart() {
    Design favourites = Design(
        imageUrl: widget.design!['imageUrl'].toString(),
        aboutProject: widget.design!['about project']);

    FirebaseFirestore.instance
        .collection("users")
        .doc(Util.appUser!.uid)
        .collection("favourites")
        .doc(widget.design!['docId'])
        .set(favourites.toMap());
  }

  deleteFavourites() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(Util.appUser!.uid)
        .collection("favourites")
        .doc(widget.design!['docId'])
        .delete();
  }

  @override
  Widget build(BuildContext context) {
      return Container(
        alignment: Alignment.center,
        //width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle, color: Colors.lightBlueAccent),
        child: TextButton(
          child: Text("Add to Favourites", style: TextStyle(color: Colors.white)),
          onPressed: () {
            setState(() {
              addFavouriteInCart();
            });
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Added to Favourites'),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Go Back'))
                ],
              ),
            );
          },
        ),
      );
    }
    // return Container(
    //   width: MediaQuery.of(context).size.width / 3,
    //   decoration: BoxDecoration(
    //       shape: BoxShape.rectangle, color: Colors.lightBlueAccent),
    //   child: Row(
    //     children: [
    //       TextButton(
    //         onPressed: () {
    //           setState(() {
    //             if (initialValue <= 0) {
    //               deleteDishFromCart();
    //             } else {
    //               initialValue--;
    //               updateDishInCart();
    //             }
    //           });
    //         },
    //         child:
    //         Text("-", style: TextStyle(color: Colors.black, fontSize: 14)),
    //       ),
    //       Text(initialValue.toString(),
    //           style: TextStyle(color: Colors.black, fontSize: 14)),
    //       TextButton(
    //         onPressed: () {
    //           setState(() {
    //             initialValue++;
    //             updateDishInCart();
    //           });
    //         },
    //         child:
    //         Text("+", style: TextStyle(color: Colors.black, fontSize: 14)),
    //       )
    //     ],
    //   ),
    // );
  }