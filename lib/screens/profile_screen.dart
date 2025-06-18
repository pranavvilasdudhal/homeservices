import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: ProfileScreen(),
    ),
  );
}

class ProfileScreen extends StatelessWidget {
  final String userName = "Pranav Dudhal";
  final String email = "pranav@example.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Profile')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            SizedBox(height: 16),
            Text(userName, style: Theme.of(context).textTheme.headlineSmall),
            Text(email, style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 30),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Add logout logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}
