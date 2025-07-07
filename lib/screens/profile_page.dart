import 'package:flutter/material.dart';

void main() => runApp(ProfileApp());

class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 180,
            color: Color(0xFFCCB8FF), // light purple background
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/image-1.png'), // <- Replace with your asset
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'pranav.d_4019',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                infoRow('Phone', '9130218664'),
                infoRow('Mail', 'pranav@gmail.com'),
              ],
            ),
          ),
          Divider(),
          settingsOption(
            icon: Icons.dark_mode_outlined,
            text: 'Dark mode',
            trailing: Switch(value: false, onChanged: (_) {}),
          ),
          settingsOption(icon: Icons.person_outline, text: 'Profile details'),
          settingsOption(icon: Icons.settings_outlined, text: 'Settings'),
          settingsOption(icon: Icons.logout, text: 'Log out'),
        ],
      ),
    );
  }

  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey)),
          Text(value, style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }

  Widget settingsOption({required IconData icon, required String text, Widget? trailing}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      trailing: trailing ?? Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {}, // Add navigation if needed
    );
  }
}
