import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


final _FormKey = GlobalKey<FormState>();
TextEditingController Input_Field_Controller = TextEditingController();


class Input_Bricks_Page extends StatelessWidget {
  const Input_Bricks_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Construct a wall"),
        backgroundColor: Colors.green,
        elevation: 10,
      ),
      body: Form(
        key: _FormKey,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/3.5,),
            Text("Input No. of Bricks",
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Merriweather'
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: Container(
                // width: 220,
                width: MediaQuery.of(context).size.width/1.784,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: Input_Field_Controller,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Some Number is Required. Please Enter.';
                    }
                    else if (value.trim().length == 0) {
                      return 'Some Number is Required. Please Enter.';
                    }
                    else if (int.parse(value)>=10000){
                      return 'Please Enter Value Smaller Than 10000';
                    }
                    else if (int.parse(value)==0){
                      return 'Please Enter Value Greater Than 0';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Container(
                      width: 15,
                      height: 8,
                      padding: EdgeInsets.symmetric(horizontal: 4.5,vertical: 2.6),
                      margin: EdgeInsets.symmetric(horizontal: 9,vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.black38
                      ),
                      child: Text('123',
                        style: TextStyle(
                          fontSize: 12,
                          letterSpacing: 0.9,
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    labelText: "Enter a number",
                    hintText: "13",
                    hintStyle: TextStyle(
                      color: Colors.black26
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                ),
              ),
            ),
            SizedBox(height: 35,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12,horizontal: 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )
              ),
              child: Text("Start",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Merriweather'
                ),
              ),
              onPressed: (){
                if (_FormKey.currentState!.validate()) {
                  var val = Input_Field_Controller.text;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => John_Jack_Bricks_Page(Total_Bricks: int.parse(val))));
                  _FormKey.currentState!.reset();
                }
              },
            )
          ],
        )
      )
    );
  }
}



class John_Jack_Bricks_Page extends StatelessWidget {

  int Total_Bricks;

  John_Jack_Bricks_Page({Key? key,required this.Total_Bricks}) : super(key: key);

  int john = 0,jack = 0,Bricks_done = 0,selected_no = 0;
  var data = [];
  var Doc = [];

  Collection() {

    for (int Loop = 0; Bricks_done < Total_Bricks; Loop++) {
      if (Loop % 2 == 0) {
        if ((Bricks_done + selected_no + 1) < Total_Bricks) {
          data = ["John", "${selected_no}+1", "${selected_no + 1}", "${Bricks_done}+${selected_no + 1}", "${Bricks_done + selected_no + 1}"];
          Bricks_done += selected_no + 1;
        }
        else {
          data = ["John", "${selected_no}+1", "${selected_no + 1}", "${Bricks_done}+${Total_Bricks - Bricks_done}", "${Bricks_done + Total_Bricks - Bricks_done}"];
          Bricks_done += Total_Bricks - Bricks_done;
        }
        john += 1;
        selected_no += 1;
      }
      else {
        if ((Bricks_done + selected_no * 2) < Total_Bricks) {
          data = ["Jack", "${selected_no}*2", "${selected_no * 2}", "${Bricks_done}+${selected_no * 2}", "${Bricks_done + selected_no * 2}"];
          Bricks_done += selected_no * 2;
        }
        else {
          data = ["Jack", "${selected_no}*2", "${selected_no * 2}", "${Bricks_done}+${Total_Bricks - Bricks_done}", "${Bricks_done + Total_Bricks - Bricks_done}"];
          Bricks_done += Total_Bricks - Bricks_done;
        }
        jack += 1;
      }
      Doc.add(data);
    }
    return Doc.map((Document)=>
        DataRow(
          cells: [
            DataCell(
              Center(
                child:Text(
                  Document[0],
                  textAlign: TextAlign.center,
                )
              )
            ),
            DataCell(
              Center(
                child:Text(
                  Document[1]+" = "+Document[2],
                  textAlign: TextAlign.center,
                )
              )
            ),
            DataCell(
              Center(
                child:Text(
                  Document[3]+" = "+Document[4],
                  textAlign: TextAlign.center,
                )
              )
            ),
          ]
        )
    ).toList();
  }

  getBricksinlast(){
    try{return (int.parse(Doc[Doc.length-1][Doc[Doc.length-1].length-1])-int.parse(Doc[Doc.length-2][Doc[Doc.length-1].length-1])).toString();}
    catch(e){return int.parse(Doc[Doc.length-1][Doc[Doc.length-1].length-1]).toString();}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Construct a wall"),
        backgroundColor: Colors.green,
        elevation: 10,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(13),
          children: [
            SizedBox(height: 20,),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: DataTable(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 4
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(0),bottom: Radius.circular(10))
                ),
                headingRowColor: MaterialStateColor.resolveWith((states) => Colors.black12),
                columns: [
                  DataColumn(
                    tooltip: "Name of Person who has its turn",
                    label: Text('Name',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      )
                    )
                  ),
                  DataColumn(
                    tooltip: "\nJohn Increment number by 1\n\n Jack Doubles the number\n",
                    label: Text('Calculate',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      )
                    )
                  ),
                  DataColumn(
                    tooltip: "\nNo. of Bricks to add to \n\nthe wall by John/Jack\n",
                    label: Text('Total Bricks',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      )
                    )
                  ),
                ],
                rows: Collection()
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Conclusions :",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      SizedBox(width: 5,),
                      Text("1) Total Turns of :\n\n"),
                      Text("\n"+"\t"*2+"John = ${john}\n"+"\t"*2+"Jack = ${jack}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(height: 6,),
                  Row(
                    children: [
                      SizedBox(width: 5,),
                      Text("2) Who Placed the last Brick = "),
                      Text(Doc[Doc.length-1][0],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 6,),
                  Row(
                    children: [
                      SizedBox(width: 5,),
                      Text("3) How many bricks placed in last turn = "),
                      Text(getBricksinlast(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}

