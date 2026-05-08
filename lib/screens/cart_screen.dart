import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  // Cart items with image paths
  final List<Map<String, dynamic>> cartItems = const [
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDECEF),
      appBar: AppBar(
        title: const Text("Shopping Cart"),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Card(
                    child: ListTile(
                      // Product image instead of icon
                      leading: Image.asset(
                        item["image"],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item["name"]),
                      trailing: Text(item["price"]),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Shipping and total
            const Text("Shipping Loan: 1500 EGP"),
            const SizedBox(height: 10),
            const Text(
              "Total: 2750 EGP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Checkout button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/thankyou');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Proceed to Checkout"),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNav(context, 2),
    );
  }

  // Bottom Navigation Bar
  BottomNavigationBar buildBottomNav(BuildContext context, int currentIndex) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: Colors.pink,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index == 0) Navigator.pushNamed(context, '/catalog');
        if (index == 1) Navigator.pushNamed(context, '/categories');
        if (index == 2) Navigator.pushNamed(context, '/cart');
        if (index == 3) Navigator.pushNamed(context, '/profile');
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}
