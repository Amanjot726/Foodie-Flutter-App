import 'package:flutter/material.dart';


class ChipWidget extends StatefulWidget {
  const ChipWidget({Key? key}) : super(key: key);

  @override
  _ChipWidgetState createState() => _ChipWidgetState();
}

class _ChipWidgetState extends State<ChipWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("Banner Tutorial"),
    ),
    body: Center(
      child: Chip(
        label: Text("John Watson"),
        avatar: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text("JW"),
        ),
      ),
    ),
    );
  }
}
