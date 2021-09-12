import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';



class Show_Acknowledgement extends StatelessWidget {
  String? Title;
  String? Message;
  bool? Flag;
  Show_Acknowledgement({Key? key,this.Title, this.Message, this.Flag}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            // padding: EdgeInsets.only(right: 2),
                            height: 42,
                            width: 42,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 224, 224, 224),
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(29, 0, 0, 0),
                                  blurRadius: 3.0,
                                  spreadRadius: 3.0,
                                  offset: Offset(
                                    -0.0,
                                    1.0,
                                  ),
                                ),
                              ]
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.angleLeft,
                              color: Color.fromARGB(255, 73, 73, 73),
                              // size: 17,
                            ),
                          ),
                          onTap: (){
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ]
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/8.3,),
              Flag! ?
                Lottie.asset(
                  "assets/Success.json",
                  // frameRate: FrameRate(200),
                  repeat: false,
                  height: 180,
                  width: 180,
                )
                  :
                Lottie.asset(
                  "assets/Failed.json",
                  repeat: false,
                  height: 180,
                  width: 180,
                ),
              SizedBox(height: 6,),
              Text(Title!,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Flag! ? Colors.green : Colors.red,
                  fontFamily: 'FredokaOne',
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Message!,
                  textAlign: TextAlign.center,
                  // maxLines: 2,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 85, 85, 85),
                    letterSpacing: 0.7,
                  ),
                ),
              ),
              Divider(
                height: 50,
                indent: MediaQuery.of(context).size.width/3.5,
                endIndent: MediaQuery.of(context).size.width/3.5,
                thickness: 0.7,
              ),
              SizedBox(height: 10,),

            ],
          ),
        ),
      ),
    );
  }
}
