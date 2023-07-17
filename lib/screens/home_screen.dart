import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/api.dart';
import 'package:news_app/model/postModel.dart';
import 'package:news_app/screens/create_post_screen.dart';

import 'package:news_app/widget/welecom.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../widget/category_widget.dart';
import '../widget/post_widget.dart';
import 'post_detils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "";

  Future getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    userName = preferences.getString("userName2")!;
  }

  var imageUrl = "${Config.baseUrl}/newsappapi/uploads/";
  //post category apiska weeye
  List<PostModel> postData = [];
  Future<void> postApi() async {
    try {
      const url = '${Config.baseUrl}/newsappapi/fetch_post.php?all';
      final response = await http.get(
        Uri.parse(url),
      );

      final list = json.decode(response.body) as List<dynamic>;
      postData = list.map((e) => PostModel.fromJson(e)).toList();
    } catch (error) {
      print('Khaladku waxa uu ka jiraa POSTPAGE ---> $error');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    getUserName();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("News App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100, child: Welecom()),
              CategoryWidget(),
              FutureBuilder<void>(
                future: postApi(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child:
                            CircularProgressIndicator()); // Show a loading indicator while data is being fetched
                  } else {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      // scrollDirection: Axis.vertical,
                      itemCount: postData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PostDetailPage(
                                          cat: postData[index].cat,
                                          time: DateFormat.yMMMd().format(
                                              DateTime.parse(
                                                  postData[index].time)),
                                          username: postData[index].username,
                                          title: postData[index].title,
                                          description: postData[index].desc,
                                          img: imageUrl + postData[index].image,
                                        )));
                          },
                          child: PostWidget(
                            title: postData[index].title,
                            desc: postData[index].desc,
                            img: imageUrl + postData[index].image,
                            time: postData[index].time,
                            username: postData[index].username,
                          ),
                        );
                        // ListTile(
                        //   title: Text(postData[index].),
                        // );
                      },
                    );
                  }
                },
              )

              // PostWidget(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (ctx) => const CreatePostScreen()));
        },
        tooltip: 'Create Post',
        child: const Icon(Icons.add),
      ),
    );
  }
}
