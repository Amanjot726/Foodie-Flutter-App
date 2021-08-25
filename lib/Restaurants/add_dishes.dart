import 'dart:ffi';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app/Model/Dishes_data.dart';
import 'package:first_app/Model/Restaurant_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';



Color primaryColor = Colors.green;
XFile? file;
var file_name = "";

int _value = 0;
bool required_text = false;

TextEditingController Dish_Field_Controller = TextEditingController();
TextEditingController Discount_Field_Controller = TextEditingController();
TextEditingController Price_Field_Controller = TextEditingController();
TextEditingController Ratings_Field_Controller = TextEditingController();

FocusNode _Choose_button_focus_node = new FocusNode();
FocusNode _Save_button_focus_node = new FocusNode();

final _dishes_Form_Key = GlobalKey<FormState>();



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

class Add_dishes extends StatefulWidget {
  String restaurantId;
  String restaurantName;
  Add_dishes({Key? key,required this.restaurantId,required this.restaurantName}) : super(key: key);

  @override
  _Add_dishesState createState() => _Add_dishesState();
}

class _Add_dishesState extends State<Add_dishes> {
  @override
  Widget build(BuildContext context) {

    Future<String> UploadImage(ImageFile) async {
      Show_Snackbar(context: context, message: "Uploading...",duration: Duration(milliseconds: 1500));
      var uploadTask = await FirebaseStorage.instance.ref('Dishes/'+widget.restaurantName+"_"+Dish_Field_Controller.text+"."+file!.name.toString().split(".").last).putFile(ImageFile);
      Show_Snackbar(context: context, message: "Uploaded",duration: Duration(milliseconds: 1500));
      String downlaodUrl = await uploadTask.ref.getDownloadURL();
      return downlaodUrl;
    }

    return WillPopScope(
      onWillPop: () async {
        setState(() {
          required_text = false;
          file=null;
          file_name="";
          _dishes_Form_Key.currentState!.reset();
        });
        return true;
      },
      child: Scaffold(
        // backgroundColor: Color.fromARGB(235, 220, 245, 234),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            actionsIconTheme: IconThemeData(color: Colors.black),
            title: Text("Add Dishes",
              style: TextStyle(
                  color: Color.fromARGB(185, 0, 0, 0),
                  fontFamily: 'AlfaSlabOne',
                  letterSpacing: 1.4
              ),
            ),
            backgroundColor: primaryColor,
          ),
          body: GestureDetector(
            onTap: (){
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 2),
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
                        borderRadius: BorderRadius.circular(20.0),
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                            child: Form(
                              key: _dishes_Form_Key,
                              child: Column(
                                children: [
                                  SizedBox(height: 3,),
                                  Center(
                                      child: Image.asset("assets/Restaurants.png",width: 60,)
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Enter dishes for "+widget.restaurantName,
                                        style: TextStyle(
                                          // color: Colors.yellow[800],
                                          // color: Color.fromARGB(255, 236, 186, 80),
                                            color: Color.fromARGB(255, 238, 176, 39),
                                            fontWeight: FontWeight.bold
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 25,),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: Dish_Field_Controller,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Dish name is Required. Please Enter.';
                                      }
                                      else if (value.trim().length == 0) {
                                        return 'Dish name is Required. Please Enter.';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.restaurant_menu,size: 20,),
                                        prefixIconConstraints: BoxConstraints.tightFor(height: 20,width: 45),
                                        labelText: "Name of Dish",
                                        hintText: "Shahi Paneer",
                                        hintStyle: TextStyle(
                                            color: Colors.black26
                                        ),
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 14),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        )
                                    ),
                                  ),
                                  SizedBox(height: 12,),
                                  Customs(),
                                  SizedBox(height: 12,),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny("-"),
                                      FilteringTextInputFormatter.deny(" "),
                                      FilteringTextInputFormatter.deny(","),
                                    ],
                                    controller: Price_Field_Controller,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Price is Required. Please Enter.';
                                      }
                                      else if (value.trim().length == 0) {
                                        return 'Price is Required. Please Enter.';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 18.4,vertical: 0),
                                          child: Text("₹",
                                            style: TextStyle(
                                                color: Colors.black45,
                                                fontSize: 21,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                        prefixIconConstraints: BoxConstraints.tightFor(height: 20,width: 46.5),
                                        labelText: "Price",
                                        hintText: "75",
                                        hintStyle: TextStyle(
                                            color: Colors.black26
                                        ),
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 14),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        )
                                    ),
                                  ),
                                  SizedBox(height: 12,),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny("-"),
                                      FilteringTextInputFormatter.deny(" "),
                                      FilteringTextInputFormatter.deny(","),
                                    ],
                                    controller: Ratings_Field_Controller,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Ratings Required. Please Enter.';
                                      }
                                      else if (value.trim().length == 0) {
                                        return 'Ratings Required. Please Enter.';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.stars,size: 20,),
                                        prefixIconConstraints: BoxConstraints.tightFor(height: 20,width: 45),
                                        labelText: "Ratings",
                                        hintText: "3.7",
                                        hintStyle: TextStyle(
                                            color: Colors.black26
                                        ),
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 14),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        )
                                    ),
                                  ),
                                  SizedBox(height: 12,),
                                  ImagePickerWidget(),
                                  SizedBox(height: 15,),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(vertical: 12,horizontal: 45),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        )
                                    ),
                                    child: Text("Save",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Merriweather'
                                      ),
                                    ),
                                    onPressed: () async {
                                      _Save_button_focus_node.requestFocus();
                                      // Show_Snackbar(context: context,message: file==null?"true":"false");

                                      if (file==null){
                                        setState(() {
                                          required_text=true;
                                        });
                                      }
                                      if (_dishes_Form_Key.currentState!.validate() && file!=null) {
                                        var flat_discount = 0;
                                        var percentage_discount = 0;

                                        var url = await UploadImage(File(file!.path));
                                        // Show_Snackbar(context: context, message: url,duration: Duration(seconds: 1));

                                        if (_value==1){
                                          flat_discount = int.parse(Discount_Field_Controller.text);
                                        }
                                        else if(_value==2){
                                          percentage_discount = int.parse(Discount_Field_Controller.text);
                                        }

                                        Add_Dishes Dish = Add_Dishes(
                                            name: Dish_Field_Controller.text,
                                            discount_type: _value,
                                            flatDiscount: flat_discount,
                                            percentageDiscount: percentage_discount,
                                            price: double.parse(Price_Field_Controller.text),
                                            ratings: double.parse(Ratings_Field_Controller.text),
                                            imageURL: url.toString()
                                        );
                                        var dataToSave = Dish.toMap();
                                        Show_Snackbar(context: context,message: 'Saving Dish...',duration: Duration(seconds: 2));
                                        FirebaseFirestore.instance.collection("Restaurants").doc(widget.restaurantId).collection("Dishes").doc().set(dataToSave).then((value) {
                                          Show_Snackbar(context: context,message: 'Dish Added');
                                        });
                                        setState(() {
                                          Dish_Field_Controller.clear();
                                          _value=0;
                                          Discount_Field_Controller.clear();
                                          Price_Field_Controller.clear();
                                          Ratings_Field_Controller.clear();
                                          file=null;
                                          file_name="";
                                          _dishes_Form_Key.currentState!.reset();
                                        });
                                      }
                                    },
                                  ),
                                  SizedBox(height: 15,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                )
            ),
          )
      ),
    );
  }
}




class Customs extends StatefulWidget {
  const Customs({Key? key}) : super(key: key);

  @override
  _CustomsState createState() => _CustomsState();
}

class _CustomsState extends State<Customs> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // width: MainAxisSize.max,
          height: 44,
          padding:
          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black38,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              focusNode: _Choose_button_focus_node,
              focusColor: primaryColor,
              value: _value,
              items: [
                DropdownMenuItem(
                  child: Text("No Discount"),
                  value: 0,
                ),
                DropdownMenuItem(
                  child: Text("Flat Discount"),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text("Percentage Discount"),
                  value: 2,
                )
              ],
              style:TextStyle(color: Color.fromARGB(148, 0, 0, 0), fontSize: 16),
              icon: Icon(Icons.arrow_drop_down_circle,color: Colors.black45,),
              // iconSize: 26,
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                    _value = value as int;
                });
              },
              onTap: ()=>_Choose_button_focus_node.requestFocus(),
            ),
          )
        ),
        SizedBox(height: 12,),
        TextFormField(
          keyboardType: TextInputType.number,
          controller: Discount_Field_Controller,
          // autovalidateMode: _value==0?AutovalidateMode.disabled:AutovalidateMode.onUserInteraction,
          inputFormatters: [
            FilteringTextInputFormatter.deny("-"),
            FilteringTextInputFormatter.deny(" "),
            FilteringTextInputFormatter.deny(","),
          ],
          validator: (value) {
            if (_value!=0 && value!.isEmpty) {
              return 'Discount is Required. Please Enter.';
            }
            else if (_value!=0 && value!.trim().length == 0) {
              return 'Discount is Required. Please Enter.';
            }
            return null;
          },
          enabled: _value==0?false:true,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.local_offer_rounded,size: 20,),
              prefixIconConstraints: BoxConstraints.tightFor(height: 20,width: 45),
              labelText: "Discount",
              hintText: "20",
              hintStyle: TextStyle(
                  color: Colors.black26
              ),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 14),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
              )
          ),
        ),
      ],
    );
  }
}




class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {

  final ImagePicker Image_Picker = ImagePicker();


  Show_required(){
    setState(() {
      required_text = true;
    });
  }

  _show_Dialog_Box(BuildContext dialogContext) async {
    return showDialog(
      context: dialogContext,
      builder: (dialogContext) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
          title: Text(
            'Choose Option',
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
                file = await Image_Picker.pickImage(source: ImageSource.camera);
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

    return Column(
      children: [
        Container(
          height: 44,
          padding:
          EdgeInsets.symmetric(horizontal: 11, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: required_text==true?Colors.red[700]!:Colors.black38,
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.image,color: Colors.black45,size: 20,),
              SizedBox(width: 13,),
              Expanded(
                flex: 17,
                // width: MediaQuery.of(context).size.width/2.6,
                child: Text(
                  file_name==""?"Select Image":file_name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(148, 0, 0, 0),
                      fontSize: 16
                  ),
                ),
              ),
              Spacer(),
              OutlinedButton(
                  child: Text("CHOOSE"),
                  onPressed: () async{
                    await _show_Dialog_Box(context);
                    setState((){
                      file_name = file!.name.toString().replaceAll("image_picker", "Image_");
                      file!=null?required_text=false:required_text=true;
                    });
                  }
              ),
            ],
          ),
        ),
        required_text==true?
        Padding(
          padding: const EdgeInsets.only(top: 6,left: 15),
          child: Row(
            children: [
              Text("Image is Required. Please Choose a Image.",
                style: TextStyle(
                  color: Colors.red[700],
                  fontSize: 12,
                ),
              )
            ],
          ),
        )
            :
        Container()
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
