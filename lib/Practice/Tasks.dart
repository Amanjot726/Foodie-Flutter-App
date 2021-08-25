import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Tasks_page extends StatelessWidget {
  const Tasks_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Edit",
                  style: TextStyle(
                      color: Colors.indigoAccent,
                      fontSize: 17,
                  ),
                ),
                SizedBox(width: 4,),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              width: 365,
              height: 36,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white12
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    style: TextStyle(fontSize: 19),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        isDense: true,
                        icon: Icon(Icons.search,size: 21,color: Color.fromARGB(102, 255, 255, 255)),
                        hintStyle: TextStyle(fontSize: 20,color: Color.fromARGB(96, 255, 255, 255)),
                        hintText: 'Search'
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 30,),
            Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: (){},
                  child: Container(
                    padding: EdgeInsets.all(12),
                    width: (MediaQuery.of(context).size.width/2)-25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white12
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 3),
                                  child: Container(
                                    child: Icon(
                                      Icons.calendar_today,
                                      size: 18,
                                    ),
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: Text("1",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(4, 12, 0, 0),
                              child: Text(
                                'Today',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(136, 255, 255, 255),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                Spacer(),

                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: (){},
                  child: Container(
                    padding: EdgeInsets.all(12),
                    width: (MediaQuery.of(context).size.width/2)-25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white12
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 3),
                                  child: Container(
                                    child: Icon(
                                      Icons.date_range,
                                      size: 21,
                                    ),
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: Text("1",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(4, 12, 0, 0),
                              child: Text(
                                'Scheduled',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(136, 255, 255, 255),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: (){},
                  child: Container(
                    padding: EdgeInsets.all(12),
                    width: (MediaQuery.of(context).size.width/2)-25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white12
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 3),
                                  child: Container(
                                    child: Icon(
                                      Icons.inbox,
                                      size: 18,
                                    ),
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: Text("1",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(4, 12, 0, 0),
                              child: Text(
                                'All',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(136, 255, 255, 255),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                Spacer(),

                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: (){},
                  child: Container(
                    padding: EdgeInsets.all(12),
                    width: (MediaQuery.of(context).size.width/2)-25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white12
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 3),
                                  child: Container(
                                    child: Icon(
                                      Icons.flag,
                                      size: 21,
                                    ),
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.orangeAccent,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: Text("0",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(4, 12, 0, 0),
                              child: Text(
                                'Flagged',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(136, 255, 255, 255),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6,),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "My Lists",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Padding(padding: padding)
                  InkWell(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10),bottom: Radius.circular(0)),
                    onTap: (){},
                    child: Container(
                      width: MediaQuery.of(context).size.width-30,
                      // padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10),bottom: Radius.circular(0)),
                      ),
                      child: ListTile(
                        // visualDensity:VisualDensity.compact,
                        horizontalTitleGap: 4,
                        // dense: true,
                        leading: Container(
                          child: Icon(
                            Icons.list,
                            size: 21,
                          ),
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orangeAccent,
                          ),
                        ),
                        title: Text(
                          "Reminders",
                          style: TextStyle(
                            fontSize: 19,
                            color: Color.fromARGB(255, 236, 236, 236)
                          ),
                        ),
                        trailing: Container(
                          width: 34,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("1",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 161, 161, 161)
                                ),
                              ),
                              Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Color.fromARGB(255, 123, 123, 123)
                              )
                            ],
                          ),
                        )
                      ),
                    ),
                  ),
                  Divider(thickness: 0.8,indent: 71,height: 1,color: Colors.white10,),
                  InkWell(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(0),bottom: Radius.circular(10)),
                    onTap: (){},
                    child: Container(
                      width: MediaQuery.of(context).size.width-30,
                      // height: 60,
                      // padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(0),bottom: Radius.circular(10)),
                      ),
                      child: ListTile(
                        visualDensity:VisualDensity.compact,
                        horizontalTitleGap: 8,
                        dense: true,
                        leading: Container(
                          child: Icon(
                            Icons.list,
                            size: 21,
                          ),
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(225, 229, 201, 20),
                          ),
                        ),
                        title: Text(
                          "Family",
                          style: TextStyle(
                            fontSize: 19,
                            color: Color.fromARGB(255, 236, 236, 236)
                          ),
                        ),
                        subtitle: Text(
                          "Shared with Gudiya",
                          style: TextStyle(
                            fontSize: 14.5,
                            color: Color.fromARGB(255, 146, 146, 146)
                          ),
                        ),
                        trailing: Container(
                          width: 34,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("0",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 161, 161, 161)
                                ),
                              ),
                              Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Color.fromARGB(255, 123, 123, 123)
                              )
                            ],
                          ),
                        )
                      ),
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            Row(
              children: [
                Icon(Icons.add_circle,
                  color: Colors.blue,
                ),
                SizedBox(width: 5,),
                Text("New Reminder",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.blue
                  ),
                ),
                Spacer(),
                Text("Add List",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 17
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}
