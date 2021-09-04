// import 'package:first_app/News_api.dart';
// import 'package:first_app/News_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:first_app/Restaurants/Manage_Delivery.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:first_app/Auth/Register-Page.dart';
import 'package:first_app/Practice/Fetch_current_location.dart';
import 'package:first_app/Practice/Google-maps-with-location.dart';
import 'package:first_app/Restaurants/Address_Page.dart';
import 'package:first_app/Restaurants/Map_Page.dart';
import 'package:first_app/Restaurants/Restaurant_user_profile.dart';
import 'package:first_app/Auth/splash-page.dart';
import 'package:first_app/Practice/John_Jack_Bricks.dart';
import 'package:first_app/Practice/News_api_Listview.dart';
import 'package:first_app/Practice/Listview.dart';
import 'package:first_app/Restaurants/add_dishes.dart';
import 'package:first_app/Restaurants/add_restaurants.dart';
import 'package:first_app/Restaurants/cart_page.dart';
import 'package:first_app/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:first_app/Practice/profile_page.dart';
import 'package:first_app/Home/splash-page.dart';
import 'package:first_app/Home/home-page.dart';
import 'package:first_app/Practice/Friends_Colors_Images.dart';
import 'package:first_app/Practice/Tasks.dart';
import 'package:flutter/services.dart';
import 'package:first_app/Home/Settings_Page.dart';
import 'package:first_app/Practice/data-passing.dart';
import 'package:first_app/Auth/Login-Page.dart';
import 'package:first_app/Restaurants/home_page.dart' as Restaurant;


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
AndroidNotificationChannel? channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;


Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  // to execute the app created by us
  // MyApp -> Object
  runApp(MyApp());
}


class MyApp extends StatefulWidget{

    // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        // Navigator.pushNamed(context, '/message',
        //     arguments: MessageArguments(message, true));
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {

      RemoteNotification? notification = message!.notification;
      AndroidNotification? android = message.notification!.android;

      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin!.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                channel!.description,
                playSound: true,
                //sound: AndroidNotificationSound()
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // Navigator.pushNamed(context, '/message',
      //     arguments: MessageArguments(message, true));
    });
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
      title: APP_NAME,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      // theme: ThemeData.dark().copyWith(accentColor: Colors.green),
      // theme: ThemeData.light().copyWith(accentColor: Colors.green),
      debugShowCheckedModeBanner: false,
      routes: {
        // "/": (context) => SplashPage(),
        "/home": (context) => HomePage(),
        "/ad": (context) => Profile_UI(),
        "/settings": (context) => SettingsPage(),
        "/task": (context) => Tasks_page(),
        "/john_jack": (context) => Input_Bricks_Page(),
        "/": (context) => RestaurantSplashPage(),
        "/login": (context) => LoginPage(),
        "/register": (context) => RegisterPage(),
        "/Restaurant_home": (context) => Restaurant.HomePage(),
        "/profile": (context) => User_Profile(),
        "/add_restaurant": (context) => Add_Restaurant_Page(),
        "/cart": (context) => Cart_Page(),
        "/Addresses": (context) => AddressPage(),
        "/fetch_location": (context) => FetchCurrentLocationPage(),
        "/Address_Google_Map": (context) => Find_Address_From_Map(),
        "/Manage_Delivery": (context) => ManageDeliveryPage(),
      },
      initialRoute: "/",
      // initialRoute: "/fetch_location",
      // home: Tasks_page(),
    );
  }
}

// class HomePage extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(235, 220, 245, 234),
//       appBar: AppBar(
//         title: Text("My Friends"),
//         backgroundColor: Colors.green,
//         actions: [
//           PopupMenuButton(
//             itemBuilder: (context)=>[
//               PopupMenuItem(
//                 child: Text("Item 1"),
//                 value: 1,
//               ),
//               PopupMenuItem(
//                 child: Text("Item 2"),
//                 value: 2,
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: Change(),
//     );
//   }
// }