class Order{

  List? Dishes;
  double? Total_Amount;
  String? Payment_Icon;
  String? Payment_Mode;
  String? Address_Type;
  String? Address;

  Order({this.Dishes, this.Total_Amount, this.Payment_Icon,this.Payment_Mode, this.Address_Type, this.Address});

  @override
  String toString() {
    return 'Order{Dishes: $Dishes, Total_Amount: $Total_Amount, Payment_Icon: $Payment_Icon, Payment_Mode: $Payment_Mode, Address_Type: $Address_Type, Address: $Address}';
  }

  Map<String, dynamic> toMap(){
    return {
      "Dishes": Dishes,
      "Total_Amount": Total_Amount,
      "Payment_Icon": Payment_Icon,
      "Payment_Mode": Payment_Mode,
      "Address_Type": Address_Type,
      "Address" : Address,
    };

  }

}