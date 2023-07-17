import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../api.dart';
import '../model/postModel.dart';
import 'post_detils.dart';

class PostCategoryScreen extends StatefulWidget {
  const PostCategoryScreen({required this.catName, super.key});
  final String catName;

  @override
  State<PostCategoryScreen> createState() => _PostCategoryScreenState();
}

class _PostCategoryScreenState extends State<PostCategoryScreen> {
  List<PostModel> postData = [];
  var imageUrl = "${Config.baseUrl}/newsappapi/uploads/";

  Future<void> postApi() async {
    try {
      const url = '${Config.baseUrl}/newsappapi/fetch_post.php?all';
      final response = await http.get(
        Uri.parse(url),
      );

      final list = json.decode(response.body) as List<dynamic>;

      postData = list.map((e) => PostModel.fromJson(e)).toList();
    } catch (error) {
      print('Khaladku waxa uu ka jiraa PostCat---> $error');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    late List<PostModel> x = postData.where((element) {
      return element.cat == widget.catName;
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.catName),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<void>(
            future: postApi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child:
                        CircularProgressIndicator()); // Show a loading indicator while data is being fetched
              } else if (x.isEmpty) {
                return const Center(
                  child: Text("No Post Availibe"),
                );
              } else {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: x.length,
                  itemBuilder: (BuildContext context, int index) {
                    final post = x[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostDetailPage(
                                      title: post.title,
                                      description: post.desc,
                                      img: imageUrl + post.image,
                                      time: DateFormat.yMMMd()
                                          .format(DateTime.parse(post.time)),
                                      username: post.username,
                                      cat: post.cat,
                                    )));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(imageUrl + post.image),
                        ),
                        title: Text(post.title),
                        subtitle: Text(post.desc),
                      ),
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}
