import 'package:flutter/material.dart';

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
        onTap: (index) {
          // Handle navigation tap
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner and Search
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

            // Categories Grid
            Padding(
              padding: EdgeInsets.all(12),
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [

                  categoryItem(Icons.cleaning_services, 'Home Cleaning'),
                  categoryItem(Icons.car_repair, 'Car Services'),
                  categoryItem(Icons.electrical_services, 'Electrical '),
                ],
              ),
            ),

            // Offers & Cards
            offerCard(),
            horizontalServiceScroll("Home Cleaning Services", [
              'Bathroom Cleaning', 'Kitchen Cleaning', 'Sofa Cleaning', 'Carpet Cleaning'
            ]),

            // gridServices("Popular Services", [
            //   'Packers & Movers', 'Home Painting', 'Home Renovation', 'Wall Panelling'
            // ]),

            vipCard(),
            spotlightSection(),
            horizontalServiceScroll("Home Repair Services", [
              'Tap Repair', 'Switch Board', 'Geyser Repair'
            ]),

            relocationSection(),
            customerReviews(),
            faqSection(),
          ],
        ),
      ),
    );
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
          Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget offerCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget horizontalServiceScroll(String title, List<String> services) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                            "assets/images/image-1.png",
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
            ],
          ),
        ),


      ],
    );
  }

  Widget gridServices(String title, List<String> services) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: services.map((service) => Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 4)],
              ),
              child: Text(service, style: TextStyle(fontSize: 14)),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget vipCard() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text("VIP Membership - ₹199/year. 15% off on all services!",
            style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget spotlightSection() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        height: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage('https://via.placeholder.com/300x150'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget relocationSection() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Text("Relocation Simplified", style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget customerReviews() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Customer Reviews", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text("Home Cleaning was smooth and affordable!"),
          ),
        ],
      ),
    );
  }

  Widget faqSection() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Frequently Asked Questions", style: TextStyle(fontWeight: FontWeight.bold)),
          ExpansionTile(
            title: Text("How to book a service?"),
            children: [Text("You can book via app easily with just 3 steps")],
          ),
          ExpansionTile(
            title: Text("Is there a refund policy?"),
            children: [Text("Yes, within 24 hours after service.")],
          ),
        ],
      ),
    );
  }
}
