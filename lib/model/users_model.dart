class UsersModel {
  late String id;
  late String name;
  late String username;
  late String password;
  late String email;
  late String phone;
  late String location;
  late String img;
  late String admin;

  UsersModel(
      {required this.id,
      required this.name,
      required this.username,
      required this.password,
      required this.email,
      required this.phone,
      required this.location,
      required this.img,
      required this.admin});

  UsersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    phone = json['phone'];
    location = json['location'];
    img = json['img'];
    admin = json['admin'];
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
    data['admin'] = this.admin;
    return data;
  }
}
