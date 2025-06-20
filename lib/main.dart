import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/bookings_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(HomeServicesApp());
}

class HomeServicesApp extends StatefulWidget {
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
        body: _screens[_selectedIndex],
        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: _selectedIndex,
        //   onTap: (i) => setState(() => _selectedIndex = i),
        //   items: const [
        //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        //     BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Bookings'),
        //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        //   ],
        // ),
      ),
    );
  }
}
