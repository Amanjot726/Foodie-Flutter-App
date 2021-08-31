class AppUser{

  String? uid;
  String? name;
  String? email;
  String? Profile_pic;
  bool? isAdmin;
  Map? cart;
  Map? address;

  AppUser({this.uid, this.name, this.email, this.Profile_pic, this.isAdmin, this.cart, this.address});


  @override
  String toString() {
    return 'AppUser{uid: $uid, name: $name, email: $email, Profile_pic: $Profile_pic, isAdmin: $isAdmin, cart: $cart, address: $address}';
  }


  Map<String, dynamic> toMap(){
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "profile_pic": Profile_pic,
      "isAdmin" : isAdmin,
      "cart": cart,
      "address": address,
    };

  }
}