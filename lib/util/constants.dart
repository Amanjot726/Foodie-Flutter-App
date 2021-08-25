import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app/Model/user.dart';
import 'package:flutter/material.dart';

final APP_NAME="Foodie";
final RESTAURANT_COLLECTION = FirebaseFirestore.instance.collection("restaurants");
final DISHES_COLLECTION="dishes";
final USER_COLLECTION = FirebaseFirestore.instance.collection("users");
// final FIREBASE_Auth = FirebaseAuth.instance;
// final FIREBASE_Storage = FirebaseStorage.instance;
// final FIREBASE_Firestore = FirebaseFirestore.instance;
final APP_ICON="Restaurants.png";
final Color PRIMARY_COLOR = Colors.green;
final String USERS_COLLECTION="users";

var CART = {};

Update_Cart() async{
  await FirebaseFirestore.instance.collection("users").doc(get_Uid()).update({"cart" : CART});
}


AppUser? get_user_data;

get_Uid(){
  return FirebaseAuth.instance.currentUser!= null ? FirebaseAuth.instance.currentUser!.uid : "";
}

Future get_data() async {
  var data_snapshot = await FirebaseFirestore.instance.collection("users").doc(await get_Uid()).get();
  if (data_snapshot.exists) {
    Map<String, dynamic>? data = data_snapshot.data();

    // You can then retrieve the value from the Map like this:
    get_user_data = AppUser(
      uid: data!['uid'],
      name: data['name'],
      email: data['email'],
      Profile_pic: data['profile_pic'],
      isAdmin: data['isAdmin'],
    );
    CART = data['cart'];
  }
}
