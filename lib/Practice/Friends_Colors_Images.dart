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
          title: Text("My Friends"),
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
    // 'Hargun' : ['Orange',Colors.orange,"https://upload.wikimedia.org/wikipedia/commons/f/ff/Pizigani_1367_Chart_10MB.jpg"],
    'Hargun' : ['Orange',Colors.orange,"https://images.unsplash.com/photo-1509189246476-581f4faa157b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NzR8fHNhcmRhcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"],
    'Priyanka' : ['Pink',Colors.pink,"https://www.psypost.org/wp-content/uploads/2018/10/young-attractive-woman.jpg"],
    'Vrishti' : ['Deep Purple',Colors.deepPurple,"https://images.unsplash.com/photo-1512501397866-5c4b28612400?ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE0fHx8ZW58MHx8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"],
    'Harsh' : ['Cyan',Colors.cyan,"https://images.unsplash.com/photo-1559130278-48473adc4a38?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80"],
  };
  var mydefaultcolors2 = <String,List>{
    'Divyanshu' : ['Indigo',Colors.indigo,"https://media.istockphoto.com/photos/smiling-man-outdoors-in-the-city-picture-id1179420343?k=6&m=1179420343&s=612x612&w=0&h=y7GrwxrbixTWvJfaeiu55rWXMGYr6oP583uzJJ4-Kis="],
    'Chatter' : ['Green Accent',Colors.greenAccent,"https://images.unsplash.com/photo-1556513317-6d8a4d56425f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80"],
    'Ishpreet' : ['Lime',Colors.lime,"https://images.unsplash.com/photo-1616879672772-324ebd30f512?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80"],
    'Jashan' : ['Grey',Colors.grey,"https://images.unsplash.com/photo-1508310621848-9b567e9621bf?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1017&q=80"],
  };


  var containerbackgroundcolor = Colors.black12;
  var imagelink = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgDoMhtOZ5cGa2Aijak4n_auv7QBUya9uBnA&usqp=CAU";

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
                              width: 120,
                              child: Text("\n "+key+":\n"+" "*10+value[0],style: TextStyle(color: Colors.teal,fontSize: 16,fontWeight: FontWeight.w700),),
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
                  imagelink = value[2];
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
                            children: [SizedBox(width: size.width/84)]
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
                            children: [SizedBox(width: size.width/84)]
                        ),
                      ]
                  )
              ),
              Container(
                height: size.height/2,
                color: containerbackgroundcolor,
                child: Center(
                  child: Image.network(
                    imagelink,
                    width: 400,
                    height: 400,
                    fit: BoxFit.contain,
                    loadingBuilder: (context,child,loadingProgress) {

                      return loadingProgress == null ? child : Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
            ]
        )
    );
  }
}