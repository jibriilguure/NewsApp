class PostModel {
  late final String id;
  late final String username;
  late final String title;
  late final String desc;
  late final String image;
  late final String time;
  late final String cat;

  PostModel({
    required this.id,
    required this.username,
    required this.title,
    required this.desc,
    required this.image,
    required this.time,
    required this.cat,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    title = json['title'];
    desc = json['desc'];
    image = json['image'];
    time = json['time'];
    cat = json['cat'];
  }
}
