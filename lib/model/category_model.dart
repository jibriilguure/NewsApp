class CatModel {
  late final String id;
  late final String catName;
  late final String createdAt;

  CatModel({
    required this.id,
    required this.catName,
    required this.createdAt,
  });

  CatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catName = json['cat_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['cat_name'] = this.catName;
    data['created_at'] = this.createdAt;
    return data;
  }
}
