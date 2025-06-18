import 'package:flutter/material.dart';

import '../main.dart';

void main() {
  runApp(HomeServicesApp());
}

class ServiceDetailScreen extends StatelessWidget {
  final String serviceName;

  const ServiceDetailScreen({required this.serviceName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(serviceName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(serviceName, style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 10),
            Text('Service details will go here...'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Booking logic किंवा form इथे
              },
              child: Text('Book This Service'),
            )
          ],
        ),
      ),
    );
  }
}
