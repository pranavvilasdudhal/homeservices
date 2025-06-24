class CategoryResponse {
  final bool status;
  final String message;
  final List<Category> data;

  CategoryResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      status: json['status'],
      message: json['message'],
      data: List<Category>.from(json['data'].map((x) => Category.fromJson(x))),
    );
  }
}

class Category {
  final int categoryId;
  final String name;
  final String image;
  final String createdAt;
  final String updatedAt;

  Category({
    required this.categoryId,
    required this.name,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['category_id'],
      name: json['name'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
