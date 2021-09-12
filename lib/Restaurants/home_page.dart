import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/Restaurants/add_restaurants.dart';
import 'package:first_app/Restaurants/dishes_page.dart';
import 'package:first_app/util/constants.dart';
import 'package:flutter/material.dart';



List chip_indexs = [0,];

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


class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override

  var index = 0;

  var navigation_List = [
    "/Restaurant_home",
    "/profile"
  ];

  fetchRestaurants(){
    // Stream is a Collection i.e. a List of QuerySnapshot
    // QuerySnapshot is our Document :)
    Stream<QuerySnapshot>? stream;
    if (chip_indexs.length==1 && chip_indexs.contains(0)){
      Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection("Restaurants").snapshots();
    }
    else{
      Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection("Restaurants").where("Tags",arrayContainsAny: [...chip_indexs.map((e) => Tags[e])]).snapshots();
    }
    return stream;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(235, 220, 245, 234),
      appBar: AppBar(
        elevation: 2,
        iconTheme: IconThemeData(color: Colors.black),
        actionsIconTheme: IconThemeData(color: Colors.black),
        title: Row(
          children: [
            Image.asset("assets/Restaurants_small.png",width: 36,),
            SizedBox(width: 6,),
            Text(APP_NAME,
              style: TextStyle(
                  color: Color.fromARGB(185, 0, 0, 0),
                  fontFamily: 'AlfaSlabOne',
                  letterSpacing: 1.4
              ),
            ),
          ],
        ),
        backgroundColor: PRIMARY_COLOR,
        actions: [
          (get_user_data==null)? Container() :
          (get_user_data!.isAdmin != true) ? Container() :
          IconButton(
            icon: Icon(Icons.add_circle_rounded,color: Color.fromARGB(185, 0, 0, 0)),
            tooltip: "Add Restaurants",
            onPressed: (){
              Navigator.pushNamed(context, "/add_restaurant");
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart_rounded,color: Color.fromARGB(185, 0, 0, 0)),
            tooltip: "Cart",
            onPressed: (){
              Navigator.pushNamed(context, "/cart");
            },
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert,color: Color.fromARGB(185, 0, 0, 0)),
            onSelected: (value) {
              value!=index?Navigator.pushReplacementNamed(context, navigation_List[value as int]): "";
            },
            itemBuilder: (context)=>[
              PopupMenuItem(
                child: Text("Home"),
                value: 0,
              ),
              PopupMenuItem(
                child: Text("Profile"),
                value: 1,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color.fromARGB(37, 0, 0, 0),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: BottomNavigationBar(
            backgroundColor: Color.fromARGB(255, 246, 246, 246),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: "Home"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person_rounded),
                  label: "Profile"
              ),

            ],
            currentIndex: index,
            selectedFontSize: 12,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            selectedItemColor: PRIMARY_COLOR,
            onTap: (idx) {
              index!=idx ? Navigator.pushReplacementNamed(context, navigation_List[idx]) :
              index = idx;
            }
        ),
      ),
      body: StreamBuilder(
        initialData: FirebaseFirestore.instance.collection("Restaurants").snapshots(),
        stream: (chip_indexs.length==1 && chip_indexs.contains(0)) ? FirebaseFirestore.instance.collection("Restaurants").snapshots() : FirebaseFirestore.instance.collection("Restaurants").where("Tags",arrayContainsAny: [...chip_indexs.map((e) => Tags[e])]).snapshots(),
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
          return Column(
              // shrinkWrap: true,
              // scrollDirection: Axis.vertical,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(4, 6, 4, 6),
                    height: 55,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 248, 248, 248),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(25, 0, 0, 0),
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                          offset: Offset(
                            0.0,
                            5.0,
                          ),
                        ),
                      ]
                    ),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      // shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      // padding: EdgeInsets.only(right: 4),
                      // physics: ClampingScrollPhysics(),
                      children: [
                        ...Tags.map((e) {
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: FilterChip(
                              // shape: SelectedBorder(),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: BorderSide(
                                    color: Colors.green[200]!
                                )
                              ),
                              elevation: 0,
                              padding: EdgeInsets.all(8),
                              selected: chip_indexs.contains(Tags.indexOf(e)) ? true : false,
                              pressElevation: 2,
                              selectedColor: Color.fromARGB(255, 201, 236, 202),
                              shadowColor: Colors.transparent,
                              selectedShadowColor: Colors.transparent,
                              avatar: Container(
                                decoration: BoxDecoration(
                                  color: Colors.green[600],
                                  borderRadius: BorderRadius.circular(50),
                                  // backgroundBlendMode: chip_index == Tags.indexOf(e) ? BlendMode.colorBurn : BlendMode.darken
                                ),
                              ),
                              labelStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: chip_indexs.contains(Tags.indexOf(e)) ? FontWeight.w600 : FontWeight.normal,
                                color: chip_indexs.contains(Tags.indexOf(e)) ? Colors.green[800] :Colors.green[500]
                              ),
                              onSelected: (selected){
                                setState(() {
                                  if (Tags.indexOf(e)==0 && !chip_indexs.contains(0)){
                                    chip_indexs.clear();
                                    chip_indexs.add(0);
                                  }
                                  else{
                                    if (chip_indexs.contains(Tags.indexOf(e))){
                                      if (chip_indexs.length>1){
                                        chip_indexs.remove(Tags.indexOf(e));
                                      }
                                      else{
                                        chip_indexs.remove(Tags.indexOf(e));
                                        chip_indexs.add(0);
                                        // Show_Snackbar(context: context, message: "Atleast 1 Filter Should Be Selected");
                                      }
                                    }
                                    else{
                                      if(chip_indexs.contains(0) && chip_indexs.length==1){
                                        chip_indexs.remove(0);
                                        chip_indexs.add(Tags.indexOf(e));
                                      }
                                      else {
                                        chip_indexs.add(Tags.indexOf(e));
                                      }
                                    }
                                  }
                                });
                              },
                              backgroundColor: Color.fromARGB(255, 255, 255, 255),
                                // elevation: 1,
                                label: Text(e)
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ),
                // Wrap(
                //   children: [
                //     ...Tags.map((e) {
                //       return Chip(
                //           label: Text(e)
                //       );
                //     })
                //   ],
                // ),
                Expanded(
                  child: ListView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(20, 14, 20, 20),
                    // shrinkWrap: true,
                    // scrollDirection: Axis.vertical,
                    // physics: ClampingScrollPhysics(),
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
                                (map["url"] != null || map["url"] != "") ?
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
                                                width: MediaQuery.of(context).size.width/1.87,
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
                                                width: MediaQuery.of(context).size.width/1.87,
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
                                                    letterSpacing: 0.35,
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
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> Dishes_Page(restaurantId: document.id,restaurantName: map['name'])));
                            },
                          ),
                        ),
                      );
                    }).toList()
                  ),
                )

            ]
          );
        },
      )
    );
  }
}




