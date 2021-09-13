import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app/Model/user.dart';
import 'package:flutter/material.dart';

final APP_NAME="Foodie";
final RESTAURANT_COLLECTION = FirebaseFirestore.instance.collection("restaurants");
final DISHES_COLLECTION="dishes";
final USERS_COLLECTION = FirebaseFirestore.instance.collection("users");
final EXTRAS_COLLECTION = FirebaseFirestore.instance.collection("Extras");
final ORDERS_COLLECTION = USERS_COLLECTION.doc(get_Uid()).collection("Orders");
// final FIREBASE_Auth = FirebaseAuth.instance;
// final FIREBASE_Storage = FirebaseStorage.instance;
// final FIREBASE_Firestore = FirebaseFirestore.instance;
final APP_ICON="Restaurants.png";
final Color PRIMARY_COLOR = Colors.green;


String DELIVERY_ADDRESS_TYPE = (ADDRESSES.isNotEmpty ? ADDRESSES[ADDRESSES.keys.toList()[0]]['Address Type'].toString() : "Please Select Address");
String DELIVERY_ADDRESS = (ADDRESSES.isNotEmpty ? ADDRESSES[ADDRESSES.keys.toList()[0]]['Address'].toString() : "");
String DEFAULT_PAYMENT_ICON = "https://firebasestorage.googleapis.com/v0/b/login-67a22.appspot.com/o/Payment_Mode_Icons%2Fpaytm.png?alt=media&token=846fe750-6ec1-4137-8262-50c31cece03e";
String DEFAULT_PAYMENT_MODE = "Paytm";
Map CART = {};
Map ADDRESSES = {};
AppUser? get_user_data;

List Tags = ["All", "Indian", "Veg", "Italian", "Chinese", "Non-Veg", "Fast Food", "Desserts", "Mexican", "Continental", "Bakery", "Juices", "Beverages"];


Update_Cart() async{
  await USERS_COLLECTION.doc(get_Uid()).update({"cart" : CART});
}

Update_Address() async{
  await USERS_COLLECTION.doc(get_Uid()).update({"address" : ADDRESSES});
}

Add_Cart() async{
  await USERS_COLLECTION.doc(get_Uid()).set({'cart': Map()},SetOptions(merge: true));
  return {};
}

Add_Address_Field() async{
  await USERS_COLLECTION.doc(get_Uid()).set({'address': Map()},SetOptions(merge: true));
  return {};
}

get_Uid(){
  return FirebaseAuth.instance.currentUser!= null ? FirebaseAuth.instance.currentUser!.uid : "";
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(
    Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))
    )
);

Future get_data() async {
  var data_snapshot = await FirebaseFirestore.instance.collection("users").doc(await get_Uid()).get();
  if (data_snapshot.exists) {
    Map<String, dynamic>? data = data_snapshot.data();

    get_user_data = AppUser(
      uid: data!['uid'],
      name: data['name'],
      email: data['email'],
      Profile_pic: data['profile_pic'],
      isAdmin: data['isAdmin'],
      cart: data['cart'],
      address: data['address']
    );

    CART = get_user_data!.cart ?? await Add_Cart();
    ADDRESSES = get_user_data!.address ?? await Add_Address_Field();
  }
}
