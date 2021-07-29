import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Welcome"),
          SizedBox(height: 100,),
          Divider(height: 20.4,),
          Text("By Amanjot"),
          Text("version : 2.4")
        ],
      ),
    );
  }
}
