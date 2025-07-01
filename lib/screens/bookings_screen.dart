import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';


// void main() {
//   runApp(
//     MaterialApp(
//       home: BookingForm(),
//     ),
//   );
// }

class BookingForm extends StatefulWidget {
  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  String? selectedService;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  TextEditingController addressController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  List<String> services = [
    'Home Cleaning',
    'AC Repair',
    'Electrician',
    'Plumber',
    'Pest Control',
  ];

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  void _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 10, minute: 0),
    );
    if (picked != null) setState(() => selectedTime = picked);
  }

  void _submitBooking() {
    if (selectedService == null ||
        selectedDate == null ||
        selectedTime == null ||
        addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("कृपया सर्व आवश्यक माहिती भरा")),
      );
      return;
    }

    // For now, just show dialog
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Booking Confirmed"),
        content: Text("Thanks! Your service is booked."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM, yyyy');
    final timeFormat = (TimeOfDay t) => t.format(context);

    return Scaffold(
      appBar: AppBar(title: Text("Book a Service")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Service Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: "Select Service"),
              value: selectedService,
              items: services
                  .map((service) => DropdownMenuItem(
                child: Text(service),
                value: service,
              ))
                  .toList(),
              onChanged: (value) => setState(() => selectedService = value),
            ),
            SizedBox(height: 16),

            // Date Picker
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Choose Date",
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: _pickDate,
              controller: TextEditingController(
                text: selectedDate != null
                    ? dateFormat.format(selectedDate!)
                    : '',
              ),
            ),
            SizedBox(height: 16),

            // Time Picker
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Choose Time",
                suffixIcon: Icon(Icons.access_time),
              ),
              onTap: _pickTime,
              controller: TextEditingController(
                text: selectedTime != null
                    ? timeFormat(selectedTime!)
                    : '',
              ),
            ),
            SizedBox(height: 16),

            // Address Field
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: "Enter Address",
                prefixIcon: Icon(Icons.location_on),
              ),
              maxLines: 2,
            ),
            SizedBox(height: 16),

            // Notes Field
            TextField(
              controller: noteController,
              decoration: InputDecoration(
                labelText: "Additional Notes (optional)",
                prefixIcon: Icon(Icons.note),
              ),
              maxLines: 2,
            ),
            SizedBox(height: 24),

            // Submit Button
            ElevatedButton(
              onPressed: _submitBooking,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Confirm Booking"),
            ),
          ],
        ),
      ),
    );
  }
}

class DateFormat {
  DateFormat(String s);

  format(DateTime dateTime) {}
}
