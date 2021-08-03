import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ListViewDemo extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8),
      // padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      children: <ListTile>[
        ListTile(
          title: Text("English"),
          subtitle: Text("Headlines from USA business"),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.cyanAccent,
            ),
            child: Center(
              child: Text("TC"),
            ),
          ),
          trailing: Icon(Icons.keyboard_arrow_right_sharp),
          onTap: (){},
        ),
        ListTile(
          title: Text("WallStreet Journal"),
          subtitle: Text("Headlines from WallStreet Journal"),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.cyanAccent,
            ),
            child: Center(
              child: Text("TC"),
            ),
          ),
          trailing: Icon(Icons.keyboard_arrow_right_sharp),
          onTap: (){},
        ),
        ListTile(
          title: Text("WallStreet Journal"),
          subtitle: Text("Headlines from WallStreet Journal"),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.cyanAccent,
            ),
            child: Center(
              child: Text("TC"),
            ),
          ),
          trailing: Icon(Icons.keyboard_arrow_right_sharp),
          onTap: (){},
        )
      ],
    );
  }
}

class Listviewbuilder extends StatelessWidget {
  List data=<Map<String,String>>[
    {
      'title': 'English',
      'subtitle' : 'Headlines from USA business'
    },
    {
      'title': 'WallStreet Journal',
      'subtitle' : 'Headlines from WallStreet Journal'
    },
    {
      'title': 'techcrunch',
      'subtitle' : 'Headlines from techcrunch'
    },
    {
      'title': 'BBC Sports',
      'subtitle' : 'Headlines from BBC Sports'
    },
    {
      'title': 'David Bernal Raspall',
      'subtitle' : 'Headlines from David Bernal Raspall'
    },
    {
      'title': 'Eduardo Archanco',
      'subtitle' : 'Headlines from Eduardo Archanco'
    },
    {
      'title': 'BBC News',
      'subtitle' : 'Headlines from BBC News'
    },
    {
      'title': 'AppleInsider',
      'subtitle' : 'Headlines from AppleInsider'
    },
    {
      'title': 'Forbes',
      'subtitle' : 'Headlines from Forbes'
    },
    {
      'title': 'Andreas Knobloch',
      'subtitle' : 'Headlines from Andreas Knobloch'
    },
    {
      'title': 'Joygourda',
      'subtitle' : 'Headlines from Joygourda'
    },
    {
      'title': "The Japan Times",
      'subtitle' : 'Headlines from The Japan Times'
    },
    {
      'title': 'The Times of India',
      'subtitle' : 'Headlines from The Times of India'
    },
    {
      'title': 'CleanTechnica',
      'subtitle' : 'Headlines from CleanTechnica'
    },
  ];

  getlistview(){
    var list_view = <Widget>[];

      data.forEach((element) {
        list_view.add(
              ListTile(
                title: Text(element['title']!),
                subtitle: Text(element['subtitle']!),
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.cyanAccent,
                  ),
                  child: Center(
                    child: Text("TC"),
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right_sharp),
                onTap: (){},
              )
        );
      });
    return list_view;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8),
      // padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      children: getlistview(),
    );
  }
}
