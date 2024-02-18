import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser{

  String? uid;
  String? name;
  String? email;
  String? imageUrl;
  GeoPoint? currentLocation;

  AppUser({this.uid, this.name, this.email, this.imageUrl, this.currentLocation});

  // it will be executed whenever we will print reference of User Object
  @override
  String toString() {
    return 'User{uid: $uid, name: $name, email: $email, imageUrl: $imageUrl}';
  }

  Map<String, dynamic> toMap(){
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "imageUrl": ""
    };

  }
}