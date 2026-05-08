import 'package:flutter/material.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  // Product list with image paths
  final List<Map<String, dynamic>> products = const [
    {
      "name": "Red Roses Bouquet",
      "price": "750 EGP",
      "image": "assets/images/Red_Roses_Bouquet.png"
    },
    {
      "name": "Blue Roses Bouquet",
      "price": "400 EGP",
      "image": "assets/images/Blue_Roses_Bouquet.png"
    },
    {
      "name": "Red & White Roses Bouquet",
      "price": "600 EGP",
      "image": "assets/images/Red_White_Roses_Bouquet.png"
    },
    {
      "name": "Golden Roses Bouquet",
      "price": "600 EGP",
      "image": "assets/images/Golden_Roses_Bouquet.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDECEF),

      appBar: AppBar(
        title: const Text("Catalog"),
        backgroundColor: Colors.pink,
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 items per row
          childAspectRatio: 0.8,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/product');
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Product image
                  Image.asset(
                    product["image"],
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),

                  // Product name
                  Text(
                    product["name"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),

                  // Product price
                  Text(
                    product["price"],
                    style: const TextStyle(color: Colors.pink),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/catalog');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/categories');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/cart');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/profile');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
