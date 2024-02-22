import 'dart:convert';
import 'package:http/http.dart' as http;

import '../api.dart';

class CountData {
  late final List<Table1> table1;
  late final List<Table2> table2;

  CountData({
    required this.table1,
    required this.table2,
  });

  factory CountData.fromJson(Map<String, dynamic> json) {
    return CountData(
      table1: List<Table1>.from(
          json['table1'].map((data) => Table1.fromJson(data))),
      table2: List<Table2>.from(
          json['table2'].map((data) => Table2.fromJson(data))),
    );
  }

  static Future<CountData> fetchData() async {
    final response =
        await http.get(Uri.parse("${Config.baseUrl}/newsappapi/admin_api.php"));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      return CountData.fromJson(jsonData);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class Table1 {
  late final String totalPosts;

  Table1({
    required this.totalPosts,
  });

  factory Table1.fromJson(Map<String, dynamic> json) {
    return Table1(
      totalPosts: json['totalPosts'],
    );
  }
}

class Table2 {
  late final String totalUsers;

  Table2({
    required this.totalUsers,
  });

  factory Table2.fromJson(Map<String, dynamic> json) {
    return Table2(
      totalUsers: json['totalUsers'],
    );
  }
}





// class CountData {
//   CountData({
//     required this.table1,
//     required this.table2,
//   });
//   late final List<Table1> table1;
//   late final List<Table2> table2;

//   CountData.fromJson(Map<String, dynamic> json) {
//     table1 = List.from(json['table1']).map((e) => Table1.fromJson(e)).toList();
//     table2 = List.from(json['table2']).map((e) => Table2.fromJson(e)).toList();
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['table1'] = table1.map((e) => e.toJson()).toList();
//     _data['table2'] = table2.map((e) => e.toJson()).toList();
//     return _data;
//   }
// }

// class Table1 {
//   Table1({
//     required this.totalPosts,
//   });
//   late final String totalPosts;

//   Table1.fromJson(Map<String, dynamic> json) {
//     totalPosts = json['totalPosts'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['totalPosts'] = totalPosts;
//     return _data;
//   }
// }

// class Table2 {
//   Table2({
//     required this.totalUsers,
//   });
//   late final String totalUsers;

//   Table2.fromJson(Map<String, dynamic> json) {
//     totalUsers = json['totalUsers'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['totalUsers'] = totalUsers;
//     return _data;
//   }
// }

