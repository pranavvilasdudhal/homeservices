import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SubCategoryDetailPage extends StatefulWidget {
  final int subCategoryId;
  final String subCategoryName;

  const SubCategoryDetailPage({
    Key? key,
    required this.subCategoryId,
    required this.subCategoryName,
  }) : super(key: key);

  @override
  State<SubCategoryDetailPage> createState() => _SubCategoryDetailPageState();
}

class _SubCategoryDetailPageState extends State<SubCategoryDetailPage> {
  Map<String, dynamic>? _subCategory;
  bool _isLoading = true;
  bool _hasError = false;

  final String baseUrl = "http://192.168.1.21:8000";

  @override
  void initState() {
    super.initState();
    fetchSubCategoryDetail();
  }

  Future<void> fetchSubCategoryDetail() async {
    final url = Uri.parse("$baseUrl/api/subcategorys/${widget.subCategoryId}");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true && data['data'] != null) {
          setState(() {
            _subCategory = data['data'];
            _hasError = false;
          });
        } else {
          setState(() => _hasError = true);
        }
      } else {
        setState(() => _hasError = true);
      }
    } catch (e) {
      setState(() => _hasError = true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sub = _subCategory;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subCategoryName),
        backgroundColor: Colors.deepOrange,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasError
          ? Center(child: Text("Failed to load details"))
          : sub == null
          ? const Center(child: Text("No data found"))
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (sub['image'] != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "$baseUrl/uploads/${sub['image']}",
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 16),
            Text(
              sub['name'] ?? "No Name",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Category: ${sub['category_name'] ?? 'Unknown'}",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Status: ${sub['status'] == '1' ? 'Active' : 'Inactive'}",
              style: TextStyle(
                fontSize: 16,
                color: sub['status'] == '1' ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Created: ${sub['created_at'] ?? ''}",
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              "Updated: ${sub['updated_at'] ?? ''}",
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
