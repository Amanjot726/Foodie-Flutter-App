import 'package:flutter/material.dart';


class BannerPage extends StatefulWidget {
  const BannerPage({Key? key}) : super(key: key);

  @override
  _BannerPageState createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Banner Tutorial"),
      ),
      body: MaterialBanner(
        content: Text(""),
        leading: CircleAvatar(
          child: Icon(Icons.notifications_active),
        ),
        actions: [
          TextButton(
            onPressed: (){},
            child: Text("Done")
          ),
          TextButton(
              onPressed: (){},
              child: Text("Order Now")
          ),
        ],
      ),
    );
  }
}
