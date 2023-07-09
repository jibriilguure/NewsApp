class PostModel {
  late final String id;
  late final String username;
  late final String title;
  late final String desc;
  late final String image;
  late final String time;

  PostModel({
    required this.id,
    required this.username,
    required this.title,
    required this.desc,
    required this.image,
    required this.time,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    title = json['title'];
    desc = json['desc'];
    image = json['image'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['image'] = this.image;
    data['time'] = this.time;
    return data;
  }
}
