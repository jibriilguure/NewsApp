import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:news_app/bottom_nav.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';

import 'reg_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _username = TextEditingController();

  final TextEditingController _password = TextEditingController();

  Future login() async {
    try {
      var url = '${Config.baseUrl}/newsappapi/login_api.php';
      var response = await http.post(Uri.parse(url),
          body: {"username": _username.text, "password": _password.text});

      var data = json.decode(response.body);
      if (data == "as") {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString("admin", _username.text);

        await preferences.setString("userName2", _username.text);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(),
            ));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Welcom ${_username.text}'),
            duration: const Duration(seconds: 3),
          ),
        );
      } else if (data == "s") {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString("userName2", _username.text);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(),
            ));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Welcom ${_username.text}'),
            duration: const Duration(seconds: 3),
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color.fromARGB(255, 199, 82, 73),
            content: Text('Emailka ama Passwordka Baa khaldan'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _username,
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _password,
              decoration: const InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                login();
                print(_username.text);
                print(_password.text);
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: const Text('Create an account'),
            ),
          ],
        ),
      ),
    );
  }
}
