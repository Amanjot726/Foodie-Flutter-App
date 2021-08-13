import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';


FocusNode _Email_focus_node = new FocusNode();
FocusNode _Password_focus_node = new FocusNode();
FocusNode _Button_focus_node = new FocusNode();
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


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  void authenticateUser(BuildContext context) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginIDController.text.trim(),
          password: PasswordController.text.trim()
      );

      print("User ID is:"+userCredential.user!.uid.toString());

      if(userCredential.user!.uid.toString().isNotEmpty){
        Navigator.pushReplacementNamed(context, "/home");
      }else{
        Show_Snackbar(context: context,message: "Login Failed");
      }


    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Show_Snackbar(context: context,message: "No user found for this email");
        print('No user found for this email.');
      }
      else if (e.code == 'wrong-password') {
        Show_Snackbar(context: context,message: "Login Failed! Wrong password");
        print('Wrong password provided for that user.');
      }
      else{
        // print(e.message);
        print('Failed with error code: ${e.code}');
        Show_Snackbar(context: context,message: e.code.toString());
      }
    }
  }


  final _FormKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          _Email_focus_node.unfocus();
          _Password_focus_node.unfocus();
          _Button_focus_node.unfocus();
          FocusScope.of(context).requestFocus(new FocusNode());
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
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Login",
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
            Align(
              alignment: Alignment.center,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 20,
                semanticContainer: false,
                // margin: EdgeInsets.symmetric(horizontal: card_horizontal_margin,vertical: card_vertical_margin),
                child: SingleChildScrollView(
                  child: Container(
                    // height: MediaQuery.of(context).size.height/2.5,
                    width: MediaQuery.of(context).size.width/1.2,
                    padding: EdgeInsets.all(20),
                    child: Form(
                      key: _FormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 8,),
                          TextFormField(
                            onTap: (){
                              setState(() {
                                _Password_focus_node.unfocus();
                                FocusScope.of(context).requestFocus(_Email_focus_node);
                              });
                            },
                            focusNode: _Email_focus_node,
                            controller: loginIDController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            enabled: true,
                            autofocus: false,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.green,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Login ID is required. Please Enter.';
                              } else if (value.trim().length == 0) {
                                return 'Login ID is required. Please Enter.';
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
                          SizedBox(height: 12,),
                          Custom_TextField(),
                          SizedBox(height: 20,),
                          InkWell(
                              focusNode: _Button_focus_node,
                              borderRadius: BorderRadius.circular(10),
                              onTap: (){
                                _Password_focus_node.unfocus();
                                _Email_focus_node.unfocus();
                                FocusScope.of(context).requestFocus(_Button_focus_node);
                                if (_FormKey.currentState!.validate()) {
                                  authenticateUser(context);
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
                                child: Text("Login",style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold,fontSize: 15),),
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
                          SizedBox(height: 10),
                          InkWell(
                            onTap: (){
                              Navigator.pushReplacementNamed(context, "/register");
                            },
                            child: Text(
                              'New User? Register Here',
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
          _Email_focus_node.unfocus();
          FocusScope.of(context).requestFocus(_Password_focus_node);
        });
      },
      focusNode: _Password_focus_node,
      obscureText: _obscureText,
      obscuringCharacter: '*',
      controller: PasswordController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Password is required. Please Enter.';
        } else if (value.trim().length < 7) {
          return 'Password must be more than 6 characters.';
        }
        return null;
      },
      style: TextStyle(
        fontFamily: 'SourceCodePro',
        fontSize: 16,
        color: Colors.blueGrey
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        alignLabelWithHint: true,
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
        prefixIcon: Icon(
            Icons.password_rounded,
            size: 22,
            // color: _Password_focus_node.hasFocus ? Color.fromARGB(243, 93, 177, 108) : Colors.black45
        ),
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
