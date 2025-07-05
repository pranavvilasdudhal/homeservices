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

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isDarkMode = false;
  String _username = 'pranav.d_4019';
  String _phone = '9130218664';
  String _email = 'pranav@gmail.com';
  int _selectedIndex = -1; // For tracking selected settings option

  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  void _onSettingsTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Add actual functionality for each option
    switch (index) {
      case 1: // Profile details
      // Navigate to profile details page
        break;
      case 2: // Settings
      // Navigate to settings page
        break;
      case 3: // Log out
        _showLogoutDialog();
        break;
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Log Out'),
          content: Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Log Out'),
              onPressed: () {
                // Add logout logic here
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey[900],
        cardColor: Colors.grey[800],
      )
          : ThemeData.light(),
      home: Scaffold(
        body: Column(
          children: [
            Container(
              height: 180,
              color: _isDarkMode ? Color(0xFF4A3D6D) : Color(0xFFCCB8FF),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                          _isDarkMode
                              ? 'assets/images/image-dark.png'
                              : 'assets/images/image-1.png'
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              _username,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  infoRow('Phone', _phone),
                  infoRow('Mail', _email),
                ],
              ),
            ),
            Divider(color: _isDarkMode ? Colors.grey[700] : Colors.grey[300]),
            Expanded(
              child: ListView(
                children: [
                  _buildSettingsOption(
                    index: 0,
                    icon: Icons.dark_mode_outlined,
                    text: 'Dark mode',
                    trailing: Switch(
                      value: _isDarkMode,
                      onChanged: _toggleDarkMode,
                      activeColor: _isDarkMode ? Colors.purple : null,
                    ),
                  ),
                  _buildSettingsOption(
                    index: 1,
                    icon: Icons.person_outline,
                    text: 'Profile details',
                  ),
                  _buildSettingsOption(
                    index: 2,
                    icon: Icons.settings_outlined,
                    text: 'Settings',
                  ),
                  _buildSettingsOption(
                    index: 3,
                    icon: Icons.logout,
                    text: 'Log out',
                    isLogout: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsOption({
    required int index,
    required IconData icon,
    required String text,
    Widget? trailing,
    bool isLogout = false,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      color: _isDarkMode ? Colors.grey[800] : Colors.white,
      elevation: 1,
      child: ListTile(
      leading: Icon(
      icon,
      color: isLogout
          ? Colors.red
          : (_isDarkMode ? Colors.white : Colors.black),
      title: Text(
        text,
        style: TextStyle(
          color: isLogout
              ? Colors.red
              : (_isDarkMode ? Colors.white : Colors.black),
        ),
        trailing: trailing ?? Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: _isDarkMode ? Colors.white : Colors.black,
        ),
        onTap: () => _onSettingsTapped(index),
      ),
    );
  }
}