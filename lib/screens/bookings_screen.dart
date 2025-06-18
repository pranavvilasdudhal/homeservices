import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: BookingsScreen(),
    ),
  );
}

class BookingsScreen extends StatelessWidget {
  final List<Map<String, String>> bookings = [
    {
      'service': 'AC Repair',
      'date': '2025-06-15',
      'status': 'Confirmed',
    },
    {
      'service': 'Sofa Cleaning',
      'date': '2025-06-18',
      'status': 'Pending',
    },

    {
      'service': 'Sofa Cleaning',
      'date': '2025-06-18',
      'status': 'Pending',
    }, 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Bookings')),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return Card(
            child: ListTile(
              title: Text(booking['service'] ?? ''),
              subtitle: Text('Date: ${booking['date']}'),
              trailing: Text(
                booking['status'] ?? '',
                style: TextStyle(
                  color: booking['status'] == 'Confirmed' ? Colors.green : Colors.orange,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
