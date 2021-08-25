import 'package:flutter/material.dart';
import 'package:location/location.dart';

class FetchCurrentLocationPage extends StatefulWidget {
  const FetchCurrentLocationPage({Key? key}) : super(key: key);

  @override
  _FetchCurrentLocationPageState createState() => _FetchCurrentLocationPageState();
}

class _FetchCurrentLocationPageState extends State<FetchCurrentLocationPage> {

  Location location = new Location();

  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;

  String locationText = "Location Not Available";

  Future<bool> checkPermissions() async{


    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        _permissionGranted = await location.hasPermission();
        if (_permissionGranted == PermissionStatus.denied) {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted != PermissionStatus.granted) {
            return true;
          }
        }
      }
    }
    return false;


    // _locationData = await location.getLocation();
    // setState(() {
    //   locationText = "Latitude: ${_locationData!.latitude} Longitude: ${_locationData!.longitude}";
    // });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetch Current Location"),
      ),
      body: StreamBuilder(
        stream: location.onLocationChanged,
        builder: (context, snapshot) {
          LocationData data = snapshot.data as LocationData;
          return FutureBuilder(
            future: checkPermissions(),
            builder: (context, snapshot) {
              return snapshot.data==true?Center(
              child: Text("Latitude: "+data.latitude.toString()+"\n\nLongitude: "+data.longitude.toString()),
              ):
              Center(
              child: Text("Location permission is not allowed. Click button bellow to give permissions"),
              );
            },
          );
        }
      )

      ,
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          setState(() {
            checkPermissions();
          });
        },
        backgroundColor: Colors.green,
        child: Icon(
          Icons.gps_fixed,
          color: Colors.white,
        ),
      ),
    );
  }
}