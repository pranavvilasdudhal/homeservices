import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SubCategoryPage extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const SubCategoryPage({required this.categoryId, required this.categoryName, Key? key}) : super(key: key);

  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  List<dynamic> _subcategories = [];
  bool _hasError = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSubCategories();
  }

  Future<void> fetchSubCategories() async {
    final url = Uri.parse('http://192.168.137.1:8000/api/subcategories?cat_id=${widget.categoryId}');

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
print(data);
        if (data['status'] == true && data['data'] != null) {
          setState(() {
            _subcategories = data['data'];
            _hasError = false;
            _isLoading = false;
          });
        } else {
          setState(() {
            _hasError = true;
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
      print('Error fetching subcategories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.categoryName} Services'),
        backgroundColor: Colors.orange,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasError
          ? const Center(
        child: Text(
          'Failed to load subcategories',
          style: TextStyle(color: Colors.red),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: _subcategories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 👈 3 cards per row
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            final sub = _subcategories[index];
            final name = sub['name'] ?? 'No Name';
              final imageUrl = 'http://192.168.137.1:8000/uploads/${sub['image']}';

            return GestureDetector(
              onTap: () {
                print('Tapped on subcategory: $name');
              },
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: Image.network(
                        imageUrl,
                        height: 70,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
