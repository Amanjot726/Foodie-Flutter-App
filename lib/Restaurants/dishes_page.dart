import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/Restaurants/add_dishes.dart';
import 'package:first_app/Restaurants/add_restaurants.dart';
import 'package:first_app/util/constants.dart';
import 'package:flutter/material.dart';

var _initial_value = 0;

class Show_Snackbar{
  String message;
  BuildContext context;
  Duration? duration;
  Show_Snackbar({required this.context,required this.message, this.duration}){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(this.message.toString()),
      duration: duration==null?Duration(seconds: 4):duration!,
    )
    );
  }
}


class Dishes_Page extends StatefulWidget {
  String restaurantId;
  String restaurantName;

  Dishes_Page({Key? key, required this.restaurantId, required this.restaurantName}) : super(key: key);

  @override
  _Dishes_PageState createState() => _Dishes_PageState();
}

class _Dishes_PageState extends State<Dishes_Page> {
  @override
  fetchDishes() {
    // Stream is a Collection i.e. a List of QuerySnapshot
    // QuerySnapshot is our Document :)
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection("Restaurants").doc(widget.restaurantId).collection("Dishes").snapshots();
    return stream;
  }

  Color PRIMARY_COLOR = Colors.green;

  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color.fromARGB(235, 220, 245, 234),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          actionsIconTheme: IconThemeData(color: Colors.black),
          backgroundColor: PRIMARY_COLOR,
          title: Text(
            "Dishes",
            style: TextStyle(color: Color.fromARGB(185, 0, 0, 0), fontFamily: 'AlfaSlabOne', letterSpacing: 1.4),
          ),
          actions: [
            (get_user_data==null)? Container() :
            (get_user_data!.isAdmin != true) ? Container() :
            IconButton(
              icon: Icon(Icons.add_circle_rounded, color: Color.fromARGB(185, 0, 0, 0)),
              tooltip: "Add Dishes to " + widget.restaurantName,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Add_dishes(restaurantId: widget.restaurantId, restaurantName: widget.restaurantName)));
              },
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart_rounded,color: Color.fromARGB(185, 0, 0, 0)),
              tooltip: "Cart",
              onPressed: (){
                Navigator.pushNamed(context, "/cart");
              },
            ),
          ],
        ),
        body: StreamBuilder(
          stream: fetchDishes(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "SOMETHING WENT WRONG!!!",
                  style: TextStyle(color: Colors.red[200]),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            // print("data = "+snapshot.data.docs);
            return snapshot.data.docs.isEmpty
                ? Center(
                    child: Text(
                      "No Dishes Found !!!",
                      style: TextStyle(color: Color.fromARGB(255, 238, 176, 39), fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )
                : ListView(
                physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(20),
                    children: snapshot.data!.docs.map<Widget>((DocumentSnapshot document) {
                      Map<String, dynamic> map = document.data()! as Map<String, dynamic>;
                      snapshot.data!=null || map.isNotEmpty && CART.isNotEmpty ? CART = map['quantity'] = CART : "";
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            shape: BoxShape.rectangle,
                            // border: Border.all(color: Color.fromARGB(15, 0, 0, 0),width: 2),
                            border: Border.all(color: Color.fromARGB(17, 0, 0, 0), width: 2),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(18.4),
                            child: Column(
                              children: [
                                (map["imageURL"] != null || map["imageURL"] != "")
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(18.5), topRight: Radius.circular(18.5)),
                                        child: Container(
                                          height: 200,
                                          width: 350,
                                          // padding: EdgeInsets.only(bottom: 8),
                                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(24, 0, 0, 0), style: BorderStyle.solid, width: 2))),
                                          child: Image.network(
                                            map["imageURL"],
                                            height: 200,
                                            width: 350,
                                            fit: BoxFit.fill,
                                            errorBuilder: (context, error, stackTrace) {
                                              return ClipRRect(
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(18.4), topRight: Radius.circular(18.4)),
                                                child: Container(
                                                    height: 200,
                                                    width: 350,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(17, 0, 0, 0),
                                                      // border: Border(bottom: BorderSide(color: Color.fromARGB(10, 0, 0, 0),style: BorderStyle.solid,width: 2))
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Icon(Icons.image_not_supported_outlined),
                                                        Text("No Image Available..."),
                                                      ],
                                                    )),
                                              );
                                            },
                                            loadingBuilder: (context, child, loadingProgress) {
                                              return loadingProgress == null ? child : Center(child: CircularProgressIndicator());
                                            },
                                          ),
                                        ))
                                    : ClipRRect(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(18.4), topRight: Radius.circular(18.4)),
                                        child: Container(
                                            height: 200,
                                            width: 350,
                                            decoration: BoxDecoration(color: Colors.black12, border: Border(bottom: BorderSide(color: Color.fromARGB(10, 0, 0, 0), style: BorderStyle.solid, width: 2))),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(Icons.image_not_supported_outlined),
                                                Text("No Image Found..."),
                                              ],
                                            )),
                                      ),
                                Container(
                                  padding: EdgeInsets.all(13),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context).size.width/1.89,
                                                child: Text(
                                                  map['name'],
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: "Roboto",
                                                    fontWeight: FontWeight.bold,
                                                    // color: Color.fromARGB(154, 0, 0, 0),
                                                    color: Color.fromARGB(176, 0, 0, 0),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: [
                                              Text("Price: ",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  letterSpacing: 0.35,
                                                  fontFamily: "Roboto",
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(107, 0, 0, 0),
                                                ),
                                              ),
                                              Text(
                                                "₹"+map['price'].toString(),
                                                style: TextStyle(
                                                  fontSize: 12.5,
                                                  letterSpacing: 0.35,
                                                  fontFamily: "Roboto",
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(112, 0, 0, 0),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 6,),
                                          Container(
                                            padding: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Color.fromARGB(222, 35, 146, 40)
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Text(
                                                  map['ratings'].toString(),
                                                  style: TextStyle(
                                                    fontSize: 13.5,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(255, 236, 236, 236),
                                                  ),
                                                ),
                                                // SizedBox(
                                                //   width: 2,
                                                // ),
                                                Icon(
                                                  Icons.star_rate_rounded,
                                                  size: 13,
                                                  color: Color.fromARGB(255, 236, 236, 236),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Counter(dish_id: document.id,details: map)
                                        ],
                                      )
                                    ],
                                  ),
                                ),

                                // ListTile(contentPadding: EdgeInsets.only(left: 14,right: 14,bottom: 5),
                                //   title: Text(
                                //     map['name'],
                                //     style: TextStyle(
                                //       fontSize: 18,
                                //       fontWeight: FontWeight.bold,
                                //       color: Color.fromARGB(154, 0, 0, 0),
                                //     ),
                                //   ),
                                //   subtitle: Text(
                                //     "Price: "+map['price'].toString(),
                                //     style: TextStyle(
                                //       fontSize: 13,
                                //       fontWeight: FontWeight.bold,
                                //       color: Color.fromARGB(122, 0, 0, 0),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                      );
                    }).toList());
          },
        ));
  }
}

class Counter extends StatefulWidget {
  String? dish_id;
  Map? details;
  Counter({Key? key, this.dish_id, this.details}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {

  Timer? timer;


  // int initialValue = CART[Dish_id] ?? 0;

  Increase_Quantity(){
    if (!CART.keys.toList().contains(widget.dish_id)){
      widget.details!['quantity'] = 1;
      CART[widget.dish_id] = widget.details;
    }
    else{
      if(CART[widget.dish_id]['quantity']!=null){
        CART[widget.dish_id]['quantity']++;
      }
      else{
        widget.details!['quantity'] = 1;
        CART[widget.dish_id] = widget.details;
      }
    }
  }

  Decrease_Quantity(){
    if (CART[widget.dish_id]['quantity'] <= 1) {
      CART[widget.dish_id]['quantity'] = 0;
      if (CART.keys.toList().contains(widget.dish_id)){
        CART.remove(widget.dish_id);
      }
    }
    else {
      if (CART.keys.toList().contains(widget.dish_id)){
        if(CART[widget.dish_id]['quantity']!=null || CART[widget.dish_id]['quantity']!=1){
          CART[widget.dish_id]['quantity']--;
        }
        else{
          CART[widget.dish_id]['quantity'] = 0;
        }
      }
      // Show_Snackbar(context: context, message: CART.toString(),duration: Duration(milliseconds: 700));
    }
  }

  fetch_Dish_count() {
    // Stream is a Collection i.e. a List of QuerySnapshot
    // QuerySnapshot is our Document :)
    Stream<DocumentSnapshot<Map<String,dynamic>>> stream = USERS_COLLECTION.doc(get_Uid()).snapshots();
    return stream;
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: fetch_Dish_count(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // if (snapshot.hasError) {
          //   return Center(
          //     child: Text(
          //       "SOMETHING WENT WRONG!!!",
          //       style: TextStyle(color: Colors.red[200]),
          //     ),
          //   );
          // }
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Center(
          //     // child: CircularProgressIndicator(),
          //   );
          // }
          // // print("data = "+snapshot.data.docs);
          // var map = snapshot.data!;
          // Map<String, dynamic> cart = map['cart']??{} as Map<String, dynamic>;
          // // print("data = "+snapshot.data.docs);
          // snapshot.data!=null || cart.isNotEmpty && CART.isNotEmpty ? CART = cart : "";
          // (CART[widget.dish_id] != null || CART[widget.dish_id] != 0 || CART[widget.dish_id]['quantity'] != null || CART[widget.dish_id]['quantity'] != 0) ? CART = data_map : "";
          // Map? Addresses;
        return Container(
          decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.black)),
          child: (CART[widget.dish_id] == null || CART[widget.dish_id] == 0 || CART[widget.dish_id]['quantity'] == null || CART[widget.dish_id]['quantity'] == 0) ?
            Tooltip(
              message: "Quantity: Add More",
              child: Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    splashColor: Colors.green[100],
                    overlayColor: MaterialStateProperty.resolveWith((states) =>  Colors.green[100]),
                    hoverColor:  Colors.green[100],
                    focusColor:  Colors.green[100],
                    highlightColor:  Colors.green[100],
                    child: Container(
                      width: MediaQuery.of(context).size.width/4,
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      child: Text("Add",textAlign: TextAlign.center,style: TextStyle(fontSize: 15.5),),
                    ),
                    onTap: (){
                      setState(() {
                        Increase_Quantity();
                        Update_Cart();
                      });
                    },
                  )
                ],
              ),
            )
          :
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width/4,
              child: Row(
                children: [
                  GestureDetector(
                    child: InkWell(
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                      splashColor: Colors.green[100],
                      overlayColor: MaterialStateProperty.resolveWith((states) =>  Colors.green[100]),
                      hoverColor:  Colors.green[100],
                      focusColor:  Colors.green[100],
                      highlightColor:  Colors.green[100],
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 9),
                        width: ((MediaQuery.of(context).size.width/4)/2)-12,
                        child: Icon(Icons.add,size: 18,),
                      ),
                      onTap: (){
                        setState(() {
                         Increase_Quantity();
                         Update_Cart();
                        });
                      },
                    ),
                    onTapDown: (TapDownDetails details) {
                      timer = Timer.periodic(Duration(milliseconds: 200), (t) {
                        setState(() {
                          CART[widget.dish_id]['quantity']++;
                        });
                      });
                      Update_Cart();
                    },
                    onTapUp: (TapUpDetails details) {Update_Cart();timer!.cancel();},
                    onTapCancel: () {Update_Cart();timer!.cancel();},
                  ),
                  Spacer(),
                  Tooltip(
                    message: "Quantity: "+(CART[widget.dish_id]['quantity']??0).toString(),
                    child: SizedBox(
                      width: 24,
                      height: 35,
                      child: InkWell(
                        splashFactory: NoSplash.splashFactory,
                        enableFeedback: false,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            CART[widget.dish_id]!=null?
                            (CART[widget.dish_id]['quantity']??0).toString():"0",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 15.5,),
                          )
                        ),
                        onTap: (){},
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    child: InkWell(
                      borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
                      splashColor: Colors.green[100],
                      overlayColor: MaterialStateProperty.resolveWith((states) =>  Colors.green[100]),
                      hoverColor:  Colors.green[100],
                      focusColor:  Colors.green[100],
                      highlightColor:  Colors.green[100],
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 9),
                        width: ((MediaQuery.of(context).size.width/4)/2)-12,
                        child: Icon(Icons.remove,size: 18,),
                      ),
                      onTap: (){
                        setState(() {
                          Decrease_Quantity();
                          Update_Cart();
                        });
                      },
                    ),
                    onTapDown: (TapDownDetails details) {
                      timer = Timer.periodic(Duration(milliseconds: 200), (t) {
                        setState(() {
                              CART[widget.dish_id]['quantity']--;
                        });
                      });
                      Update_Cart();
                    },
                    onTapUp: (TapUpDetails details) {Update_Cart();timer!.cancel();},
                    onTapCancel: () {Update_Cart();timer!.cancel();},
                  )
                ],
              ),
            ),
          ],
        )
        );
      }
    );
  }
}
