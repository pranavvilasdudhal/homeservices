import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';


import 'categorydetail.dart';
// ✅ Import the subcategory page

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
  List<dynamic> _categories = [];
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }


  Future<void> fetchCategories() async {
    final url = Uri.parse("http://192.168.1.50:8000/api/cat");

    try {
      final response = await http.get(url).timeout(Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == true && data['data'] != null) {
          setState(() {
            _categories = data['data'];
            _hasError = false;
          });
        } else {
          setState(() => _hasError = true);
        }
      } else {
        setState(() => _hasError = true);
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      setState(() => _hasError = true);
      print('Error fetching categories: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  IconData _getIconForCategory(String name) {
    switch (name.toLowerCase()) {
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


  Widget categoryItem(int id, String name) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SubCategoryPage(
                categoryId: id,
                categoryName: name,
              ),
            ),
          );
        },

        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(_getIconForCategory(name), size: 30, color: Colors.deepPurple),
              SizedBox(height: 10),
              Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            Icon(Icons.home_repair_service, color: Colors.orange),
            SizedBox(width: 8),
            Text("NOBROKER", style: TextStyle(color: Colors.black)),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.location_on_outlined, color: Colors.black),
            label: Text("Pune", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: Colors.black,
        animationDuration: Duration(milliseconds: 500),
        // onTap: (int index){
        //   setState(() {
        //     currentTabIndex=index;
        //   });
        // },
        items: [
          Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_bag_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.wallet_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.person_outline,
            color: Colors.white,
          ),
        ],),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.orange[100],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("HEATWAVE Indoors?",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("More Services",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      if (_hasError)
                        Center(
                          child: Text(
                            "Failed to fetch categories",
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        )
                      else if (_categories.isEmpty)
                        Center(child: CircularProgressIndicator())
                      else
                        GridView.count(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: _categories.map<Widget>((category) {
                            final id = category['category_id'] ?? 0; // fallback to 0 if null
                            final name = category['name'] ?? 'No Name';
                            return categoryItem(id, name);
                          }).toList(),

                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
