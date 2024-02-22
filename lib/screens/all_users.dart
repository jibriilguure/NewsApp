import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../api.dart';
import '../model/user_model.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({super.key});

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  var imageUrl = "${Config.baseUrl}/newsappapi/uploads/userImages/";
  List<UserModel> usersData = [];
  Future<void> showUsers() async {
    try {
      String url = "${Config.baseUrl}/newsappapi/users.php";
      final response = await http.get(
        Uri.parse(url),
      );

      final list = json.decode(response.body) as List<dynamic>;
      usersData = list.map((e) => UserModel.fromJson(e)).toList();
    } catch (error) {
      print('Khaladku waxa uu ka jiraa ---> $error');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Users"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<void>(
            future: showUsers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child:
                        CircularProgressIndicator()); // Show a loading indicator while data is being fetched
              } else if (usersData.isEmpty) {
                return const Center(
                  child: Text('No Post  available.'),
                );
              } else if (snapshot.hasData) {
                return Text('Error: ${snapshot.error}');
              } else {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: usersData.length,
                  itemBuilder: (BuildContext context, int index) {
                    final user = usersData[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(imageUrl + user.img!),
                        ),
                        title: Text(
                          user.name!,
                          style: const TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(user.username!,
                            style: const TextStyle(color: Colors.black)),
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
