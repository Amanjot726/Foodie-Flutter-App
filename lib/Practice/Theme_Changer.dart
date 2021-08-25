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
        body: Change(),
      ),
    );
  }
}


class Change extends StatefulWidget {
  const Change({Key? key}) : super(key: key);

  @override
  _ChangeState createState() => _ChangeState();
}

class _ChangeState extends State<Change> {
  var mydefaultcolors = {
    'Orange' : Colors.orange,
    'Black' : Colors.black,
    'Cyan' : Colors.cyan,
    'Grey' : Colors.grey,
    'Brown': Colors.brown,
    'Deep Purple': Colors.deepPurple,
    'Green Accent' : Colors.greenAccent,
  };

  var scaffoldColor=Colors.white;

  getcolors(){
    var colorswidgets = <Widget>[];

    mydefaultcolors.forEach((key, value) {
      colorswidgets.add(
          Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(15),
                child: Row(
                    children:[
                      Column(
                          children: [
                            Text("   "+key+"\t\t",style: TextStyle(color: Colors.teal,fontSize: 17,fontWeight: FontWeight.w700),)
                          ]
                      ),
                      Column(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white60,width: 3),
                                color: value,
                              ),
                            )
                          ]
                      )
                    ]
                )
                ,onTap: (){
                setState(() {
                  scaffoldColor = value;
                });
              },
              ),
              SizedBox(height:20),
              Divider()
            ],
          )
      );
      colorswidgets.add(Row(
          children: [
            SizedBox(height:20),
            Divider(),
          ]
      ));
    });
    return colorswidgets;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Container(
          child: Column(
              children: [
                Column(
                    children: [SizedBox(height:20)]
                ),
                Column(
                    children: getcolors()
                ),
              ]
          )
      ),
    );
  }
}
