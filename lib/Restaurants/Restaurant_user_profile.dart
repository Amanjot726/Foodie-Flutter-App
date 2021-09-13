// import 'package:flutter/cupertino.dart';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app/Restaurants/add_restaurants.dart';
import 'package:first_app/Restaurants/select_restaurant.dart';
import 'package:first_app/util/constants.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';


XFile? file;
var file_name = "";
final ImagePicker Image_Picker = ImagePicker();


class Show_Snackbar{
  String message;
  BuildContext context;
  Duration? duration;
  Show_Snackbar({required this.context,required this.message, this.duration}){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(this.message.toString()),
      duration: duration==null?Duration(seconds: 4):duration!,
    )
    );
  }
}


class User_Profile extends StatelessWidget {
  User_Profile({Key? key}) : super(key: key);

  // String uid = FirebaseAuth.instance.currentUser!= null ? FirebaseAuth.instance.currentUser!.uid.toString() : "";
  //
  // Future get_name() async{
  //   var data_snapshot = await FirebaseFirestore.instance.collection("users").doc(uid).get();
  //   if (data_snapshot.exists) {
  //     Map<String, dynamic>? data = data_snapshot.data();
  //
  //     // You can then retrieve the value from the Map like this:
  //     return data!['name'].toString();
  //   }
  //
  // }


  var navigation_List = [
    "/Restaurant_home",
    "/profile"
  ];

  var index = 1;


  @override
  Widget build(BuildContext context) {
    get_data();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        actionsIconTheme: IconThemeData(color: Colors.black),
        title: Row(
          children: [
            Image.asset("assets/Restaurants_small.png",width: 36,),
            SizedBox(width: 6,),
            Text(APP_NAME,
              style: TextStyle(
                  color: Color.fromARGB(185, 0, 0, 0),
                  fontFamily: 'AlfaSlabOne',
                  letterSpacing: 1.4
              ),
            ),
          ],
        ),
        backgroundColor: PRIMARY_COLOR,
        actions: [
          IconButton(
            onPressed: (){
              FirebaseAuth.instance.signOut();
              get_user_data= null;
              Navigator.pushReplacementNamed(context, "/login");
            }, icon: Icon(Icons.logout,color: Color.fromARGB(185, 0, 0, 0)),
            tooltip: "Log Out",
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert,color: Color.fromARGB(185, 0, 0, 0)),
            onSelected: (value) {
              value!=index?Navigator.pushReplacementNamed(context, navigation_List[value as int]):"";
            },
            itemBuilder: (context)=>[
              PopupMenuItem(
                child: Text("Home"),
                value: 0,
              ),
              PopupMenuItem(
                child: Text("Profile"),
                value: 1,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color.fromARGB(37, 0, 0, 0),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 246, 246, 246),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: "Home"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person_rounded),
                label: "Profile"
            ),

          ],
          currentIndex: index,
          selectedFontSize: 12,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          selectedItemColor: PRIMARY_COLOR,
          onTap: (idx) {
            index!=idx ? Navigator.pushReplacementNamed(context, navigation_List[idx]) :
            index = idx;
          }
        ),
      ),
      body: Container(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 35,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Profile",
                  style: TextStyle(
                      color: Color.fromARGB(178, 13, 97, 57),
                      fontFamily: 'AlfaSlabOne',
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0
                    // decoration: TextDecoration.underline,
                  ),
                )
              ],
            ),
            SizedBox(height: 25,),
            ProfilePic(),
            SizedBox(height: 18,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(get_user_data==null?"":get_user_data!.name==null?"":get_user_data!.name as String,
                    style: TextStyle(
                    color: Color.fromARGB(146, 0, 0, 0),
                    fontFamily: 'Righteous',
                    fontSize: 21.5,
                  ),
                )
              ],
            ),
            SizedBox(height: 6,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  get_user_data==null?"":get_user_data!.email as String,
                  style: TextStyle(
                      color: Color.fromARGB(128, 0, 0, 0),
                      fontFamily: 'Roboto',
                      fontSize: 15.3
                  ),
                )
              ],
            ),
            SizedBox(height: 30,),
            Container(
              // width: 330,
              padding: EdgeInsets.symmetric(horizontal: 33,vertical: 25),
              margin: EdgeInsets.symmetric(horizontal: 32),
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
                                Text("Orders",
                                  style: TextStyle(
                                      color: Color.fromARGB(171, 13, 97, 57),
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0
                                  ),
                                )
                              ]
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Text("23",
                                style: TextStyle(
                                    color: Color.fromARGB(171, 13, 97, 57),
                                    fontFamily: 'Roboto',
                                    fontSize: 15.2
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Row(
                              children:[
                                Text("Favorites",
                                  style: TextStyle(
                                      color: Color.fromARGB(171, 13, 97, 57),
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0
                                  ),
                                )
                              ]
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Text("82",
                                style: TextStyle(
                                    color: Color.fromARGB(171, 13, 97, 57),
                                    fontFamily: 'Roboto',
                                    fontSize: 15.2
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Row(
                              children:[
                                Text("Saved",
                                  style: TextStyle(
                                      color: Color.fromARGB(171, 13, 97, 57),
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0
                                  ),
                                )
                              ]
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Text("134",
                                style: TextStyle(
                                    color: Color.fromARGB(171, 13, 97, 57),
                                    fontFamily: 'Roboto',
                                    fontSize: 15.2
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ]
                  ),
                ],
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color.fromARGB(54, 64, 64, 64),width: 1.5),

                  ),
                  child: Column(
                    children: [
                      ListTile(
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(18.5)),
                        ),
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Icon(Icons.person,size: 26,),
                        ),
                        dense: true,
                        title: Text("Manage Profile",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16,color: Color.fromARGB(181, 0, 0, 0)),),
                        subtitle: Text("Update Your Data for Your Account",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13),),
                        trailing: Icon(Icons.keyboard_arrow_right_rounded),
                        onTap: (){

                        },
                      ),
                      Divider(height: 1,indent: 10,endIndent: 10,thickness: 1,color: Color.fromARGB(20, 49, 49, 49),),
                      ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 4,left: 1),
                          child: Icon(Icons.shopping_cart,size: 25),
                        ),
                        dense: true,
                        title: Text("Manage Orders",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16,color: Color.fromARGB(181, 0, 0, 0)),),
                        subtitle: Text("Manage Your Order History Here",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13),),
                        trailing: Icon(Icons.keyboard_arrow_right_rounded),
                        onTap: (){
                          Navigator.pushNamed(context, '/Orders');
                        },
                      ),
                      Divider(height: 1,indent: 10,endIndent: 10,thickness: 1,color: Color.fromARGB(20, 49, 49, 49),),
                      ListTile(
                        // visualDensity: VisualDensity.comfortable,
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Icon(Icons.home,size: 26),
                        ),
                        dense: true,
                        title: Text("Manage Addresses",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16,color: Color.fromARGB(181, 0, 0, 0)),),
                        subtitle: Text("Update Your Addresses for Delivery",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13),),
                        trailing: Icon(Icons.keyboard_arrow_right_rounded),
                        onTap: (){
                          Navigator.pushNamed(context, '/Addresses');
                        },
                      ),
                      (get_user_data==null)? Container() :
                        (get_user_data!.isAdmin != true) ? Container() :
                        Column(
                          children: [
                            Divider(height: 1,indent: 10,endIndent: 10,thickness: 1,color: Color.fromARGB(20, 49, 49, 49),),
                            ListTile(
                              // visualDensity: VisualDensity.comfortable,
                              leading: Padding(
                                padding: const EdgeInsets.only(top: 5,left: 2),
                                child: Icon(Icons.dining, size: 24,),
                              ),
                              dense: true,
                              title: Text("Manage Restaurants", overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16,color: Color.fromARGB(181, 0, 0, 0)),),
                              subtitle: Text("Add More Restaurants to App", overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13),),
                              trailing: Icon(Icons.keyboard_arrow_right_rounded,),
                              onTap: () {
                                Navigator.pushNamed(context, "/add_restaurant");
                              },
                            ),
                            Divider(height: 1,indent: 10,endIndent: 10,thickness: 1,color: Color.fromARGB(20, 49, 49, 49),),
                            ListTile(
                              // visualDensity: VisualDensity.comfortable,
                              leading: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Icon(Icons.restaurant_menu, size: 26,),
                              ),
                              dense: true,
                              title: Text("Manage Dishes", overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16,color: Color.fromARGB(181, 0, 0, 0)),),
                              subtitle: Text("Add Dishes to the Restaurants", overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13),),
                              trailing: Icon(Icons.keyboard_arrow_right_rounded),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> Select_Restaurant()));
                              },
                            ),
                          ],
                        ),
                      Divider(height: 1,indent: 10,endIndent: 10,thickness: 1,color: Color.fromARGB(20, 49, 49, 49),),
                      ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Icon(Icons.delivery_dining,size: 26,),
                        ),
                        dense: true,
                        title: Text("Manage Delivery",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16,color: Color.fromARGB(181, 0, 0, 0)),),
                        subtitle: Text("Check Your Delivery Status",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13),),
                        trailing: Icon(Icons.keyboard_arrow_right_rounded),
                        onTap: (){
                          Navigator.pushNamed(context, "/Manage_Delivery");
                        },
                      ),
                      Divider(height: 1,indent: 10,endIndent: 10,thickness: 1,color: Color.fromARGB(20, 49, 49, 49),),
                      ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 4,left: 2),
                          child: Icon(Icons.message,size: 23,),
                        ),
                        dense: true,
                        title: Text("Help",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(181, 0, 0, 0)
                          ),
                        ),
                        subtitle: Text("Raise Your Queries",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13),),
                        trailing: Icon(Icons.keyboard_arrow_right_rounded,),
                        onTap: (){

                        },
                      ),
                      Divider(height: 1,indent: 10,endIndent: 10,thickness: 1,color: Color.fromARGB(20, 49, 49, 49),),
                      ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(18.5)),
                        ),
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 5,left: 2),
                          child: Icon(Icons.document_scanner_outlined,size: 24,),
                        ),
                        title: Text("Terms & Conditions",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(181, 0, 0, 0),
                          ),
                        ),
                        subtitle: Text("Check our Terms and Conditions",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13),),
                        trailing: Icon(Icons.keyboard_arrow_right_rounded,),
                        onTap: (){

                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class ProfilePic extends StatefulWidget {
  const ProfilePic({Key? key}) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {


  _show_Dialog_Box(BuildContext dialogContext) async {
    return showDialog(
      context: dialogContext,
      builder: (dialogContext) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
          title: Text(
            'Choose New Photo',
            style: TextStyle(
                color: Colors.black87,
                fontSize: 20
            ),
          ),
          children: [
            SizedBox(height: 3,),
            SimpleDialogItem(
              leading_Icon: Icon(
                Icons.photo_camera,
                color: Colors.black45,
                size: 21.0,
              ),
              text: Text(
                'Camera',
                style: TextStyle(
                    fontSize: 16.5
                ),
              ),
              padding: EdgeInsets.all(6),
              onPressed: ()async {
                file = await Image_Picker.pickImage(source: ImageSource.camera,preferredCameraDevice: CameraDevice.rear,maxHeight: 480,maxWidth: 640,imageQuality: 50);
                Navigator.pop(dialogContext);
              },
            ),
            SimpleDialogItem(
              leading_Icon: Icon(
                Icons.photo_size_select_actual_outlined,
                color: Colors.black45,
                size: 21,
              ),
              text: Text(
                'Gallery',
                style: TextStyle(
                    fontSize: 16.5
                ),
              ),
              padding: EdgeInsets.all(6),
              onPressed: () async {
                file = await Image_Picker.pickImage(source: ImageSource.gallery);
                Navigator.pop(dialogContext);
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    Future<String> UploadImage(ImageFile) async {
      Show_Snackbar(context: context, message: "Uploading...",duration: Duration(milliseconds: 1500));
      var uploadTask = await FirebaseStorage.instance.ref('profile-pics/'+get_user_data!.uid.toString()+"."+file!.name.toString().split(".").last).putFile(ImageFile);
      Show_Snackbar(context: context, message: "Uploaded",duration: Duration(milliseconds: 1500));
      String downlaodUrl = await uploadTask.ref.getDownloadURL();
      return downlaodUrl;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () async {
            await _show_Dialog_Box(context);
            print("File Path1 = ${file!.path}");
            if (file != null){
              print("File Path2 = ${file!.path}");
              var url = await UploadImage(File(file!.path));
              setState((){
                get_user_data!.Profile_pic = url;
                USERS_COLLECTION.doc(get_Uid()).update({"profile_pic":get_user_data!.Profile_pic});
                file = null;
              });
            }
          },
          child: Container(
              height: get_user_data!=null? get_user_data!.Profile_pic!=""? 120 : 130 : 130,
              width: get_user_data!=null? get_user_data!.Profile_pic!=""? 120 : 130 : 130,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(96, 31, 159, 98),
                      blurRadius: get_user_data!=null?get_user_data!.Profile_pic!=""? 8.0 : 8.0 : 8.0,
                      spreadRadius: get_user_data!=null? get_user_data!.Profile_pic!=""? 6.0 : -5 : -5,
                      offset: Offset(
                        -0.0,
                        1.0,
                      ),
                    ),
                  ]
              ),
              child: (get_user_data!=null ?
              (get_user_data!.Profile_pic != "") ?
              ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    get_user_data!.Profile_pic??"",
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                    loadingBuilder: (context,child,loadingProgress) {
                      return loadingProgress == null ? child : Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.account_circle,
                                size: 120,
                                color: Colors.white,
                              )
                          )
                      );
                    },
                  )
              )
                  :
              ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.account_circle,
                        size: 130,
                        color: Colors.white,
                      )
                  )
              )
                  :
              ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.account_circle,
                        size: 130,
                        color: Colors.white,
                      )
                  )
              )
            )
          ),
        )
      ],
    );
  }
}





class SimpleDialogItem extends StatelessWidget {
  final Icon? leading_Icon;
  final Text? text;
  final EdgeInsets? padding;
  final VoidCallback? onPressed;
  SimpleDialogItem({Key? key, this.leading_Icon, this.text, this.padding, this.onPressed}): super(key: key);


  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Padding(
        padding: padding==null?EdgeInsets.all(6.0):padding!,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leading_Icon==null?Container():leading_Icon!,
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 16.0),
              child: text!,
            ),
          ],
        ),
      ),
    );
  }
}
