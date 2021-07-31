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
  var mydefaultcolors1 = <String,List>{
    'Hargun' : ['Orange',Colors.orange],
    'Ishpreet' : ['Pink',Colors.pink],
    'Jashan' : ['Deep Purple',Colors.deepPurple],
    'Harsh' : ['Cyan',Colors.cyan],
  };
  var mydefaultcolors2 = <String,List>{
    'Divyanshu' : ['Indigo',Colors.indigo],
    'Chatter' : ['Green Accent',Colors.greenAccent],
    'Ishpreet' : ['Lime',Colors.lime],
    'Jashan' : ['Grey',Colors.grey],
  };


  var containerbackgroundcolor = Colors.black12;

  getcolors(int val){
    var colorswidgets = <Widget>[];

    colorswidgets.add(Row(
        children: [
          SizedBox(height:15),
        ]
    ));
    (val==1?mydefaultcolors1:mydefaultcolors2).forEach((key, value) {
      colorswidgets.add(
          Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(15),
                child: Row(
                    children:[
                      Column(
                          children: [
                            Container(
                              height: 75,
                              width: 200,
                              child: Text("\n   "+key+":\n"+" "*25+value[0],style: TextStyle(color: Colors.teal,fontSize: 16,fontWeight: FontWeight.w700),),
                            )

                          ]
                      ),
                      Column(
                          children: [
                            Container(
                                width: 50,
                                child:Container(
                                  height: 26,
                                  width: 26,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white60,width: 3),
                                    color: value[1],
                                  ),
                                )
                            )
                          ]
                      )
                    ]
                )
                ,onTap: (){
                setState(() {
                  containerbackgroundcolor = value[1];
                });
              },
              ),
            ],
          )
      );
      colorswidgets.add(Row(
          children: [
            SizedBox(height:5),
          ]
      ));
    });
    return colorswidgets;
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: ListView(
            children: [
              Container(
                  height: size.height/2,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                            children: [SizedBox(width: size.width/64)]
                        ),
                        Column(
                            children: getcolors(1)
                        ),
                        Column(
                            children: [SizedBox(width: size.width/12)]
                        ),
                        Column(
                            children: getcolors(2)
                        ),
                        Column(
                            children: [SizedBox(width: size.width/64)]
                        ),
                      ]
                  )
              ),
              Container(
                height: size.height/2,
                color: containerbackgroundcolor,
              ),
            ]
        )
    );
  }
}