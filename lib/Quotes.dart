import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



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
    )
  }
}
