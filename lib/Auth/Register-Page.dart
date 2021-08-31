import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/Model/user.dart';
import 'package:first_app/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';


FocusNode _Name_focus_node = new FocusNode();
FocusNode _Email_focus_node = new FocusNode();
FocusNode _Password_focus_node = new FocusNode();
FocusNode _Button_focus_node = new FocusNode();

TextEditingController NameController = new TextEditingController();
TextEditingController loginIDController = new TextEditingController();
TextEditingController PasswordController = new TextEditingController();


class Show_Snackbar{
  String message;
  BuildContext context;
  Show_Snackbar({required this.context,required this.message}){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(this.message.toString()),
      duration: Duration(seconds: 5),
    )
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  void RegisterUser(BuildContext context) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: loginIDController.text.trim(),
          password: PasswordController.text.trim()
      );

      print("userCredential = ${userCredential}");

      print("User ID is:"+userCredential.user!.uid.toString());

      if(userCredential.user!.uid.toString().isNotEmpty){
        AppUser user = AppUser(uid:userCredential.user!.uid, name:NameController.text.trim(), email:loginIDController.text.trim(), Profile_pic: "", isAdmin: false, cart: {}, address: {});
        var dataToSave = user.toMap();
        USERS_COLLECTION.doc(userCredential.user!.uid).set(dataToSave).then((value) {get_data();Navigator.pushReplacementNamed(context, "/Restaurant_home");});
        Future.delayed(Duration(milliseconds: 500), (){
          setState(() {
            showLoader=false;
            NameController.clear();
            loginIDController.clear();
            PasswordController.clear();
            _FormKey.currentState!.reset();
          });
        });
      }
      else{
        // Registration Failed
        setState(() {
          showLoader=false;
        });
      }


    } on FirebaseAuthException catch (e) {

      if (e.code == 'email-already-in-use') {
        print('This email address "${loginIDController.text}" is already in use by another account');
        setState(() {
          showLoader=false;
        });
        Show_Snackbar(context: context,message: "Account already exist, Please Login!");
      }
      else if (e.code == 'error-invalid-email') {
        print('Email is invalid');
        setState(() {
          showLoader=false;
        });
        Show_Snackbar(context: context,message: "Email is invalid");
      }
      else{
        // print(e.message);
        print('Failed with error code: ${e.code}');
        Show_Snackbar(context: context,message: e.code.toString());
      }
    }
  }


  final _FormKey = GlobalKey<FormState>();

  bool showLoader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
          onTap: (){
            setState(() {
              _Name_focus_node.unfocus();
              _Email_focus_node.unfocus();
              _Password_focus_node.unfocus();
              FocusScope.of(context).requestFocus(new FocusNode());
            });
          },
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height/3.2,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Color.fromARGB(205, 34, 170, 61),
                              Color.fromARGB(69, 0, 208, 38),
                            ],
                            tileMode: TileMode.clamp
                        )
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height/4.6,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Color.fromARGB(69, 0, 208, 38),
                              Color.fromARGB(0, 0, 208, 38),
                            ],
                            tileMode: TileMode.clamp
                        )
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Container(
                          color: Color.fromARGB(0, 243, 243, 243),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height<680) ?
                            MediaQuery.of(context).size.height/2-((MediaQuery.of(context).size.height/2)/1.5)
                                :
                            MediaQuery.of(context).size.height/2-((MediaQuery.of(context).size.height/2)/1.8),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Register",
                      style: TextStyle(
                        fontSize: 38,
                        color: Color.fromARGB(243, 19, 127, 39),
                        fontFamily: 'Pacifico',
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                    )
                  ],
                ),
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.center,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 20,
                    semanticContainer: false,
                    // margin: EdgeInsets.symmetric(horizontal: card_horizontal_margin,vertical: card_vertical_margin),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          // height: MediaQuery.of(context).size.height/1.95,
                          width: MediaQuery.of(context).size.width/1.2,
                          padding: EdgeInsets.all(20),
                          child: Form(
                            key: _FormKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 6,),
                                TextFormField(
                                  onTap: (){
                                    setState(() {
                                      _Password_focus_node.unfocus();
                                      _Email_focus_node.unfocus();
                                      _Button_focus_node.unfocus();
                                      FocusScope.of(context).requestFocus(_Name_focus_node);
                                    });
                                  },
                                  focusNode: _Name_focus_node,
                                  controller: NameController,
                                  enabled: true,
                                  autofocus: false,
                                  textCapitalization: TextCapitalization.words,
                                  cursorHeight: 20,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.name,
                                  // cursorColor: Colors.green,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Name is required. Please Enter.';
                                    } else if (value.trim().length == 0) {
                                      return 'Name is required. Please Enter.';
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blueGrey
                                  ),
                                  decoration: InputDecoration(
                                    // filled: true,
                                    // alignLabelWithHint: true,
                                      labelText: "Name",
                                      labelStyle: TextStyle(
                                          fontWeight: _Name_focus_node.hasPrimaryFocus? FontWeight.bold : FontWeight.normal,
                                          // color: _Name_focus_node.hasPrimaryFocus ? Color.fromARGB(243, 93, 177, 108) : Colors.black54
                                        // color: Colors.grey
                                      ),
                                      hintText: 'John',
                                      hintStyle: TextStyle(
                                          color: Colors.grey
                                      ),
                                      isDense: true,
                                      prefixIcon: Icon(Icons.person,size: 22,color: _Email_focus_node.hasFocus ? Color.fromARGB(243, 93, 177, 108) : Colors.black45),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        gapPadding: 4,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(235, 60, 191, 84),
                                              width: 1.5
                                          )
                                      ),
                                  ),

                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  onTap: (){
                                    setState(() {
                                      _Password_focus_node.unfocus();
                                      FocusScope.of(context).requestFocus(_Email_focus_node);
                                    });
                                  },
                                  focusNode: _Email_focus_node,
                                  controller: loginIDController,
                                  enabled: true,
                                  autofocus: false,
                                  keyboardType: TextInputType.emailAddress,
                                  cursorColor: Colors.green,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Email ID is required. Please Enter.';
                                    } else if (value.trim().length == 0) {
                                      return 'Email ID is required. Please Enter.';
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blueGrey
                                  ),
                                  decoration: InputDecoration(
                                    // filled: true,
                                    // alignLabelWithHint: true,
                                      labelText: "Email ID",
                                      labelStyle: TextStyle(
                                          fontWeight: _Email_focus_node.hasFocus ? FontWeight.bold : FontWeight.normal,
                                          // color: _Email_focus_node.hasFocus ? Color.fromARGB(243, 93, 177, 108) : Colors.black54
                                        // color: Colors.grey
                                      ),
                                      hintText: 'john@example.com',
                                      hintStyle: TextStyle(
                                          color: Colors.grey
                                      ),
                                      isDense: true,
                                      prefixIcon: Icon(Icons.email,size: 22,color: _Email_focus_node.hasFocus ? Color.fromARGB(243, 93, 177, 108) : Colors.black45),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        gapPadding: 4,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(235, 60, 191, 84),
                                              width: 1.5
                                          )
                                      )
                                  ),

                                ),
                                SizedBox(height: 10,),
                                Custom_TextField(),
                                SizedBox(height: 25,),
                                showLoader ? Center(child: CircularProgressIndicator())
                                    :
                                InkWell(
                                    focusNode: _Button_focus_node,
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: (){
                                      _Password_focus_node.unfocus();
                                      _Email_focus_node.unfocus();
                                      FocusScope.of(context).requestFocus(_Button_focus_node);
                                      if (_FormKey.currentState!.validate()) {
                                        showLoader = true;
                                        RegisterUser(context);
                                      }
                                    },
                                    enableFeedback: true,
                                    canRequestFocus: true,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 11),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          // color: Color.fromARGB(97, 32, 194, 53)
                                          color: Color.fromARGB(107, 0, 208, 38),
                                          border: Border.all(color: Colors.black38),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromARGB(97, 29, 144, 58),
                                              blurRadius: 8.0,
                                              spreadRadius: 3.0,
                                            ),
                                          ]
                                      ),
                                      child: Text("Register",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: 15),),
                                    )
                                ),
                                SizedBox(height: 14),
                                Text("By Logging in You accept our Terms & Conditions", style: TextStyle(
                                    fontSize: 12.0, color: Colors.grey, fontWeight: FontWeight.w300),
                                  textAlign: TextAlign.center,),
                                SizedBox(height: 10),
                                InkWell(
                                  onTap: (){
                                    // open the webview for privacy
                                  },
                                  child: Text(
                                    'Privacy Policy',
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.orange, fontWeight: FontWeight.w300, decoration: TextDecoration.underline),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 8),
                                InkWell(
                                  onTap: (){
                                    // open the webview for terms and conditions
                                  },
                                  child: Text(
                                    'Terms & Conditions',
                                    style: TextStyle(
                                      fontSize: 14.0, color: Colors.orange, fontWeight: FontWeight.w300, decoration: TextDecoration.underline,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 12),
                                InkWell(
                                  onTap: (){
                                    Navigator.pushReplacementNamed(context, "/login");
                                  },
                                  child: Text(
                                    'Already a User? Login Here',
                                    style: TextStyle(
                                      fontSize: 18.0, color: Colors.green, fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                                // ElevatedButton(
                                //     style: ButtonStyle(
                                //       backgroundColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                                //       elevation: MaterialStateProperty.all(10),
                                //       enableFeedback: true,
                                //       padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30,vertical: 10)),
                                //     ),
                                //     onPressed: (){},
                                //     child: Text("Login",
                                //       style: TextStyle(
                                //         fontSize: 16.5
                                //       ),
                                //     )
                                // )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}

class Custom_TextField extends StatefulWidget {
  const Custom_TextField({Key? key}) : super(key: key);

  @override
  _Custom_TextFieldState createState() => _Custom_TextFieldState();
}

class _Custom_TextFieldState extends State<Custom_TextField> {

  bool _obscureText = true;

  void toggle(){
    setState(() {
      _obscureText = !_obscureText;
    });
  }


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: (){
        setState(() {
          _Name_focus_node.unfocus();
          _Email_focus_node.unfocus();
          _Button_focus_node.unfocus();
          FocusScope.of(context).requestFocus(_Password_focus_node);
        });
      },
      focusNode: _Password_focus_node,
      obscureText: _obscureText,
      obscuringCharacter: '*',
      controller: PasswordController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Password is required. Please Enter.';
        } else if (value.trim().length < 7) {
          return 'Password must be more than 6 characters.';
        }
        return null;
      },
      style: TextStyle(
          fontSize: 16,
          color: Colors.blueGrey
      ),
      decoration: InputDecoration(
          labelText: "Password",
          hintText: "********",
          hintStyle: TextStyle(
              color: Colors.grey
          ),
          labelStyle: TextStyle(
              fontWeight: _Password_focus_node.hasFocus ? FontWeight.bold : FontWeight.normal,
              // color: _Password_focus_node.hasFocus ? Color.fromARGB(243, 93, 177, 108) : Colors.black54
            // color: Colors.grey
          ),
          prefixIcon: Icon(Icons.password_rounded,size: 22,color: _Password_focus_node.hasFocus ? Color.fromARGB(243, 93, 177, 108) : Colors.black45),
          suffixIcon: _Password_focus_node.hasFocus ? IconButton(
              splashRadius: 20,
              iconSize: 22,
              tooltip: _obscureText ? 'Show Password' : 'Hide Password',
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: (){
                toggle();
                // FocusScope.of(context).unfocus();
              }
          ):null,
          isDense: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              gapPadding: 4,
              borderSide: BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color: Colors.redAccent
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: Color.fromARGB(235, 60, 191, 84),
                  width: 1.5
              )
          )
      ),
    );
  }
}
