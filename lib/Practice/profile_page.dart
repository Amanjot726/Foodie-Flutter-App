// import 'package:flutter/cupertino.dart';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';


class Profile_UI extends StatelessWidget {
  const Profile_UI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 80,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    "Profile",
                    style: TextStyle(
                      color: Color.fromARGB(178, 13, 97, 57),
                      fontFamily: 'AlfaSlabOne',
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0
                      // decoration: TextDecoration.underline,
                    ),
                )
              ],
            ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(96, 31, 159, 98),
                          blurRadius: 8.0,
                          spreadRadius: 3.0,
                          offset: Offset(
                            -0.0,
                            1.0,
                          ),
                        ),
                      ]
                    ),
                    child:ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          "assets/dp.jpg",
                          height: 110,
                          width: 110,
                        )
                    )
                )
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  // FirebaseFirestore.instance.collection("users").doc().
                  "Amanjot Singh",
                  style: TextStyle(
                    color: Color.fromARGB(146, 0, 0, 0),
                    fontFamily: 'Righteous',
                    fontSize: 26.0,
                  ),
                )
              ],
            ),
            SizedBox(height: 6,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    "Developer with 2 year experience",
                    style: TextStyle(
                      color: Color.fromARGB(128, 0, 0, 0),
                      fontFamily: 'Roboto',
                      fontSize: 17.0
                    ),
                )
              ],
            ),
            SizedBox(height: 50,),
            Container(
              width: 330,
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(35, 19, 181, 103),
              ),
              child: Column(
                children:[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Row(
                              children:[
                                Text("Follower",
                                  style: TextStyle(
                                    color: Color.fromARGB(171, 13, 97, 57),
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17.0
                                  ),
                                )
                              ]
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Text("11.4K",
                                style: TextStyle(
                                    color: Color.fromARGB(171, 13, 97, 57),
                                    fontFamily: 'Roboto',
                                    fontSize: 16.1
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(width: 60,),
                      Column(
                        children: [
                          Row(
                              children:[
                                Text("Following",
                                  style: TextStyle(
                                      color: Color.fromARGB(171, 13, 97, 57),
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17.0
                                  ),
                                )
                              ]
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Text("425",
                                style: TextStyle(
                                    color: Color.fromARGB(171, 13, 97, 57),
                                    fontFamily: 'Roboto',
                                    fontSize: 16.1
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(width: 60,),
                      Column(
                        children: [
                          Row(
                              children:[
                                Text("Posts",
                                  style: TextStyle(
                                      color: Color.fromARGB(171, 13, 97, 57),
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17.0
                                  ),
                                )
                              ]
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Text("120",
                                style: TextStyle(
                                    color: Color.fromARGB(171, 13, 97, 57),
                                    fontFamily: 'Roboto',
                                    fontSize: 16.1
                                ),
                              )
                            ],
                          )
                        ],
                      ),

                    ]
                  ),
                  SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){},
                        child: Container(
                          width: 120,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(136, 19, 181, 103),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(124, 31, 159, 98),
                                blurRadius: 6.0,
                                spreadRadius: 2.0,
                              ),
                            ]
                          ),
                          child: Text(
                            "See Posts",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(191, 2, 65, 35),
                              fontFamily: 'Roboto',
                              fontSize: 15.5
                            ),
                          )
                        )
                      ),
                    ]
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
