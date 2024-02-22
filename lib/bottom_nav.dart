import 'package:flutter/material.dart';
import 'package:news_app/screens/my_posts.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/dashboard.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  String admin = "";
  List<Widget> _widgetOptions = [];

  Future<void> getAdmin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final theAdmin = preferences.getString("admin") ?? "";
    setState(() {
      admin = theAdmin;
      print("admin is $admin");
      initializeWidgetOptions();
    });
  }

  void initializeWidgetOptions() {
    setState(() {
      _widgetOptions = <Widget>[
        const HomeScreen(),
        const DeletePost(),
        const UserProfilePage(),
        admin.isEmpty ? const SizedBox() : const DashboardScreen(),
      ];
    });
  }

  @override
  void initState() {
    super.initState();
    getAdmin();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Bottom Navigation'),
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _buildBottomNavigationBarItems(),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems() {
    // ignore: unnecessary_null_comparison
    if (admin.isEmpty) {
      return const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.feed),
          label: 'Your Posts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ];
    } else {
      return const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.feed),
          label: 'Your Posts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
      ];
    }
  }
}
