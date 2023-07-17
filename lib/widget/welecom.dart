import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';

class Welecom extends StatefulWidget {
  const Welecom({super.key});

  @override
  State<Welecom> createState() => _WelecomState();
}

class _WelecomState extends State<Welecom> {
  String userName = "";
  List<UserModel> userData = [];
  var imageUrl = "${Config.baseUrl}/newsappapi/uploads/userImages/";
  Future<void> userInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    userName = preferences.getString("userName2")!;
    try {
      String url = "${Config.baseUrl}/newsappapi/welcom.php?username=$userName";
      final response = await http.get(
        Uri.parse(url),
      );

      final list = json.decode(response.body) as List<dynamic>;
      userData = list.map((e) => UserModel.fromJson(e)).toList();
    } catch (error) {
      print('Khaladku waxa uu ka jiraa ---> $error');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: userInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child:
                  CircularProgressIndicator()); // Show a loading indicator while data is being fetched
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return ListView.builder(
            itemCount: userData.length,
            itemBuilder: (context, index) {
              final user = userData[index];
              return Container(
                padding: EdgeInsets.all(16),
                // decoration: BoxDecoration(
                //   color: Colors.white,
                //   borderRadius: BorderRadius.circular(16),
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.grey.withOpacity(0.5),
                //       spreadRadius: 2,
                //       blurRadius: 5,
                //       offset: Offset(0, 3),
                //     ),
                //   ],
                // ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(imageUrl + user.img!),
                    ),
                    SizedBox(width: 16),
                    Text(
                      'Welcome, ${user.name!}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        // color: Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
