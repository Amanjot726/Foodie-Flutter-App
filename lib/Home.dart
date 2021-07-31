import 'package:flutter/material.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("My App"),
          backgroundColor: Colors.green,
          actions: [
            PopupMenuButton(
              itemBuilder: (context)=>[
                PopupMenuItem(
                  child: Text("Item 1"),
                  value: 1,
                ),
                PopupMenuItem(
                  child: Text("Item 2"),
                  value: 2,
                ),
              ],
            ),
          ],
        ),
        body: HomePage(),
      ),
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(children:[Text("Hi")]),
          Column(children:[Text("Hi")]),
          Text("Welcome"),
          SizedBox(height: 20,),
          Divider(height: 20.4),
          Text("By Amanjot"),
          Text("version : 2.4")
        ],
      ),
    );
  }
}
