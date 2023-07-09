class UserModel {
  String? id;
  String? name;
  String? username;
  String? password;
  String? email;
  String? phone;
  String? location;
  String? img;

  UserModel(
      {this.id,
      this.name,
      this.username,
      this.password,
      this.email,
      this.phone,
      this.location,
      this.img});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    phone = json['phone'];
    location = json['location'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['location'] = this.location;
    data['img'] = this.img;
    return data;
  }
}
