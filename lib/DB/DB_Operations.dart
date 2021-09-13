import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/util/constants.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier{

  late FirebaseFirestore db;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? ordersSubscription;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? orders;

  DataProvider(){
    db= FirebaseFirestore.instance;
    fetchOrders();
  }

  fetchOrders(){
    ordersSubscription= ORDERS_COLLECTION.snapshots().listen((event) {
      // print("DATA: ${event.docs.first.data()}");
      orders=event.docs;
      notifyListeners();

    });
  }


  // // Map CART = {};
  // final DB = FirebaseFirestore.instance;
  //
  // ValueNotifier CART = ValueNotifier({});
  //
  // get_CART(){
  //   DB.collection("collectionPath").snapshots().listen((event) {
  //     notifyListeners();
  //   });
  // }
}