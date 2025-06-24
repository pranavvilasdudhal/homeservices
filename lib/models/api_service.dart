import 'dart:convert';
import 'package:http/http.dart' as http;
import 'category_model.dart';
import 'subcategory_model.dart';

class ApiService {
  static const String baseUrl = "http://192.168.189.212:8000/api";

  // Fetch categories
  Future<CategoryResponse> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/cat'));

    if (response.statusCode == 200) {
      print("Success: ${response.body}");
      return CategoryResponse.fromJson(json.decode(response.body));
    } else {
      print("Failed to load. Status: ${response.statusCode}");
      throw Exception('Failed to load categories');
    }
  }

  // Fetch subcategories by categoryId
  Future<List<SubCategory>> fetchSubCategories(int categoryId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/subcategories?category_id=$categoryId'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['data'] as List)
          .map((item) => SubCategory.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load subcategories');
    }
  }
}
