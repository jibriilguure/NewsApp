import 'package:flutter/material.dart';
import 'package:news_app/model/category_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryWidget extends StatefulWidget {
  CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  List<CatModel> catData = [];

  Future<void> catApi() async {
    try {
      const url = 'http://192.168.0.105/newsappapi/cat_api.php';
      final response = await http.get(
        Uri.parse(url),
      );

      final list = json.decode(response.body) as List<dynamic>;
      catData = list.map((e) => CatModel.fromJson(e)).toList();
    } catch (error) {
      print('Khaladku waxa uu ka jiraa ---> $error');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: catApi(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator while data is being fetched
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Container(
            height: 100,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: catData.length,
              itemBuilder: (BuildContext context, int index) {
                return Chip(label: Text(catData[index].catName));
              },
            ),
          );
        }
      },
    );
  }
}
