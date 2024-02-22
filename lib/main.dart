import 'package:flutter/material.dart';
import 'package:news_app/bottom_nav.dart';
import 'package:news_app/screens/dashboard.dart';

import 'package:news_app/screens/login_screen.dart';
import 'package:news_app/widget/darkMode.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _currentUser;
  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final currentUser = prefs.getString('userName2');
    setState(() {
      _currentUser = currentUser;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
          ),
        ],
        builder: (context, _) {
          final provider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'News App',
              // ignore: dead_code
              theme: ThemeManger.lightTheme,
              themeMode: provider.themeMode,
              darkTheme: ThemeManger.darkTheme,
              // theme: ThemeData(

              //   //brightness: Brightness.dark,
              //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              //   useMaterial3: true,
              // ),
              home: _currentUser == null
                  ? const LoginScreen()
                  : const MyHomePage());
        });
  }
}
