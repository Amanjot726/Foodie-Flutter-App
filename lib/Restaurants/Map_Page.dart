import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/Restaurants/add_restaurants.dart';
import 'package:first_app/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

FocusNode _Choose_button_focus_node = new FocusNode();
final _FormKey = GlobalKey<FormState>();
TextEditingController Label_Field_Controller = TextEditingController();

bool Minimize = false;

class Find_Address_From_Map extends StatefulWidget {
  const Find_Address_From_Map({Key? key}) : super(key: key);

  @override
  _Find_Address_From_MapState createState() => _Find_Address_From_MapState();
}

class _Find_Address_From_MapState extends State<Find_Address_From_Map> {


  Save_data()async{
    var label = _value=="Custom label" ? Label_Field_Controller.text : _value;

    String addres = address!=null? (address!.streetAddress.toString()+", "+address!.region.toString()+", "+address!.countryName.toString()+", "+address!.postal.toString() ).split(" ").map((str) => str.toString()[0].toUpperCase()+str.toString().substring(1)).join(" ") : "";
    Map mape = {"Address-"+(ADDRESSES.length+1).toString() : {"Address Type": label,"GeoPoint": GeoPoint(28.9122326, 75.6090934),"Address":addres,},};
    ADDRESSES["Address-"+(ADDRESSES.length+1).toString()] = {"Address Type": label,"GeoPoint": GeoPoint(28.9122326, 75.6090934),"Address":addres,};
    Show_Snackbar(context: context, message: mape.toString(), duration: Duration(seconds: 5));
    await FirebaseFirestore.instance.collection("users").doc(get_Uid()).set({"address" : ADDRESSES},SetOptions(merge: true));

    Show_Snackbar(context: context, message: "Address Saved");
  }


  Location location = new Location();
  var latitude;
  var longitude;
  Address? address;
  GeoCode geoCode = GeoCode();
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? newGoogleMapController;

  CameraPosition initPlace = CameraPosition(
    target: LatLng(28.9122326, 75.6090934),
    zoom: 16,
  );

  checkPermissionsAndFetchLocation() async{

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    latitude = _locationData!.latitude;
    longitude = _locationData!.longitude;

    // final coordinates = new Coordinates(1.10, 45.50);
    var Address = await geoCode.reverseGeocoding(latitude: _locationData!.latitude as double, longitude: _locationData!.longitude as double);


    setState(() {
      address = Address;
      initPlace = CameraPosition(
        target: LatLng(_locationData!.latitude!, _locationData!.longitude!),
        zoom: 18,
      );
      newGoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(initPlace));
    });

  }

  SetMarker(lat,lng) async{

    // _serviceEnabled = await location.serviceEnabled();
    // if (!_serviceEnabled!) {
    //   _serviceEnabled = await location.requestService();
    //   if (!_serviceEnabled!) {
    //     return;
    //   }
    // }
    //
    // _permissionGranted = await location.hasPermission();
    // if (_permissionGranted == PermissionStatus.denied) {
    //   _permissionGranted = await location.requestPermission();
    //   if (_permissionGranted != PermissionStatus.granted) {
    //     return;
    //   }
    // }

    // _locationData = await location.getLocation();

    latitude = lat;
    longitude = lng;

    // final coordinates = new Coordinates(1.10, 45.50);
    var Address = await geoCode.reverseGeocoding(latitude: lat as double, longitude: lng as double);


    setState(() {
      address = Address;
      initPlace = CameraPosition(
        target: LatLng(lat, lng),
        zoom: 18,
      );
      newGoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(initPlace));
    });

  }
  // var check = true;

  funcd(){
    setState(() {
      if (Minimize == true){
        Minimize = false;
      }
      else{
        Minimize = true;
      }
    });
  }

  double xPosition = -0;
  double yPosition = -0;




  @override
  Widget build(BuildContext context) {
    checkPermissionsAndFetchLocation();
    var Device_height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          iconTheme: IconThemeData(color: Colors.black),

          actionsIconTheme: IconThemeData(color: Colors.black),
          title: Text("Add Address",
            style: TextStyle(
              color: Color.fromARGB(185, 0, 0, 0),
              fontFamily: 'AlfaSlabOne',
              letterSpacing: 1.4
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: (){
        //     Navigator.pushReplacementNamed(context, "/fetch_location");
        //   },
        //   backgroundColor: PRIMARY_COLOR,
        //   child: Icon(
        //     Icons.add,
        //     color: Colors.white,
        //   ),
        // ),
        body: StreamBuilder<Object>(
            stream: location.onLocationChanged,
            builder: (BuildContext context,AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "SOMETHING WENT WRONG!!!",
                    style: TextStyle(color: Colors.red[200]),
                  ),
                );
              }
              // if(snapshot.connectionState == ConnectionState.waiting) {
              //   return Center(
              //     child: CircularProgressIndicator(),
              //   );
              // }
              // checkPermissionsAndFetchLocation();
              return GestureDetector(
                onTap: (){
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Stack(fit: StackFit.passthrough,
                  children: [
                    GoogleMap(
                      padding: Device_height<650 ? EdgeInsets.only(bottom: 25) : EdgeInsets.only(bottom: 0),
                      initialCameraPosition: initPlace,
                      mapType: MapType.normal,
                      myLocationButtonEnabled: true,
                      trafficEnabled: true,
                      myLocationEnabled: true,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: false,
                      compassEnabled: true,
                      scrollGesturesEnabled: true,
                      rotateGesturesEnabled: true,
                      mapToolbarEnabled: false,
                      onMapCreated: (GoogleMapController controller) {
                        checkPermissionsAndFetchLocation();
                        _controller.complete(controller);
                        newGoogleMapController = controller;
                      },
                      // onTap: (latlng){
                      //   setState(() {
                      //     SetMarker(latlng.latitude, latlng.longitude);
                      //   });
                      // },
                    markers: {
                      Marker(
                        markerId: MarkerId('atpl'),
                        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                        onTap: (){},
                        position: LatLng(_locationData!=null ? latitude as double : 28.9122326, _locationData!=null? longitude as double : 75.6090934),
                        // position: _locationData!=null? LatLng(_locationData!.latitude!, _locationData!.longitude!): LatLng(30.9024779, 75.8201934),
                        infoWindow: InfoWindow(
                          title: address!=null? address!.streetAddress.toString()+", "+address!.region.toString() : "",
                          snippet: address!=null? address!.countryName: "",
                          onTap: (){},
                        ),
                      ),
                    },
                  ),
                  Positioned(
                    bottom: yPosition,
                    left: xPosition,
                    right: xPosition,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0,right: 20,left: 20),
                        child: AnimatedContainer(
                          // width: MediaQuery.of(context).size.width-MediaQuery.of(context).size.width/7,
                          height: Minimize ? 40 : 230,
                          duration: Duration(milliseconds: 400),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(96, 26, 26, 26),
                                blurRadius: 4.0,
                                spreadRadius: 3.0,
                                offset: Offset(
                                  -0.0,
                                  1.0,
                                ),
                              ),
                            ]
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SingleChildScrollView(
                              physics: Minimize ? NeverScrollableScrollPhysics() : BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 3.0),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: GestureDetector(
                                              onVerticalDragStart: (tapInfo) {
                                                setState(() {
                                                  var Device_height = MediaQuery.of(context).size.height;
                                                  // xPosition += tapInfo.delta.dx;
                                                  if(yPosition<0.0){
                                                    yPosition = 0;
                                                  }
                                                  // else if(yPosition > Device_height / (Device_height<650 ? 2.2 : 1.68)){
                                                  //   yPosition = Device_height / (Device_height<650 ? 2.2 : 1.68);
                                                  // }
                                                  else{
                                                    yPosition += -tapInfo.globalPosition.dy;
                                                  }
                                                });
                                              },
                                              onVerticalDragUpdate: (tapInfo) {
                                                setState(() {
                                                  // xPosition += tapInfo.delta.dx;
                                                  if(yPosition<0.0){
                                                    yPosition = 0;
                                                  }
                                                  // else if(yPosition > Device_height / (Device_height<650 ? 2.2 : 1.68)){
                                                  //   yPosition = Device_height / (Device_height<650 ? 2.2 : 1.68);
                                                  // }
                                                  else{
                                                    yPosition += -tapInfo.delta.dy;
                                                  }
                                                });
                                              },
                                              onPanStart: (tapInfo) {
                                                setState(() {
                                                  var Device_height = MediaQuery.of(context).size.height;
                                                  // xPosition += tapInfo.delta.dx;
                                                  if(yPosition<0.0){
                                                    yPosition = 0;
                                                  }
                                                  // else if(yPosition > Device_height / (Device_height<650 ? 2.2 : 1.68)){
                                                  //   yPosition = Device_height / (Device_height<650 ? 2.2 : 1.68);
                                                  // }
                                                  else{
                                                    yPosition += -tapInfo.localPosition.dy;
                                                  }
                                                });
                                              },
                                              onPanUpdate: (tapInfo) {
                                                setState(() {
                                                  var Device_height = MediaQuery.of(context).size.height;
                                                  // xPosition += tapInfo.delta.dx;
                                                  if(yPosition<0.0){
                                                    yPosition = 0;
                                                  }
                                                  // else if(yPosition > Device_height / (Device_height<650 ? 2.2 : 1.68)){
                                                  //   yPosition = Device_height / (Device_height<650 ? 2.2 : 1.68);
                                                  // }
                                                  else{
                                                    yPosition += -tapInfo.delta.dy;
                                                  }
                                                });
                                              },
                                              onTap: () {
                                              },
                                              // onPanEnd: (tapInfo) {
                                              //   Show_Snackbar(context: context,message: yPosition.toString()+", hieght = "+(MediaQuery.of(context).size.height/1.68).toString(),duration: Duration(milliseconds: 800));
                                              // },
                                              // onVerticalDragEnd: (tapInfo) {
                                              //   Show_Snackbar(context: context,message: yPosition.toString(),duration: Duration(milliseconds: 100));
                                              // },
                                              child: SizedBox(
                                                width: 130,
                                                height: 36,
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(vertical: 15.3,horizontal: 30),
                                                  // width: 40,
                                                  // height: 3,
                                                  // margin: EdgeInsets.only(top: ),
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      border: Border.all(width: 3.3,color: Colors.grey,),
                                                      borderRadius: BorderRadius.circular(50)
                                                  ),
                                                ),
                                              ),
                                          )
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          margin: EdgeInsets.only(top: 4,right: 6),
                                          child: Material(
                                            borderRadius: BorderRadius.circular(50),
                                            child: InkWell(
                                              canRequestFocus: true,
                                              borderRadius: BorderRadius.circular(20),
                                              child: Padding(
                                                padding: const EdgeInsets.all(4),
                                                child: Icon(
                                                  Minimize ?  Icons.open_in_full_rounded : Icons.close_fullscreen_rounded,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              onTap: (){
                                                FocusScope.of(context).requestFocus(new FocusNode());
                                                funcd();
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          // width: MediaQuery.of(context).size.width-MediaQuery.of(context).size.width/7,
                                          // height: Minimize ? 0 : null,
                                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/10,vertical: 7),
                                          child: Form(
                                            key: _FormKey,
                                            child: Column(
                                              children: [
                                                // SizedBox(height: 5,),
                                                // .split(" ").map((str) => str.capitalize).join(" ")
                                              // address!=null? address!.streetAddress.toString()[0].toUpperCase()+address!.streetAddress.toString().substring(1)+", "+address!.region.toString()+", "+address!.countryName.toString()+", "+address!.postal.toString()
                                                Text(
                                                  address!=null?
                                                  ( address!.streetAddress.toString()+", "+address!.region.toString()+", "+address!.countryName.toString()+", "+address!.postal.toString() ).split(" ").map((str) => str.toString()[0].toUpperCase()+str.toString().substring(1)).join(" ")
                                                    :
                                                  "",
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 15.5,
                                                    color: Color.fromARGB(245, 50, 50, 50),
                                                  ),
                                                ),
                                                SizedBox(height: 8,),
                                                Customs(),
                                                SizedBox(height: 8,),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: MediaQuery.of(context).size.width/8),
                                                    primary: Color.fromARGB(255, 29, 180, 31),
                                                    textStyle: TextStyle(
                                                      fontSize: 16.5
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(12),
                                                    )
                                                  ),
                                                  onPressed: (){
                                                    if (_FormKey.currentState!.validate() && latitude!=null && longitude!=null) {
                                                      Save_data();
                                                    };
                                                  },
                                                  child: Text("Save Address")
                                                ),
                                                SizedBox(height: 5,),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                )
                  ],
                ),
              );
          }
        ),
    );
  }
}


String _value = "Choose";

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
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                // focusColor: primaryColor,
                value: _value,
                items: [
                  DropdownMenuItem(
                    child: Text("Choose"),
                    value: "Choose",
                    onTap: (){
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                  ),
                  DropdownMenuItem(
                    child: Text("Home"),
                    value: "Home",
                  ),
                  DropdownMenuItem(
                    child: Text("Work"),
                    value: "Work",
                  ),
                  DropdownMenuItem(
                    child: Text("Custom label"),
                    value: "Custom label",
                  )
                ],
                style:TextStyle(color: Color.fromARGB(148, 0, 0, 0), fontSize: 16),
                icon: Icon(Icons.arrow_drop_down_circle,color: Colors.black45,),
                // iconSize: 26,
                isExpanded: true,
                onChanged: (value) {
                  setState(() {
                    _value = value as String;
                  });
                },
                // onTap: ()=>_Choose_button_focus_node.requestFocus(),
              ),
            )
        ),
        SizedBox(height: 7,),
        TextFormField(
          keyboardType: TextInputType.text,
          // controller: Discount_Field_Controller,
          // // autovalidateMode: _value==0?AutovalidateMode.disabled:AutovalidateMode.onUserInteraction,
          // inputFormatters: [
          //   FilteringTextInputFormatter.deny("-"),
          //   FilteringTextInputFormatter.deny(" "),
          //   FilteringTextInputFormatter.deny(","),
          // ],
          validator: (value) {
            if (_value=="Custom label" && value!.isEmpty) {
              return 'Address Label is Required. Please Enter.';
            }
            else if (_value==3 && value!.trim().length == 0) {
              return 'Address Label is Required. Please Enter.';
            }
            return null;
          },
          enabled: _value=="Custom label"?true:false,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.location_on_rounded,size: 20,),
              prefixIconConstraints: BoxConstraints.tightFor(height: 20,width: 45),
              labelText: "Address Label",
              hintText: "My Shop",
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



