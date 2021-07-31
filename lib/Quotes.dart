import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        body: QuotesPage(),
      ),
    );
  }
}


class QuotesPage extends StatefulWidget {
  const QuotesPage({Key? key}) : super(key: key);

  @override
  _QuotesPageState createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  var qoutes=[
    'Be exceptional',
    'Work Hard',
    'Always smile and be happy'
  ];

  var idx = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(qoutes[idx]),
          SizedBox(height: 100,),
          InkWell(
            child: Text("Next"),
            onTap: (){
              setState(() {
                if (idx == qoutes.length-1){
                  idx=0;
                }
                else {
                  idx++;
                }
              });
            },
          )
        ],
      ),
    );
  }
}
