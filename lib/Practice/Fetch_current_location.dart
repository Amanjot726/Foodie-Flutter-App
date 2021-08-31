import 'package:first_app/Restaurants/add_restaurants.dart';
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
        return false;
      }
      else{
        _permissionGranted = await location.hasPermission();
        if (_permissionGranted == PermissionStatus.denied) {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted != PermissionStatus.granted) {
            return false;
          }
          else{
            return true;
          }
        }
        else{
          return true;
        }
      }
    }
    else{
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return false;
        }
        else{
          return true;
        }
      }
      else{
        return true;
      }
    }

  }


  @override
  Widget build(BuildContext contextt) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetch Current Location"),
      ),
      body: FutureBuilder(
        future: checkPermissions(),
        builder: (BuildContext context,AsyncSnapshot snapshot) {
          // Show_Snackbar(context: contextt,message: snapshot.data.toString());
          return snapshot.data==true?StreamBuilder(
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
              if(snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              LocationData data = snapshot.data! as LocationData;
              return Center(
                  child: Text("Latitude: "+data.latitude.toString()+"\n\nLongitude: "+data.longitude.toString()),
              );
            },
          )
          :
          Center(
            child: Text("Location permission is not allowed. Click button bellow to give permissions",maxLines: 3,textAlign: TextAlign.center,),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          bool val = await checkPermissions();
          setState(() async{
            Navigator.pushReplacementNamed(context, "/fetch_location");
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