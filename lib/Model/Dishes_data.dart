class Add_Dishes{

  String? name;
  int? discount_type;
  int? flatDiscount;
  int? percentageDiscount;
  double? price;
  double? ratings;
  String? imageURL;

  Add_Dishes({this.name, this.discount_type, this.flatDiscount, this.percentageDiscount, this.price, this.ratings, this.imageURL});

  @override
  String toString() {
    return 'Dishes{name: $name, discount_type: $discount_type, flatDiscount: $flatDiscount, percentageDiscount: $percentageDiscount, price: $price, ratings: $ratings, imageURL: $imageURL}';
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'discount_type': discount_type,
      'flatDiscount': flatDiscount,
      'percentageDiscount': percentageDiscount,
      'price': price,
      'ratings': ratings,
      'imageURL': imageURL
    };
  }
}

//
// class Update_Dishes_Cart{
//
//
//   Update_Dishes_Cart();
//
// }
