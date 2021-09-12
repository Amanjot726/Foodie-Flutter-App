import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Payment_ModesPage extends StatelessWidget {
  const Payment_ModesPage({Key? key}) : super(key: key);

  Future GetPaymentOptions() async{
    var data_snapshot = await EXTRAS_COLLECTION.doc("Payment Modes").get();
    // if (data_snapshot.exists) {
    //   Map<String, dynamic>? data = data_snapshot.data();
    // }
    return data_snapshot;
  }


  @override
  Widget build(BuildContext context) {
    GetPaymentOptions();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        actionsIconTheme: IconThemeData(color: Colors.black),
        title: Row(
          children: [
            Image.asset("assets/Money.png",width: 28,),
            SizedBox(width: 6,),
            Text("SELECT MODE",
              style: TextStyle(
                  color: Color.fromARGB(164, 0, 0, 0),
                  fontFamily: 'AlfaSlabOne',
                  letterSpacing: 1.4,
              ),
            ),
          ],
        ),
        backgroundColor: PRIMARY_COLOR,
      ),
      body: FutureBuilder(
        future: GetPaymentOptions(),
        builder: (BuildContext context,AsyncSnapshot Snapshot) {
          if (Snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var mydata = Snapshot.data;
          Map<String, dynamic>  mdata = mydata.data()['Payment Modes'] as Map<String, dynamic>;
          return ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            children: mdata.keys.map<Widget>((e) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(color: Color.fromARGB(39, 29, 29, 29),width: 1.5)
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11.5)),
                        leading: Image.network(
                          mdata[e],
                          height: 38,
                          width: 38,
                          errorBuilder: (context, error, stackTrace) {
                            return Container();
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            return loadingProgress == null ? child : CupertinoActivityIndicator();
                          },
                        ),
                        title: Text(e),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,size: 16,),
                        onTap: (){
                          Navigator.pop(context,[mdata[e],e]);
                        },
                      ),
                    ),
                  ),
                ],
              );
            }).toList()
          );
        },
      ),
    );
  }
}
