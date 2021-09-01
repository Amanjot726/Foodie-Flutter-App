import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/Restaurants/add_restaurants.dart';
import 'package:first_app/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key? key}) : super(key: key);

  Fetch_User_Addresses() {
    Stream<DocumentSnapshot<Map<String,dynamic>>> stream = USERS_COLLECTION.doc(get_Uid()).snapshots();
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
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, "/Address_Google_Map");
          },
          backgroundColor: PRIMARY_COLOR,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: StreamBuilder(
          stream: Fetch_User_Addresses(),
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
            var data = snapshot.data!;
            Map<String, dynamic> data_map = data.data()??{} as Map<String, dynamic>;
            Map? Addresses;
            if(data_map.containsKey("address")){
              Addresses = data_map['address']??{} as Map<String, dynamic>;
              // Show_Snackbar(context: context, message: "address fetch");
            }
            else{
              USERS_COLLECTION.doc(get_Uid()).set({'address': Map()},SetOptions(merge: true));
            }
            // print("data = "+snapshot.data.docs);
            return Addresses==null || Addresses.isEmpty ?
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No Addresses Found !!!",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color.fromARGB(255, 238, 176, 39),
                        fontSize: 16.5,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 8,),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Click ",
                            style: TextStyle(
                              color: Color.fromARGB(255, 238, 176, 39),
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(
                              Icons.add_circle_rounded,
                              size: 20,
                              color: Color.fromARGB(255, 238, 176, 39),
                            ),
                          ),
                          TextSpan(
                            text: " Button below to add New Address",
                            style: TextStyle(
                              color: Color.fromARGB(255, 238, 176, 39),
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
                :
              ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(16),
                children: Addresses.keys.toList().map<Widget>((e){
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 13),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        shape: BoxShape.rectangle,
                        // border: Border.all(color: Color.fromARGB(15, 0, 0, 0),width: 2),
                        border: Border.all(color: Color.fromARGB(23, 0, 0, 0), width: 2),
                      ),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(right: BorderSide(color: Color.fromARGB(10, 0, 0, 0), style: BorderStyle.solid, width: 2))
                                ),
                                width: 72,
                                height: 72,
                                child: Image.asset(
                                  "assets/map.png",
                                  width: 36,
                                )
                              ),
                            ],
                          ),
                          Flexible(
                            flex: 36,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Addresses![e]['Address Type'],
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.bold,
                                      // color: Color.fromARGB(154, 0, 0, 0),
                                      color: Color.fromARGB(176, 0, 0, 0),
                                    ),
                                  ),
                                  SizedBox(height: 4,),
                                  Text(
                                    Addresses[e]['Address'],
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Roboto",
                                      // color: Color.fromARGB(154, 0, 0, 0),
                                      color: Color.fromARGB(176, 0, 0, 0),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(7),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Icon(
                                      Icons.delete_forever_rounded,
                                      color: Colors.red[700],
                                    ),
                                  ),
                                  onTap: ()async{
                                    ADDRESSES.remove(e.toString());
                                    var result = await Update_Address();
                                    // Show_Snackbar(context: context,message: ADDRESSES.toString());
                                  },
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  );
                }).toList()
            );
          }
        )
    );
  }
}
