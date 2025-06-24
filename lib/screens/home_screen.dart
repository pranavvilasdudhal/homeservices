import 'package:flutter/material.dart';
import '../models/api_service.dart';
import '../models/category_model.dart';
import 'categorydetail.dart';

List<Map<String, String>> services = [
  {
    'title': 'Bathroom Cleaning',
    'image': 'assets/images/image-1.png',
  },
  {
    'title': 'Kitchen Cleaning',
    'image': 'assets/images/im2.jpg',
  },
  {
    'title': 'Premium Cleaning',
    'image': 'assets/images/im3.jpg',
  },
  {
    'title': 'Sofa Cleaning',
    'image': 'assets/images/im4.jpg',
  },
  {
    'title': 'Carpet Cleaning',
    'image': 'assets/images/im5.jpg',
  },
];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();
  late Future<CategoryResponse> _futureCategories;

  @override
  void initState() {
    super.initState();
    _futureCategories = _apiService.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.home_repair_service, color: Colors.orange),
            SizedBox(width: 8),
            Text("NOBROKER", style: TextStyle(color: Colors.black)),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.location_on_outlined, color: Colors.black),
            label: Text("Pune", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        onTap: (index) {},
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.orange[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("HEATWAVE Indoors?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Washing Machine...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 12, right: 4),
                    child: Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.teal.shade100),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Image.asset(
                            services[index]['image']!,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: 6),
                        SizedBox(
                          width: 80,
                          child: Text(
                            services[index]['title']!,
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("More Services", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  FutureBuilder<CategoryResponse>(
                    future: _futureCategories,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text("Error loading categories");
                      } else if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
                        return Text("No categories available");
                      } else {
                        return GridView.count(
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: snapshot.data!.data.map((category) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryDetailPage(category: category),
                                  ),
                                );
                              },
                              child: categoryItem(
                                _getIconForCategory(category.name),
                                category.name,
                              ),
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForCategory(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'home service':
        return Icons.home;
      case 'car service':
        return Icons.directions_car;
      case 'electronic service':
        return Icons.electrical_services;
      default:
        return Icons.category;
    }
  }

  Widget categoryItem(IconData icon, String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.deepPurple),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
