class AppUser{

  String? uid;
  String? name;
  String? email;
  String? Profile_pic;
  bool? isAdmin;

  AppUser({this.uid, this.name, this.email, this.Profile_pic, this.isAdmin});


  @override
  String toString() {
    return 'NewUser{uid: $uid, name: $name, email: $email, profile_pic: $Profile_pic}';
  }

  Map<String, dynamic> toMap(){
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "profile_pic": Profile_pic,
    };

  }
}