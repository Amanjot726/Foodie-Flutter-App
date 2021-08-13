import 'package:flutter/material.dart';

class User{

  String? uid;
  String? name;

  User({this.uid, this.name});

  @override
  String toString() {
    return uid!+" "+name!+"\n";
  }

}

// Read the data on UI from PageOne and put it onto Object User
// Pass Data from PageOne into PageTwo

class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {

  String title = "Page One";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Enter Details of User"),
              SizedBox(height: 10,),
              TextField(),
              TextField(),
              SizedBox(height: 10,),
              InkWell(
                child: Text("SUBMIT"),
                onTap: () async {
                  // Create an Object
                  User user = new User();
                  // Put Data in Object
                  user.uid = "ABC101";
                  user.name = "John Watson";
                  User resultUser = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PageTwo(user: user))
                  );
                  setState(() {
                    title = resultUser.uid.toString() + " "+ resultUser.name.toString();
                  });
                },
              )
            ],
          ),
        )
    );
  }
}

class PageTwo extends StatelessWidget {

  User? user;

  PageTwo({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Page Two"),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(user!.uid.toString()),
                SizedBox(height: 10,),
                Text(user!.name.toString()),
                InkWell(
                  child: Text("DONE"),
                  onTap: (){
                    User user = new User(uid: "XYZ987", name: "Fionna Flynn");
                    // Return the data from Current Page to the Previous Page
                    //Navigator.pop(context, "Thank You");
                    Navigator.pop(context, user);
                  },
                )
              ],
            )
        )
    );
  }
}