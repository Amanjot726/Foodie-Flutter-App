import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/Restaurants/add_dishes.dart';
import 'package:flutter/material.dart';


class Select_Restaurant extends StatefulWidget {
  const Select_Restaurant({Key? key}) : super(key: key);

  @override
  _Select_RestaurantState createState() => _Select_RestaurantState();
}

class _Select_RestaurantState extends State<Select_Restaurant> {

  Color PRIMARY_COLOR = Colors.green;

  var navigation_List = [
    "/Restaurant_home",
    "/profile"
  ];

  fetchRestaurants(){
    // Stream is a Collection i.e. a List of QuerySnapshot
    // QuerySnapshot is our Document :)
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection("Restaurants").snapshots();
    return stream;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(235, 220, 245, 234),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          actionsIconTheme: IconThemeData(color: Colors.black),
          title: Text("Select Restaurant",
            style: TextStyle(
                color: Color.fromARGB(185, 0, 0, 0),
                fontFamily: 'AlfaSlabOne',
                letterSpacing: 1.4
            ),
          ),
          backgroundColor: PRIMARY_COLOR,
        ),
        body: StreamBuilder(
          stream: fetchRestaurants(),
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
                padding: EdgeInsets.all(20),
                children: snapshot.data!.docs.map<Widget>((DocumentSnapshot document){
                  Map<String, dynamic> map = document.data()! as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.rectangle,
                        // border: Border.all(color: Color.fromARGB(15, 0, 0, 0),width: 2),
                        border: Border.all(color: Color.fromARGB(17, 0, 0, 0),width: 2),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),
                        child: Column(
                          children: [
                            map["url"] != null ?
                            ClipRRect(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(18.5),topRight: Radius.circular(18.5)),
                                child:Container(
                                  // padding: EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Color.fromARGB(24, 0, 0, 0),style: BorderStyle.solid,width: 2))
                                  ),
                                  child: Container(
                                    height: 200,
                                    width: 350,
                                    child: Image.network(
                                      map["url"],
                                      height: 200,
                                      width: 350,
                                      fit: BoxFit.fill,
                                      loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress.expectedTotalBytes != null ?
                                            loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                      errorBuilder: (context, error, stackTrace) {
                                        return ClipRRect(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(18.1),topRight: Radius.circular(18.1)),
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
                                                  Text("No Image Available..."),],
                                              )
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                            )
                                :
                            ClipRRect(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(18.1),topRight: Radius.circular(18.1)),
                              child: Container(
                                  height: 200,
                                  width: 350,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(17, 0, 0, 0),
                                      border: Border(bottom: BorderSide(color: Color.fromARGB(10, 0, 0, 0),style: BorderStyle.solid,width: 2))
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.image_not_supported_outlined),
                                      Text("No Image Available..."),],
                                  )
                              ),
                            ),


                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 13, vertical: 16),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width/1.65,
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
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width/1.65,
                                            child: Text(
                                              map['category'].toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 12.7,
                                                fontFamily: "Courgette",
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(107, 0, 0, 0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  InkWell(
                                    splashFactory: NoSplash.splashFactory,
                                    enableFeedback: false,
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: (){},
                                    child: Tooltip(
                                      message: "Ratings",
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(7),
                                                // color: Color.fromARGB(222, 40, 158, 45)
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
                                                    fontSize: 15.5,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(255, 250, 250, 250),
                                                  ),
                                                ),
                                                // SizedBox(
                                                //   width: 2,
                                                // ),
                                                Icon(
                                                  Icons.star_rate_rounded,
                                                  size: 14,
                                                  color: Color.fromARGB(255, 250, 250, 250),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 8,),
                                          Container(
                                            child: Text("₹"+map['price'].toString()+" for one",
                                              style: TextStyle(
                                                fontSize: 12.5,
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(107, 0, 0, 0),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // ListTile(
                            //   contentPadding: EdgeInsets.only(left: 14,right: 14,bottom: 5),
                            //   title: Text(
                            //     map['name'],
                            //     style: TextStyle(
                            //       fontSize: 18,
                            //       fontWeight: FontWeight.bold,
                            //       color: Color.fromARGB(154, 0, 0, 0),
                            //     ),
                            //   ),
                            //   subtitle: Text(
                            //     map['category'],
                            //     style: TextStyle(
                            //       fontSize: 13,
                            //       fontWeight: FontWeight.bold,
                            //       color: Color.fromARGB(122, 0, 0, 0),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Add_dishes(restaurantId: document.id,restaurantName: map['name'])));
                        },
                      ),
                    ),
                  );
                }).toList()
            );
          },
        )
    );
  }
}

