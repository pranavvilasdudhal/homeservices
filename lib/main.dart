import 'package:flutter/material.dart';
import 'package:untitled/login_screens/splashscreen.dart';
import 'screens/home_screen.dart';


void main() {
  runApp(HomeServicesApp());
}

class HomeServicesApp extends StatefulWidget {
  const HomeServicesApp({super.key});

  @override
  _HomeServicesAppState createState() => _HomeServicesAppState();
}

class _HomeServicesAppState extends State<HomeServicesApp> {
  int _selectedIndex = 0;
  final _screens = [
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Services App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        body: const SplashScreen(),
      ),
    );
  }
}
