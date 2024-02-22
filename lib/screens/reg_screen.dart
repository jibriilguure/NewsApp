import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:news_app/bottom_nav.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';
import '../widget/user_image_pick.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _location = TextEditingController();

  File? _imageSelected;
  Future regster() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }
    final url = Uri.parse("${Config.baseUrl}/newsappapi/reg_api.php");

    var request = http.MultipartRequest("POST", url);
    request.fields['name'] = _name.text;
    request.fields['username'] = _username.text;
    request.fields['password'] = _password.text;
    request.fields['email'] = _email.text;
    request.fields['phone'] = _phone.text;
    request.fields['location'] = _location.text;

    var pic = await http.MultipartFile.fromPath("image", _imageSelected!.path);
    request.files.add(pic);

    var response = await request.send();
    var responseBody = await response.stream.bytesToString();
    var data = json.decode(responseBody);

    if (data == "e") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Hory baa loqatay Usernamka'),
          duration: Duration(seconds: 3),
        ),
      );
    } else if (data == "s") {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString("userName", _name.text);
      await preferences.setString("userName2", _username.text);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ));
    }
    if (response.statusCode == 200) {
      print("image uploaded seccssfully");
    } else {
      print("eroro");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  UserImagePicker(
                    onSelectedImage: (pickedImage) {
                      setState(() {
                        _imageSelected = pickedImage;
                      });
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_2_sharp),
                      labelText: 'Name',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _username,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Username',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      // if (!EmailValidator.validate(value)) {
                      //   return 'Please enter a valid email';
                      // }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _phone,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      labelText: 'Phone',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      // if (!PhoneNumberValidator.validate(value)) {
                      //   return 'Please enter a valid phone number';
                      // }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _location,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.home),
                      labelText: 'Location',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your location';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _password,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password should be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: regster,
                    child: const Text('Register'),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: const Text("LogIn")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
