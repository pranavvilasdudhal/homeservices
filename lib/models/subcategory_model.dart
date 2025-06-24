class SubCategory {
  final int id;
  final String name;
  final String? image;

  SubCategory({required this.id, required this.name, this.image});

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['sub_category_id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
