import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: CartScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems = [
    {
      'name': 'Hint Water Variety Pack',
      'subtitle': '12 x 16 oz',
      'price': 19.99,
      'quantity': 1,
      'image': 'https://i.imgur.com/QpZf5SJ.png',
    },
    {
      'name': 'Charmin Ultra Strong Double Roll',
      'subtitle': '36 Count',
      'price': 19.99,
      'quantity': 1,
      'image': 'https://i.imgur.com/XOkazZz.png',
    },
    {
      'name': 'Vaseline Petroleum Jelly Original',
      'subtitle': '2 x 13 oz',
      'price': 7.99,
      'quantity': 1,
      'image': 'https://i.imgur.com/6zrbEAm.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    double subtotal = cartItems.fold(
      0,
          (total, item) => total + (item['price'] * item['quantity']),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('YOUR CART'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.close)),
        ],
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Standard Delivery (${cartItems.length})'),
            trailing: Text(
              '\$${subtotal.toStringAsFixed(2)}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.green.shade100,
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                'Add \$2.03 for free shipping!',
                style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                var item = cartItems[index];
                return ListTile(
                  leading: Image.network(item['image'], width: 60),
                  title: Text(item['name']),
                  subtitle: Text(item['subtitle']),
                  trailing: Container(
                    width: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove_circle, color: Colors.pink),
                          onPressed: () {},
                        ),
                        Text(item['quantity'].toString()),
                        IconButton(
                          icon: Icon(Icons.add_circle, color: Colors.pink),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('SUBTOTAL', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('\$${subtotal.toStringAsFixed(2)}',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {},
              child: Text(
                'PROCEED TO CHECKOUT',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
