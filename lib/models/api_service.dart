import 'dart:convert';
import 'package:http/http.dart' as http;
import 'category_model.dart';

class ApiService {
  static const String baseUrl = "http://192.168.1.5:8000/api"; // ✅ Fix base URL

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
}
