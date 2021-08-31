import 'package:flutter/material.dart';


class mainPage extends StatelessWidget {
  const mainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: TextButton(
          child: Text("Open"),
          onPressed: (){},
        ),
      ),
    );
  }
}



// class DatePickerWidget extends StatefulWidget {
//   const DatePickerWidget({Key? key}) : super(key: key);
//
//   @override
//   _DatePickerWidgetState createState() => _DatePickerWidgetState();
// }
//
// class _DatePickerWidgetState extends State<DatePickerWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return DatePickerDialog(initialDate: initialDate, firstDate: firstDate, lastDate: lastDate)
//   }
// }
