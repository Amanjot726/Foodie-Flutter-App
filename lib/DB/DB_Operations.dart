import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier{

  // Map CART = {};
  final DB = FirebaseFirestore.instance;

  ValueNotifier CART = ValueNotifier({});

  get_CART(){
    DB.collection("collectionPath").snapshots().listen((event) {notifyListeners();});
  }
}