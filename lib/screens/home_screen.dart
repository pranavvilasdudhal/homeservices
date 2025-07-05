import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:untitled/screens/bookings_screen.dart';
import 'package:untitled/screens/cart_page.dart';
import 'package:untitled/screens/profile_page.dart';
import '../screens/categorydetail.dart';

List<Map<String, String>> services = [
  {'title': 'Bathroom Cleaning',
    'image': 'assets/images/image-1.png'},
  {'title': 'Kitchen Cleaning',
    'image': 'assets/images/im2.jpg'},
  {'title': 'Premium Cleaning',
    'image': 'assets/images/im3.jpg'},
  {'title': 'Sofa Cleaning',
    'image': 'assets/images/im4.jpg'},
  {'title': 'Carpet Cleaning',
    'image': 'assets/images/im5.jpg'},
];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<dynamic> _categories = [];
  bool _hasError = false;

  final List<Widget> _pages = [
    const Center(child: Text("🏠 Home Page Content")), // Index 0
    BookingForm(),                                     // Index 1
    CartScreen(),                                      // Index 2
    ProfilePage(),                                     // Index 3
  ];


  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final url = Uri.parse("http://192.168.1.14:8000/api/cat");
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
      }
    } catch (e) {
      setState(() => _hasError = true);
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

  // 🔁 Reusable Nav Item
  Widget _navItem(IconData icon) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(4),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: const [
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

      // ✅ Bottom Navigation
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: Colors.black,
        animationDuration: const Duration(milliseconds: 500),
        index: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          _navItem(Icons.home_outlined),
          _navItem(Icons.shopping_bag_outlined),
          _navItem(Icons.shopping_cart),
          _navItem(Icons.person_outline),
        ],
      ),

      // ✅ Main Body based on selected index
      body: _selectedIndex == 0 ? SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.orange[100],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("HEATWAVE Indoors?",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search Washing Machine...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // 🔄 Service Horizontal List
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
                              padding: const EdgeInsets.all(8),
                              child: Image.asset(
                                services[index]['image']!,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 6),
                            SizedBox(
                              width: 80,
                              child: Text(
                                services[index]['title']!,
                                style: const TextStyle(fontSize: 12),
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

                // 🔽 Categories Grid
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("More Services",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      if (_hasError)
                        const Center(
                          child: Text(
                            "Failed to fetch categories",
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        )
                      else if (_categories.isEmpty)
                        const Center(child: CircularProgressIndicator())
                      else
                        GridView.count(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: _categories.map<Widget>((category) {
                            final id = category['category_id'] ?? 0;
                            final name = category['name'] ?? 'No Name';
                            return categoryItem(id, name);
                          }).toList(),
                        ),
                    ],
                  ),
                ),

                Container(
                  height: 30,
                ),

                Container(
                  child: Column(
                    children: [
                      Image.asset("assets/images/im6.png",
                        fit: BoxFit.cover, // Add fit property for better image rendering
                        width: double.infinity, // Set image width to full container width
                        height: 150, // Set image height
                      ),
                    ],
                  ),
                ),



                const SizedBox(height: 35),

                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    Card(
                      elevation: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/im8.jpg', fit: BoxFit.cover, height: 100, width: double.infinity),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('AirIndia Flights', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('From ₹1,299', style: TextStyle(color: Colors.green)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      elevation: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/im9.jpg', fit: BoxFit.cover, height: 100, width: double.infinity),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Biggest Price Drop', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('Just ₹699', style: TextStyle(color: Colors.green)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      elevation: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/im12.jpg', fit: BoxFit.cover, height: 100, width: double.infinity),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Car Mechanic', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('Just ₹699', style: TextStyle(color: Colors.green)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      elevation: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/im13.jpg', fit: BoxFit.cover, height: 100, width: double.infinity),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Ac Repair vala', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('Just ₹699', style: TextStyle(color: Colors.green)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Add more cards below following the same pattern...
                  ],
                ),

                Container(
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.all(10)),
                      Text("Shop by Categories"),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Card(
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/im14.jpg",
                                    height: 100,
                                    width: 100,
                                    alignment: FractionalOffset.centerRight,
                                  ),
                                  Text("fresh"),
                                  Text("Rs.35"),
                                  ElevatedButton(
                                    onPressed: () {
                                      print("Add to Cart");
                                    },
                                    child: Text("Add to Cart"),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/image-1.png",
                                    height: 100,
                                    width: 100,
                                    alignment: FractionalOffset.centerRight,
                                  ),
                                  Text("fresh"),
                                  Text("Rs.50"),
                                  ElevatedButton(
                                    onPressed: () {
                                      print("Add to Cart");
                                    },
                                    child: Text("Add to Cart"),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/im15.jpg",
                                    height: 100,
                                    width: 100,
                                    alignment: FractionalOffset.centerRight,
                                  ),
                                  Text("fresh"),
                                  Text("Rs.25"),
                                  ElevatedButton(
                                    onPressed: () {
                                      print("Add to Cart");
                                    },
                                    child: Text("Add to Cart"),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/image-1.png",
                                    height: 100,
                                    width: 100,
                                    alignment: FractionalOffset.centerRight,
                                  ),
                                  Text("fresh"),
                                  Text("Rs.25"),
                                  ElevatedButton(
                                    onPressed: () {
                                      print("Add to Cart");
                                    },
                                    child: Text("Add to Cart"),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/image-1.png",
                                    height: 100,
                                    width: 100,
                                    alignment: FractionalOffset.centerRight,
                                  ),
                                  Text("fresh"),
                                  Text("Rs.25"),
                                  ElevatedButton(
                                    onPressed: () {
                                      print("Add to Cart");
                                    },
                                    child: Text("Add to Cart"),
                                  ),
                                ],
                              ),
                            ),

                            Card(
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/image-1.png",
                                    height: 100,
                                    width: 100,
                                    alignment: FractionalOffset.centerRight,
                                  ),
                                  Text("fresh"),
                                  Text("Rs.25"),
                                  ElevatedButton(
                                    onPressed: () {
                                      print("Add to Cart");
                                    },
                                    child: Text("Add to Cart"),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/image-1.png",
                                    height: 100,
                                    width: 100,
                                    alignment: FractionalOffset.centerRight,
                                  ),
                                  Text("fresh"),
                                  Text("Rs.25"),
                                  ElevatedButton(
                                    onPressed: () {
                                      print("Add to Cart");
                                    },
                                    child: Text("Add to Cart"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 30,
                      ),

                      Container(
                        child: Column(
                          children: [
                            Image.asset("assets/images/im6.png",
                              fit: BoxFit.cover, // Add fit property for better image rendering
                              width: double.infinity, // Set image width to full container width
                              height: 150, // Set image height
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 35),

                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    Card(
                      elevation: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/im8.jpg', fit: BoxFit.cover, height: 100, width: double.infinity),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('AirIndia Flights', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('From ₹1,299', style: TextStyle(color: Colors.green)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      elevation: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/im9.jpg', fit: BoxFit.cover, height: 100, width: double.infinity),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Biggest Price Drop', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('Just ₹699', style: TextStyle(color: Colors.green)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      elevation: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/im12.jpg', fit: BoxFit.cover, height: 100, width: double.infinity),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Car Mechanic', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('Just ₹699', style: TextStyle(color: Colors.green)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      elevation: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/im13.jpg', fit: BoxFit.cover, height: 100, width: double.infinity),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Ac Repair vala', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('Just ₹699', style: TextStyle(color: Colors.green)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Add more cards below following the same pattern...
                  ],
                )


              ],
            ),
          ),
        ),
      )
          :
      _pages[_selectedIndex],
    );
  }
}
