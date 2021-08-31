import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app/Model/Restaurant_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';


XFile? file;
var file_name = "";
bool required_text = false;
FocusNode _Choose_button_focus_node = new FocusNode();

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

class Add_Restaurant_Page extends StatefulWidget {
  Add_Restaurant_Page({Key? key}) : super(key: key);

  @override
  _Add_Restaurant_PageState createState() => _Add_Restaurant_PageState();
}

class _Add_Restaurant_PageState extends State<Add_Restaurant_Page> {
  Color primaryColor = Colors.green;

  TextEditingController Restaurant_Field_Controller = TextEditingController();
  TextEditingController Categories_Field_Controller = TextEditingController();
  TextEditingController Price_Field_Controller = TextEditingController();
  TextEditingController Ratings_Field_Controller = TextEditingController();
  TextEditingController Url_Field_Controller = TextEditingController();

  final _Form_Key = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    Future<String> UploadImage(ImageFile) async {
      Show_Snackbar(context: context, message: "Uploading...",duration: Duration(milliseconds: 1500));
      var uploadTask = await FirebaseStorage.instance.ref('Restaurants/'+Restaurant_Field_Controller.text+"."+file!.name.toString().split(".").last).putFile(ImageFile);
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
            _Form_Key.currentState!.reset();
          });
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        // backgroundColor: Color.fromARGB(235, 220, 245, 234),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          actionsIconTheme: IconThemeData(color: Colors.black),
          title: Text("Add Restaurants",
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
                  physics: BouncingScrollPhysics(),
                  child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                  child: Form(
                    key: _Form_Key,
                    child: Column(
                      children: [
                        SizedBox(height: 3,),
                        Center(
                          child: Image.asset("assets/Restaurants.png",width: 60,)
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Enter restaurants details",
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
                          controller: Restaurant_Field_Controller,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Restaurant name is Required. Please Enter.';
                            }
                            else if (value.trim().length == 0) {
                              return 'Restaurant name is Required. Please Enter.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.restaurant,size: 20,),
                              prefixIconConstraints: BoxConstraints.tightFor(height: 20,width: 45),
                              labelText: "Name of any Restaurant",
                              hintText: "John's cafe",
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
                          keyboardType: TextInputType.text,
                          controller: Categories_Field_Controller,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Category is Required. Please Enter.';
                            }
                            else if (value.trim().length == 0) {
                              return 'Category is Required. Please Enter.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.category,size: 20,),
                              prefixIconConstraints: BoxConstraints.tightFor(height: 20,width: 45),
                              labelText: "Category",
                              hintText: "Cafe",
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
                              labelText: "Price per person",
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
                        // TextFormField(
                        //   keyboardType: TextInputType.text,
                        //   controller: Url_Field_Controller,
                        //   autovalidateMode: AutovalidateMode.onUserInteraction,
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return 'Image URL is Required. Please Enter.';
                        //     }
                        //     else if (value.trim().length == 0) {
                        //       return 'Image URL is Required. Please Enter.';
                        //     }
                        //     return null;
                        //   },
                        //   decoration: InputDecoration(
                        //       prefixIcon: Icon(Icons.link_sharp,size: 21,),
                        //       prefixIconConstraints: BoxConstraints.tightFor(height: 20,width: 45),
                        //       labelText: "Image URL",
                        //       hintText: "https://unsplash.com/image.png",
                        //       hintStyle: TextStyle(
                        //           color: Colors.black26
                        //       ),
                        //       isDense: true,
                        //       contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 14),
                        //       border: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(10)
                        //       )
                        //   ),
                        // ),
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
                          onPressed: () async{
                            if (file==null){
                              setState(() {
                                required_text=true;
                              });
                            }
                            if (_Form_Key.currentState!.validate() && file!=null) {
                              var url = await UploadImage(File(file!.path));
                              // var val = Input_Field_Controller.text;
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => ));
                              Restaurant item = Restaurant(
                                name: Restaurant_Field_Controller.text,
                                category: Categories_Field_Controller.text,
                                price: Price_Field_Controller.text,
                                ratings: Ratings_Field_Controller.text,
                                url: url.toString()
                              );
                              var dataToSave = item.toMap();
                              FirebaseFirestore.instance.collection("Restaurants").doc().set(dataToSave).then((value) {Show_Snackbar(context: context,message: 'Restaurant Added');});
                              setState(() {
                                Restaurant_Field_Controller.clear();
                                Categories_Field_Controller.clear();
                                Price_Field_Controller.clear();
                                Ratings_Field_Controller.clear();
                                file=null;
                                file_name="";
                                _Form_Key.currentState!.reset();
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
                // width: MediaQuery.of(context).size.width/2.8,
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
