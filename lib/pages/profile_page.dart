import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:homaze/model/util.dart';
import 'package:image_picker/image_picker.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // String imagePath = "NA";
  // final ImagePicker _picker = ImagePicker();
  //
  // Future<void> uploadFile(String filePath) async {
  //   File file = File(filePath);
  //
  //   try {
  //     await FirebaseStorage.instance
  //         .ref('profile-pics/' + Util.appUser!.uid.toString() + '.png')
  //         .putFile(file);
  //     print("UPLOAD SUCCESS");
  //   } on FirebaseException catch (e) {
  //     print("UPLOAD FAILED");
  //   }
  // }

  // fetchImage() async {
  //   var data =
  //   await FirebaseStorage.instance.ref().child("profile-pics").getData();
  //   print(data);
  // }

  @override
  Widget build(BuildContext context) {
    Util.fetchUserDetails();

    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        Card(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Padding(padding: EdgeInsets.all(8.0)),
              InkWell(
                // onTap: () async {
                //   final XFile? image =
                //       await _picker.pickImage(source: ImageSource.gallery);
                //   uploadFile(image!.path);
                // },
                child: CircleAvatar(
                    radius: 90.0,
                    backgroundImage:
                        NetworkImage(Util.appUser!.imageUrl.toString())),
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              Divider(),
              Padding(padding: EdgeInsets.all(4.0)),
              Text(Util.appUser!.name.toString(),
                  style: TextStyle(color: Colors.lightBlue, fontSize: 20)),
              Padding(padding: EdgeInsets.all(4.0)),
              Text(Util.appUser!.email.toString(),
                  style: TextStyle(color: Colors.lightBlue, fontSize: 15)),
              Padding(padding: EdgeInsets.all(4.0))
            ])),
        Padding(padding: EdgeInsets.all(8.0)),
        ListTile(
            leading: Icon(Icons.person),
            title: Text("Manage Profile"),
            //subtitle: Text("Update Your Data for Your Account"),
            trailing: Icon(Icons.keyboard_arrow_right_rounded),
            onTap: () {}),
        ListTile(
            leading: Icon(Icons.house),
            title: Text("Ongoing Projects"),
            trailing: Icon(Icons.keyboard_arrow_right_rounded),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/ongoing-projects');
            }),
        ListTile(
          leading: Icon(Icons.attach_money),
          title: Text("Purchase a Project"),
          //subtitle: Text("Update Your Addresses for Delivery"),
          trailing: Icon(Icons.keyboard_arrow_right_sharp),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Buy premium version ?'),
                  content:
                      Text("Includes video with 3D Tour and architect booking"),
                  actions: <Widget>[
                    TextButton(
                      child: Text("YES"),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/payments');
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
        ),
        ListTile(
          leading: Icon(Icons.message),
          title: Text("Help"),
          //subtitle: Text("Raise Your Queries"),
          trailing: Icon(Icons.keyboard_arrow_right_sharp),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.document_scanner_outlined),
          title: Text("Terms & Conditions"),
          //subtitle: Text("Check our Terms and Conditions"),
          trailing: Icon(Icons.keyboard_arrow_right_sharp),
          onTap: () {},
        ),
      ],
    );
  }
}
