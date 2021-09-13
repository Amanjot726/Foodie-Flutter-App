import 'package:first_app/util/constants.dart';

class Order{

  String? Order_Id = getRandomString(6);
  List? Dishes;
  double? Total_Amount;
  String? Payment_Icon;
  String? Payment_Mode;
  String? Address_Type;
  String? Address;
  DateTime? _DateTime = new DateTime.now();

  Order({this.Dishes, this.Total_Amount, this.Payment_Icon, this.Payment_Mode, this.Address_Type, this.Address});


  @override
  String toString() {
    return 'Order{Order_Id: $Order_Id, Dishes: $Dishes, Total_Amount: $Total_Amount, Payment_Icon: $Payment_Icon, Payment_Mode: $Payment_Mode, Address_Type: $Address_Type, Address: $Address, DateTime: $_DateTime}';
  }

  // var now = new DateTime.now();
  // var formatter = new DateFormat('y-MM-d H:m:ss');
  //
  // String formattedDate = formatter.format(now);
  //
  // print(formatter.format(now)); // 2016-01-25

  Map<String, dynamic> toMap(){
    return {
      "Order_Id" : Order_Id,
      "Dishes": Dishes,
      "Total_Amount": Total_Amount,
      "Payment_Icon": Payment_Icon,
      "Payment_Mode": Payment_Mode,
      "Address_Type": Address_Type,
      "Address" : Address,
      "DateTime": _DateTime,
    };

  }

}