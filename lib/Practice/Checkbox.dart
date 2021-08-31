import 'package:flutter/material.dart';

class CheckBoxPage extends StatefulWidget {
  const CheckBoxPage({Key? key}) : super(key: key);

  @override
  _CheckBoxPageState createState() => _CheckBoxPageState();
}

class _CheckBoxPageState extends State<CheckBoxPage> {

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkbox Tutorial"),
      ),
      body: Center(
        child: CheckboxListTile(
          title: Text("Java"),
          subtitle: Text("Java and JEE Technolody"),
          value: isChecked,
          onChanged: (bool){
            setState(() {
              isChecked = bool! ? false : true;
            });
          },
        ),
      ),
    );
  }
}
