import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Orders_Page extends StatelessWidget {
  const Orders_Page({Key? key}) : super(key: key);

  fetch_Orders() {
    // Stream is a Collection i.e. a List of QuerySnapshot
    // QuerySnapshot is our Document :)
    Stream<QuerySnapshot<Map<String,dynamic>>> stream = ORDERS_COLLECTION.snapshots();
    return stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        actionsIconTheme: IconThemeData(color: Colors.black),
        title: Row(
          children: [
            Image.asset("assets/Restaurants_small.png",width: 36,),
            SizedBox(width: 6,),
            Text("ORDERS",
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
        stream: fetch_Orders(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasError){
            return Center(
              child: Text("SOMETHING WENT WRONG!!!", style: TextStyle(color: Colors.red[200]),),
            );
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(20, 14, 20, 20),
            // shrinkWrap: true,
            // scrollDirection: Axis.vertical,
            // physics: ClampingScrollPhysics(),
            children: snapshot.data!.docs.map<Widget>((DocumentSnapshot document){
              bool more_info = false;
              Map<String, dynamic> map = document.data()! as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    shape: BoxShape.rectangle,
                    // border: Border.all(color: Color.fromARGB(15, 0, 0, 0),width: 2),
                    border: Border.all(color: Color.fromARGB(17, 0, 0, 0),width: 2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return Column(
                          children: [
                            Stack(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Order",
                                      style: TextStyle(
                                        fontSize: 19.5,
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[700]
                                      ),
                                    ),
                                  ),
                                ),
                                // Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 2),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Container(
                                        height: 24,
                                        width: 24,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(17, 0, 0, 0),
                                          borderRadius: BorderRadius.circular(50)
                                        ),
                                        child: Icon(
                                            more_info ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down_rounded,
                                          size: 24,
                                        ),
                                      ),
                                      onTap: () {
                                        setState((){
                                          more_info = more_info ? false : true;
                                        });
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Divider(),
                            SizedBox(height: 6,),
                            Row(
                              children: [
                                Text("Order ID: ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold,

                                  ),
                                ),
                                Text(map["Order_Id"].toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    // letterSpacing: 1,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 6,),
                            Row(
                              children: [
                                Text("Restaurant & Other Taxes: ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold,

                                  ),
                                ),
                                Text(map["Order_Id"].toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    // letterSpacing: 1,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 6,),
                            Row(
                              children: [
                                Text("Total Amount: ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold,

                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  // height: 15.3,
                                  // width: 15.3,
                                  margin: EdgeInsets.only(right: 3),
                                  padding: EdgeInsets.symmetric(horizontal: 4.3, vertical: 0.6),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: Text(
                                    "₹", textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 13.3,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                                Text(map["Total_Amount"].toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    // letterSpacing: 1,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 6,),
                            Row(
                              children: [
                                Text("Payment Mode: ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold,

                                  ),
                                ),
                                Image.network(
                                  map["Payment_Icon"],
                                  height: 20,
                                  width: 20,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container();
                                  },
                                  loadingBuilder: (context, child, loadingProgress) {
                                    return loadingProgress == null ? child : CupertinoActivityIndicator();
                                  },
                                ),
                                SizedBox(width: 3,),
                                Text(map["Payment_Mode"].toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    // letterSpacing: 1,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 6,),
                            more_info==false ?
                              Row(
                                children: [
                                  Text(map["Dishes"].length==1 ? "Item: " : "Items: ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    map["Dishes"].map((e) => e["name"]).join(", ").toString(),
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontSize: 14,
                                      // letterSpacing: 1,
                                    ),
                                  )
                                ],
                              )
                              :
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Items: ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  ...map["Dishes"].map<Widget>((e) {
                                    return Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: SizedBox(
                                        height: 35,
                                        child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(8),
                                                  child: Container(
                                                    height: 35,
                                                    width: 40,
                                                    decoration:BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8),
                                                        color: Color.fromARGB(13, 0, 0, 0)
                                                    ),
                                                    child: Image.network(
                                                      e['imageURL'],
                                                      height: 35,
                                                      width: 40,
                                                      fit: BoxFit.fill,
                                                      errorBuilder: (context, error, stackTrace) {
                                                        return Container(
                                                          height: 35,
                                                          width: 40,
                                                          decoration:BoxDecoration(
                                                            borderRadius: BorderRadius.circular(8),
                                                              color: Color.fromARGB(13, 0, 0, 0)
                                                          ),
                                                          child: Icon(
                                                            Icons.image_not_supported
                                                          ),
                                                        );
                                                      },
                                                      loadingBuilder: (context, child, loadingProgress) {
                                                        return loadingProgress == null ?
                                                        child
                                                            :
                                                        CupertinoActivityIndicator(radius: 7,);
                                                      },
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            // SizedBox(width: 10,),
                                            VerticalDivider(thickness: 1,endIndent: 5,indent: 5,width: 20,),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 40,
                                                        child: Text(
                                                          e['name'],
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            letterSpacing: 1,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        " (₹"+e['price'].toString()+'x'+e['quantity'].toString()+')',
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          letterSpacing: 1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            VerticalDivider(thickness: 1,endIndent: 5,indent: 5,width: 20,),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "₹"+((e['price'])*(e['quantity'] as int)).toString(),
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList()
                                ]
                              ),
                            Divider(),
                            SizedBox(height: 3,),
                            Row(
                              children: [
                                Text("Deliver to: ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold,

                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    map["Address_Type"] + " (" + map["Address"],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 14,
                                      // letterSpacing: 1,
                                    ),
                                  ),
                                ),
                                Text(
                                  ")  ",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 14,
                                    // letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                    ),
                  ),
                ),
              );
            }
          ).toList()
          );
        },
      ),
    );
  }
}
