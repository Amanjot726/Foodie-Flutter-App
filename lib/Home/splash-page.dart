// import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  navigateToHome(BuildContext context){
    Future.delayed(
        Duration(seconds: 5),
        (){
          Navigator.pushReplacementNamed(context, "/home");
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
            Image.asset("assets/pizza.png"),
            SizedBox(height: 8,),
            Text("Foodie",style: TextStyle(color: Colors.orange,fontSize: 18,fontWeight: FontWeight.bold)),
            SizedBox(height: 8,),
          ],
        ),
      ),
    );
  }
}
