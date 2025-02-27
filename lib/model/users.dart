class Users {
  String? username;
  String? email;
  String? phone;
  String? address;
  String? password;
  Users({this.username,this.email,this.phone,this.address,this.password});
   Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email' : email,
      'phone': phone,
      'address' : address,
      'password' : password,
    };
  }
}