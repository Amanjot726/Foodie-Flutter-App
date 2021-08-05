// import 'package:first_app/News_api.dart';
import 'package:first_app/News_api_Listview.dart';
import 'package:first_app/Listview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
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
      body: NewsPage(),
    );
  }
}