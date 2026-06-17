import 'package:flutter/material.dart';
import 'dart:math'; // For generating random order number

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  // Function to generate random order number
  String _generateOrderNumber() {
    final random = Random();
    // Generate a random 8-digit number
    int orderNumber = 10000000 + random.nextInt(90000000);
    return orderNumber.toString();
  }

  @override
  Widget build(BuildContext context) {
    final orderNumber = _generateOrderNumber(); // Generate once when screen builds

    return Scaffold(
      backgroundColor: const Color(0xFFFDECEF),
      appBar: AppBar(
        title: const Text("Order Confirmation"),
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Thank You!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              color: Colors.pink,
            ),
            const SizedBox(height: 20),

            // Dynamic order number
            Text(
              "Order #$orderNumber",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 30),

            // Back to Home Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/catalog');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text("Back to Home"),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Default to Home
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
      ),
    );
  }
}
