import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';
import '../model/postModel.dart';
import 'edit_post.dart';

class AllPosts extends StatefulWidget {
  const AllPosts({super.key});

  @override
  State<AllPosts> createState() => _AllPostsState();
}

class _AllPostsState extends State<AllPosts> {
  var imageUrl = "${Config.baseUrl}/newsappapi/uploads/";
  String userName = "";
  //post category apiska weeye
  List<PostModel> postData = [];
  Future<void> postApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    userName = preferences.getString("userName2")!;
    try {
      String url = "${Config.baseUrl}/newsappapi/fetch_post.php?all";
      final response = await http.get(
        Uri.parse(url),
      );

      final list = json.decode(response.body) as List<dynamic>;
      postData = list.map((e) => PostModel.fromJson(e)).toList();
    } catch (error) {
      print('Khaladku waxa uu ka jiraa ---> $error');
      return;
    }
  }

  Future<void> deletePost(String postId) async {
    final url = '${Config.baseUrl}/newsappapi/delete.php?deletepost&id=$postId';

    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      // Post deleted successfully
      print('Post deleted successfully');
      setState(() {
        postData.removeWhere((post) => post.id == postId);
      });
    } else {
      // An error occurred
      print('Error deleting post: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Your Posts'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<void>(
            future: postApi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child:
                        CircularProgressIndicator()); // Show a loading indicator while data is being fetched
              } else if (postData.isEmpty) {
                return const Center(
                  child: Text('No Post  available.'),
                );
              } else if (snapshot.hasData) {
                return Text('Error: ${snapshot.error}');
              } else {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: postData.length,
                  itemBuilder: (BuildContext context, int index) {
                    final post = postData[index];
                    return Dismissible(
                      key: Key(post.id),
                      direction: DismissDirection.horizontal,
                      onDismissed: (direction) {
                        if (direction == DismissDirection.startToEnd) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditPost(
                                        id: post.id,
                                        desc: post.desc,
                                        title: post.title,
                                        category: post.cat,
                                      )));
                        } else if (direction == DismissDirection.endToStart) {
                          setState(() {
                            deletePost(post.id);
                            postData.removeAt(index);
                          });
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Post deleted"),
                          ));
                        }
                      },
                      background: Container(
                        color: Colors.green,
                        alignment: Alignment.centerLeft,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Icon(
                            Icons.edit,
                            // color: Colors.white,
                          ),
                        ),
                      ),
                      secondaryBackground: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        child: const Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: Icon(
                            Icons.delete,
                            // color: Colors.white,
                          ),
                        ),
                      ),
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(imageUrl + post.image),
                          ),
                          title: Text(
                            post.title,
                            style: const TextStyle(color: Colors.black),
                          ),
                          subtitle: Text(post.desc,
                              style: const TextStyle(color: Colors.black)),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
