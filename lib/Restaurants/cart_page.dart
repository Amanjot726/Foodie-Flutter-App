import 'dart:async';
import 'dart:math';
import 'package:first_app/Model/Order_data.dart';
import 'package:first_app/Restaurants/Acknowledge.dart';
import 'package:first_app/Restaurants/Address_Page.dart';
import 'package:first_app/Restaurants/Payment_Modes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Razorpay-payment-page.dart';


double total = 0;
List Dishes=[];
double _grand_total = 0;
double Other_Taxes = double.parse((Random().nextDouble() * (100.0 - 20.0) + 20.0).toStringAsFixed(2));

class Cart_Page extends StatelessWidget {
  const Cart_Page({Key? key}) : super(key: key);


  fetch_Cart_Dishes() {
    // Stream is a Collection i.e. a List of QuerySnapshot
    // QuerySnapshot is our Document :)
    Stream<DocumentSnapshot<Map<String,dynamic>>> stream = USERS_COLLECTION.doc(get_Uid()).snapshots();
    return stream;
  }

  PlaceOrder() async {
    Order order = Order(
      Dishes: Dishes,
      Total_Amount: _grand_total,
      Payment_Icon: DEFAULT_PAYMENT_ICON,
      Payment_Mode: DEFAULT_PAYMENT_MODE,
      Address_Type: DELIVERY_ADDRESS_TYPE,
      Address: DELIVERY_ADDRESS,
    );
    var dataToSave = order.toMap();
    // Insert document containing data in Orders collection
    ORDERS_COLLECTION.doc().set(dataToSave);
  }

  ClearCART(){
    CART = {};
    Update_Cart();
  }

  NavigateToSuccess(context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Show_Acknowledgement(Title: "Payment Successful",Message: "Hooray! You have completed your payment.",Flag: true,),));
  }
  NavigateToFail(context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Show_Acknowledgement(Title: "Payment Unsuccessful",Message: "Sorry, this transaction can't be processed right now. Please try a different payment method or try again after sometime.",Flag: false,),));
  }


  @override
  Widget build(BuildContext context) {
    total = 0;
    DELIVERY_ADDRESS_TYPE = (ADDRESSES.isNotEmpty ? ADDRESSES[ADDRESSES.keys.toList()[0]]['Address Type'].toString() : "Please Select Address");
    DELIVERY_ADDRESS = (ADDRESSES.isNotEmpty ? ADDRESSES[ADDRESSES.keys.toList()[0]]['Address'].toString() : "");
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
        bottomNavigationBar: CART.isEmpty ?
        Row()
            :
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StatefulBuilder(
                builder: (context, setState) {
                  return Container(
                    color: Colors.green[50],
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("DELIVERING FOOD TO",
                                  style: TextStyle(
                                    fontSize: 15.3,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(198, 62, 62, 62),
                                    // color: Color.fromARGB(244, 99, 168, 73)
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 6,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Container(
                                //     padding: EdgeInsets.all(2),
                                //     decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(50),
                                //         color: Color.fromARGB(222, 42, 167, 47)
                                //     ),
                                //     child: Icon(
                                //       Icons.done_rounded,
                                //       color: Colors.white,
                                //       size: 13,
                                //     )
                                // ),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset("assets/Small_Done.png", height: 16, width: 16, fit: BoxFit.fill,)
                                ),
                                SizedBox(width: 6,),
                                Text(DELIVERY_ADDRESS_TYPE,
                                  style: TextStyle(
                                      fontSize: 14.5,
                                      color: Color.fromARGB(255, 62, 62, 62),
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Row(
                              children: [
                                TextButton(
                                    child: Text(ADDRESSES.isNotEmpty ? "CHANGE" : "SELECT",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.green,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    onPressed: () async {
                                      var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddressPage(Option: 1),));
                                      setState(() {
                                        DELIVERY_ADDRESS_TYPE = result[0];
                                        DELIVERY_ADDRESS = result[1];
                                      });
                                    }
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                child: Row(
                  children: [
                    StatefulBuilder(
                      builder: (context, setState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("PAYMENT MODE",
                              style: TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(183, 62, 62, 62),
                                // color: Color.fromARGB(244, 99, 168, 73)
                              ),
                            ),
                            InkWell(
                              highlightColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              overlayColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
                              splashColor: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30,
                                    child: Row(
                                      children: [
                                        Image.network(
                                          DEFAULT_PAYMENT_ICON,
                                          height: 21,
                                          width: 21,
                                          fit: BoxFit.fill,
                                        ),
                                        SizedBox(width: 4,),
                                        Text(
                                          DEFAULT_PAYMENT_MODE,
                                          style: TextStyle(
                                              fontSize: 15.5,
                                              color: Color.fromARGB(205, 42, 42, 42),
                                              fontWeight: FontWeight.bold
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 3,width: 100,),
                                  Text("CHANGE",
                                    style: TextStyle(
                                      fontSize: 14.5,
                                      color: Colors.transparent,
                                      decoration: TextDecoration.underline,
                                      decorationStyle: TextDecorationStyle.dashed,
                                      decorationColor: Colors.red[900]!,
                                      decorationThickness: 1.6,
                                      shadows: [
                                        Shadow(
                                            color: Colors.red[900]!,
                                            offset: Offset(0, -5))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () async {
                                var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => Payment_ModesPage(),));
                                setState(() {
                                  DEFAULT_PAYMENT_ICON = result[0];
                                  DEFAULT_PAYMENT_MODE = result[1]=="Cash On Delivery"?"Cash":result[1];
                                });
                              },
                            ),
                          ],
                        );
                      }
                    ),
                    Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(10),
                          splashColor: Color.fromARGB(57, 175, 236, 187),
                          overlayColor: MaterialStateProperty.resolveWith((states) => Color.fromARGB(79, 138, 231, 158),),
                          hoverColor: Color.fromARGB(81, 107, 186, 123),
                          highlightColor: Color.fromARGB(81, 107, 186, 123),
                          focusColor: Color.fromARGB(81, 107, 186, 123),
                          child: Ink(
                            width: 185,
                            height: 66,
                            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: <Color>[
                                      // Color.fromARGB(205, 34, 170, 61),
                                      Color.fromARGB(255, 74, 196, 132),
                                      // Color.fromARGB(255, 45, 206, 72),
                                      Color.fromARGB(255, 75, 184, 91),
                                    ],
                                    tileMode: TileMode.clamp
                                )
                            ),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Place Order",
                                      style: TextStyle(
                                          fontSize: 21,
                                          fontFamily: "Righteous",
                                          color: Colors.white
                                      ),
                                    ),
                                    SizedBox(height: 4,),
                                    Row(
                                      children: [
                                        Text("Your total is ₹",
                                          style: TextStyle(
                                              fontSize: 12.7,
                                              color: Colors.white
                                          ),
                                        ),
                                        StreamBuilder(
                                            stream: fetch_Cart_Dishes(),
                                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                                              if (snapshot.hasError) {
                                                return Center(
                                                    child: Text("0",
                                                      style: TextStyle(
                                                          fontSize: 12.7,
                                                          color: Colors.white
                                                      ),
                                                    )
                                                );
                                              }
                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                return Center(
                                                  child: CupertinoActivityIndicator(radius: 6.5,),
                                                );
                                              }
                                              var map = snapshot.data!;
                                              Map<String, dynamic> cart = map['cart']??{} as Map<String, dynamic>;
                                              double _total = 0;
                                              _grand_total = 0;
                                              snapshot.data!=null || cart.isNotEmpty && CART.isNotEmpty ?
                                              cart.keys.forEach((e) {
                                                _total += cart[e]['price']*cart[e]['quantity'];
                                              }) : "";
                                              _grand_total = _total + (_total!=0 ? Other_Taxes : 0);
                                              // grand_total = snapshot.data!=null || cart.isNotEmpty && CART.isNotEmpty ? get_total_price() : 0;
                                              return snapshot.data==null || cart.isEmpty && CART.isEmpty ?
                                              Text("0",
                                                style: TextStyle(
                                                    fontSize: 12.7,
                                                    color: Colors.white
                                                ),
                                              )
                                                  :
                                              Text(_grand_total.toStringAsFixed(2),
                                                style: TextStyle(
                                                    fontSize: 12.7,
                                                    color: Colors.white
                                                ),
                                              );
                                            }
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 4),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: Colors.white
                                      ),
                                      child: FaIcon(
                                        FontAwesomeIcons.arrowRight,
                                        color: Colors.green,
                                        size: 15,
                                      ),
                                      // Icon(
                                      //   Icons.arrow_forward_rounded,
                                      //   color: Colors.green,
                                      //   size: 20,
                                      // ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          onTap: ()async {
                            if(DEFAULT_PAYMENT_MODE.isNotEmpty && _grand_total>1){
                              // print("here = ${double.parse(_grand_total.toStringAsFixed(2))}");
                              // print("old = ${_grand_total}");
                              int result = await Navigator.push(context, MaterialPageRoute(builder: (context) => RazorPayPaymentPage(amount: double.parse(_grand_total.toStringAsFixed(2))),));
                              print("result: $result");
                              if(result == 1){
                                PlaceOrder();
                                ClearCART();
                                NavigateToSuccess(context);
                              }
                              if(result == 0){
                                NavigateToFail(context);
                              }
                            }
                          }
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
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
            total = 0;
            var map = snapshot.data!;
            Map<String, dynamic> cart = map['cart']??{} as Map<String, dynamic>;
            // print("data = "+snapshot.data.docs);
            snapshot.data!=null || cart.isNotEmpty && CART.isNotEmpty ? CART = cart : {};
            return snapshot.data==null || cart.isEmpty && CART.isEmpty ?
              Center(
                child: Text(
                  "No Dishes Found In Cart!!!",
                  style: TextStyle(color: Color.fromARGB(255, 238, 176, 39), fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
                :
              ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(16),
                children: [
                  SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      children: cart.keys.toList().map((e) {
                        // cart[e]['price']==null?get_data():"";
                        // print("CART = "+CART.toString()+"\n\n");
                        // print("\n\ncart = "+cart.toString());
                        Dishes.add(cart[e]);
                        total += cart[e]['price']*cart[e]['quantity'];
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
                                              height: 88,
                                              width: 105,
                                              // padding: EdgeInsets.only(bottom: 8),
                                              decoration: BoxDecoration(border: Border(right: BorderSide(color: Color.fromARGB(29, 0, 0, 0), style: BorderStyle.solid, width: 2))),
                                              child: Image.network(
                                                cart[e]["imageURL"],
                                                height: 88,
                                                width: 105,
                                                fit: BoxFit.fill,
                                                errorBuilder: (context, error, stackTrace) {
                                                  return ClipRRect(
                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(13.3), bottomLeft: Radius.circular(13.3)),
                                                    child: Container(
                                                        height: 88,
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
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 2.0),
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
                                                    height: 3,
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
                                                  RichText(
                                                    textAlign: TextAlign.start,
                                                    text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: "Total: ",
                                                            style: TextStyle(
                                                              fontSize: 11.2,
                                                              letterSpacing: 0.35,
                                                              fontFamily: "Roboto",
                                                              fontWeight: FontWeight.bold,
                                                              color: Color.fromARGB(107, 0, 0, 0),
                                                            ),
                                                          ),
                                                          // WidgetSpan(
                                                          //   alignment: PlaceholderAlignment.middle,
                                                          //   child: Icon(
                                                          //     Icons.close_rounded,
                                                          //     size: 13.5,
                                                          //     color: Color.fromARGB(112, 0, 0, 0),
                                                          //   ),
                                                          // ),
                                                          TextSpan(
                                                            text: cart[e]['price'].toString().replaceAll(".0", "")+"x"+cart[e]['quantity'].toString()+" = ₹"+((cart[e]['price'])*(cart[e]['quantity'])).toString(),
                                                            style: TextStyle(
                                                              fontSize: 10.1,
                                                              letterSpacing: 0.6,
                                                              fontFamily: "Roboto",
                                                              fontWeight: FontWeight.bold,
                                                              color: Color.fromARGB(112, 0, 0, 0),
                                                            ),
                                                          ),
                                                        ]
                                                    ),
                                                  ),
                                                  SizedBox(height: 3,),
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
                                                                    color: Color.fromARGB(255, 246, 246, 246),
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
                                                                    color: Color.fromARGB(255, 246, 246, 246),
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
                                    ),
                                    Spacer(),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Counter(dish_id: e,details: cart[e]),
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
                      }).toList()
                    ),
                  ),
                  CART.length>0 ?
                  Column(
                    children: [
                      Divider(thickness: 3,height: 0,color: Color.fromARGB(15, 0, 0, 0),),
                      Container(
                        padding: EdgeInsets.all(13),
                        // height: 400,
                        // width: 400,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(20, 222, 202, 130),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text("Items Total",
                                      style: TextStyle(
                                          color: Colors.black54
                                      ),
                                    )
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    Text("₹"+total.toString(),
                                      style: TextStyle(
                                          color: Colors.black45
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 14,),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text("Taxes & Restaurant charges",
                                      style: TextStyle(
                                        color: Colors.transparent,
                                        decoration: TextDecoration.underline,
                                        decorationStyle: TextDecorationStyle.dashed,
                                        decorationColor: Colors.black45,
                                        decorationThickness: 1.4,
                                        shadows: [
                                          Shadow(
                                              color: Colors.black45,
                                              offset: Offset(0, -5))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    Text("₹"+Other_Taxes.toString(),
                                      style: TextStyle(
                                          color: Colors.black54
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 15,),
                            Row(
                              children: [
                                Text("Grand Total",
                                  style: TextStyle(
                                      fontSize: 16.7
                                  ),
                                ),
                                Spacer(),
                                Text("₹"+(total+Other_Taxes).toStringAsFixed(2),
                                  style: TextStyle(
                                      fontSize: 16.7
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2,),
                          ],
                        ),
                      ),
                      SizedBox(height: 3,),
                      Divider(thickness: 3,height: 0,color: Color.fromARGB(15, 0, 0, 0),),
                    ],
                  ):Container(),
                ],
              );
          },
        )
    );
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


  // @override
  // void initState() {
  //   get_data();
  // }
  // int initialValue = CART[Dish_id] ?? 0;

  Increase_Quantity(){
    var dish=widget.dish_id;
    if (!CART.keys.toList().contains(dish)){             // if CART dictionary not contains current dish id
      widget.details!['quantity'] = 1;
      CART[dish] = widget.details;
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
