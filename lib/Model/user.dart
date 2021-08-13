class AppUser{

  String? uid;
  String? name;
  String? email;

  AppUser({this.uid, this.name, this.email});

  // it will be executed whenever we will print reference of User Object
  @override
  String toString() {
    return 'User{uid: $uid, name: $name, email: $email}';
  }

  Map<String, dynamic> toMap(){
    return {
      "uid": uid,
      "name": name,
      "email": email,
    };

  }
}