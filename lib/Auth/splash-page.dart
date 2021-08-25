// import 'dart:html';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/Model/user.dart';
import 'package:first_app/util/constants.dart';
import 'package:flutter/material.dart';







class RestaurantSplashPage extends StatelessWidget {
  RestaurantSplashPage({Key? key}) : super(key: key);

  String uid = FirebaseAuth.instance.currentUser!= null ? FirebaseAuth.instance.currentUser!.uid : "";

  navigateToHome(BuildContext context){

    Future.delayed(
        Duration(seconds: 3), ()async{
          print("xxxxx uid xxxxxx => ${uid}");
          //Navigator.pushNamed(context, "/home");
          if(uid.isNotEmpty){
            await get_data();
            Navigator.pushReplacementNamed(context, "/Restaurant_home");
          }else {
            Navigator.pushReplacementNamed(context, "/login");
          }
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    
    navigateToHome(context);
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/Restaurants.png",width: 85,),
            SizedBox(height: 6,),
            Text("Foodie",
                style: TextStyle(
                    color: Color.fromARGB(255, 93, 143, 201),
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                )
            ),
            SizedBox(height: 6,),
            Text("For Most Countries",
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                )
            ),
          ],
        ),
      ),
    );
  }
}
