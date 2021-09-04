import 'package:first_app/util/constants.dart';
import 'package:flutter/material.dart';



class ManageDeliveryPage extends StatelessWidget {
  const ManageDeliveryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          actionsIconTheme: IconThemeData(color: Colors.black),
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 3.5),
                child: Image.asset("assets/fast-delivery.png",width: 38,height: 39,fit: BoxFit.fill,),
              ),
              SizedBox(width: 8,),
              Text("Deliveries",
                style: TextStyle(
                    color: Color.fromARGB(185, 0, 0, 0),
                    fontFamily: 'AlfaSlabOne',
                    letterSpacing: 1.4
                ),
              ),
            ],
          ),
          backgroundColor: PRIMARY_COLOR,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "No Deliveries Yet !!!",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color.fromARGB(255, 238, 176, 39),
                  fontSize: 16.5,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        )
    );
  }
}
