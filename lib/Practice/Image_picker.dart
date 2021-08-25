import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class Show_Snackbar{
  String message;
  BuildContext context;
  Show_Snackbar({required this.context,required this.message}){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(this.message.toString()),
      duration: Duration(seconds: 3),
    )
    );
  }
}

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {

  XFile? file;
  final ImagePicker Image_Picker = ImagePicker();

  ChooseImage_G() async {
    XFile? file = await Image_Picker.pickImage(source: ImageSource.gallery);
    setState(() {
      this.file = file;
    });
    return file;
  }
  Future<String> UploadImage(ImageFile) async {
    Show_Snackbar(context: context, message: "Uploading...");
    var uploadTask = await FirebaseStorage.instance.ref('profile-pics/'+"23dfdew23212"+'.png').putFile(ImageFile);
    Show_Snackbar(context: context, message: "Uploaded");
    String downlaodUrl = await uploadTask.ref.getDownloadURL();
    return downlaodUrl;
  }

  Future<String> handleUpdateUserProfile() async {
    Show_Snackbar(context: context, message: "start");
    var url = await ChooseImage_G();
    String mediaUrl = await UploadImage(url!.path); // Pass your file variable
    Show_Snackbar(context: context, message: "end");
    return mediaUrl;
    // Create/Update firesotre document
    // usersRef.document(userId).updateData(
    //     {
    //       "avatar": mediaUrl,
    //     }
    // );
  }

  var file_name = "";


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding:
      EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black38,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.image,color: Colors.black45,size: 20,),
          SizedBox(width: 13,),
          SizedBox(
            width: 150,
            child: Text(
              file_name==""?"Select Image":file_name,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              textWidthBasis: TextWidthBasis.parent,
              style: TextStyle(
                  color: Color.fromARGB(148, 0, 0, 0),
                  fontSize: 16
              ),
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          Spacer(),
          OutlinedButton(
              child: Text("CHOOSE"),
              style: ButtonStyle(

              ),
              onPressed: () async{
                var file = await ChooseImage_G();
                setState(() {
                  file_name = file.name.toString().replaceAll("image_picker", "Image_edadasdad");
                });
                var url = await UploadImage(File(file!.path));
                Show_Snackbar(context: context, message: url);
              }
          )
        ],
      ),
    );
  }
}


