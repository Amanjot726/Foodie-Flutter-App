import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Cart_Page extends StatelessWidget {
  const Cart_Page({Key? key}) : super(key: key);

  fetch_Cart_Dishes() {
    // Stream is a Collection i.e. a List of QuerySnapshot
    // QuerySnapshot is our Document :)
    Stream<DocumentSnapshot<Map<String,dynamic>>> stream = USERS_COLLECTION.doc(get_Uid()).snapshots();
    return stream;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(235, 220, 245, 234),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          actionsIconTheme: IconThemeData(color: Colors.black),
          title: Row(
            children: [
              Image.asset("assets/Restaurants_small.png",width: 36,),
              SizedBox(width: 6,),
              Text("CART",
                style: TextStyle(
                    color: Color.fromARGB(185, 0, 0, 0),
                    fontFamily: 'AlfaSlabOne',
                    letterSpacing: 1.4
                ),
              ),
            ],
          ),
          backgroundColor: PRIMARY_COLOR,
        ),
        body: StreamBuilder(
          stream: fetch_Cart_Dishes(),
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
            var map = snapshot.data!;
            Map<String, dynamic> cart = map['cart']??{} as Map<String, dynamic>;
            // print("data = "+snapshot.data.docs);
            return snapshot.data==null
                ? Center(
              child: Text(
                "No Dishes Found In Cart!!!",
                style: TextStyle(color: Color.fromARGB(255, 238, 176, 39), fontSize: 16, fontWeight: FontWeight.bold),
              ),
            )
                : ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(16),
                children: cart.keys.toList().map((e) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 13),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        shape: BoxShape.rectangle,
                        // border: Border.all(color: Color.fromARGB(15, 0, 0, 0),width: 2),
                        border: Border.all(color: Color.fromARGB(23, 0, 0, 0), width: 2),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(13.3),
                        child:
                            Row(
                              children: [
                                Column(
                                  children: [
                                    (cart[e]["imageURL"] != null)
                                        ? ClipRRect(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(13.3), bottomLeft: Radius.circular(13.3)),
                                        child: Container(
                                          height: 85,
                                          width: 105,
                                          // padding: EdgeInsets.only(bottom: 8),
                                          decoration: BoxDecoration(border: Border(right: BorderSide(color: Color.fromARGB(29, 0, 0, 0), style: BorderStyle.solid, width: 2))),
                                          child: Image.network(
                                            cart[e]["imageURL"],
                                            height: 85,
                                            width: 105,
                                            fit: BoxFit.fill,
                                            errorBuilder: (context, error, stackTrace) {
                                              return ClipRRect(
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(13.3), bottomLeft: Radius.circular(13.3)),
                                                child: Container(
                                                    height: 85,
                                                    width: 105,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(17, 0, 0, 0),
                                                      // border: Border(right: BorderSide(color: Color.fromARGB(10, 0, 0, 0),style: BorderStyle.solid,width: 2))
                                                    ),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Icon(Icons.image_not_supported_outlined),
                                                        Container(
                                                          padding: EdgeInsets.only(left: 3),
                                                          width: 60,
                                                          child: Text("No Image Available...",maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: TextStyle(
                                                              fontSize: 13
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                ),
                                              );
                                            },
                                            loadingBuilder: (context, child, loadingProgress) {
                                              return loadingProgress == null ? child : Center(child: CircularProgressIndicator());
                                            },
                                          ),
                                        ))
                                        : ClipRRect(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(13.3), bottomLeft: Radius.circular(13.3)),
                                      child: Container(
                                          height: 85,
                                          width: 105,
                                          decoration: BoxDecoration(color: Colors.black12, border: Border(right: BorderSide(color: Color.fromARGB(10, 0, 0, 0), style: BorderStyle.solid, width: 2))),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.image_not_supported_outlined),
                                              Container(
                                                padding: EdgeInsets.only(left: 3),
                                                width: 60,
                                                child: Text("No Image Available...",maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 13
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 6,),
                                Expanded(
                                  flex: 15,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cart[e]['name']??"",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.bold,
                                                // color: Color.fromARGB(154, 0, 0, 0),
                                                color: Color.fromARGB(176, 0, 0, 0),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              children: [
                                                Text("Price: ",
                                                  style: TextStyle(
                                                    fontSize: 12.9,
                                                    letterSpacing: 0.35,
                                                    fontFamily: "Roboto",
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(107, 0, 0, 0),
                                                  ),
                                                ),
                                                Text(
                                                  "₹"+cart[e]['price'].toString(),
                                                  style: TextStyle(
                                                    fontSize: 12.2,
                                                    letterSpacing: 0.4,
                                                    fontFamily: "Roboto",
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(112, 0, 0, 0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 6,),
                                            Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.fromLTRB(3, 2, 3, 3),
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
                                                            cart[e]['ratings'].toString(),
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.bold,
                                                              color: Color.fromARGB(255, 236, 236, 236),
                                                            ),
                                                          ),
                                                          // SizedBox(
                                                          //   width: 2,
                                                          // ),
                                                          Container(
                                                            margin: EdgeInsets.only(bottom: 1),
                                                            child: Icon(
                                                              Icons.star_rate_rounded,
                                                              size: 11.5,
                                                              color: Color.fromARGB(255, 236, 236, 236),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Counter(dish_id: e,details: cart),
                                        SizedBox(width: 8,)
                                      ],
                                    ),
                                  ],
                                ),
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
    if (!CART.keys.toList().contains(widget.dish_id)){             // if CART dictionary not contains current dish id
      widget.details!['quantity'] = 1;
      CART[widget.dish_id] = widget.details;
    }
    else{                                                                     // if CART dictionary contains current dish id
      CART[widget.dish_id]['quantity']++;
      // CART.update(widget.dish_id.toString(), (value) => CART[widget.dish_id.toString()]);
    }
    // }
    // Show_Snackbar(context: context, message: CART.toString(),duration: Duration(milliseconds: 700));
  }

  Decrease_Quantity(){
    if (CART[widget.dish_id]['quantity'] <= 1) {
      CART[widget.dish_id]['quantity'] = 0;
      if (CART.keys.toList().contains(widget.dish_id)){            // if CART dictionary contains current dish id
        CART.remove(widget.dish_id);
      }
      // Show_Snackbar(context: context, message: CART.toString(),duration: Duration(milliseconds: 700));

    }
    else {
      if (!CART.keys.toList().contains(widget.dish_id.toString())){           // if CART dictionary not contains current dish id
        CART[widget.dish_id]['quantity'] = 0;
      }
      else{     // if CART dictionary contains current dish id
        CART[widget.dish_id]['quantity']--;
        // CART.update(widget.dish_id.toString(), (value) => CART[widget.dish_id]['quantity']);
      }
      // Show_Snackbar(context: context, message: CART.toString(),duration: Duration(milliseconds: 700));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10), border: Border.all(color: Color.fromARGB(188, 36, 36, 36),)),
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
                        child: Icon(Icons.add,size: 18,color: Color.fromARGB(188, 36, 36, 36),),
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
                            (CART[widget.dish_id]['quantity']??0).toString(),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 15.5,color: Color.fromARGB(188, 36, 36, 36),),
                          ),
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
                        child: Icon(Icons.remove,size: 18,color: Color.fromARGB(188, 36, 36, 36),),
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
                          if (CART[widget.dish_id.toString()]['quantity'] <= 1) {
                            Decrease_Quantity();
                            timer!.cancel();
                          }
                          else{
                            if(CART.containsKey(widget.dish_id.toString())){
                              CART[widget.dish_id]['quantity']--;
                            }
                          }
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
}
