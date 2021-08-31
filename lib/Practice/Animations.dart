import 'dart:math';

import 'package:flutter/material.dart';


class AnimationPage extends StatefulWidget {
  const AnimationPage({Key? key}) : super(key: key);

  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {

  // Acting as Constructor
  // Execute before the build method
  @override
  void initState() {
    super.initState();
    updateAttributes();
  }

  // Acting as Destructor
  // Execute when widget will be deleted from memory
  @override
  void dispose() {
    super.dispose();
  }

  Color color = Colors.green;
  double radius = 10;
  double margin = 10;

  void updateAttributes(){
    color = Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
    radius = Random().nextDouble() * 64;
    margin = Random().nextDouble() * 64;
  }

  void animateContainer(){
    setState(() {
      updateAttributes();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animations Tutorial"),
      ),
      body: Center(
        child: Column(
          children: [
            AnimatedContainer(
              width: 256,
              height: 256,
              margin: EdgeInsets.all(margin),
              duration: Duration(seconds: 1),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
            SizedBox(height: 26,),
            TextButton(
              onPressed: (){
                animateContainer();
              },
              child: Text("Animate Container")
            )
          ],
        ),
      ),
    );
  }
}
