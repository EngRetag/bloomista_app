import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bloomista_app/cart_provider.dart';

// Helper function to display a floating SnackBar notification that auto-dismisses after 2 seconds
void showAddToCartSnackBar(BuildContext context, String productName) {
  // 1. Clear any active SnackBars immediately to prevent queuing
  ScaffoldMessenger.of(context).clearSnackBars();

  // 2. Display the floating SnackBar notification above screen elements
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2), // Auto-dismisses after 2 seconds
      behavior: SnackBarBehavior.floating,  // Floats above bottom navigation and buttons
      margin: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
      backgroundColor: Colors.pink,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "$productName added to cart!",
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              Navigator.pushNamed(context, '/cart');
            },
            child: const Text(
              "Go to Cart",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

/// ProductDetailsScreen:
/// Displays details of a single product (image, name, price, description)
/// and provides an "Add to Cart" button with styled feedback.
class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve product data passed through Navigator arguments
    final product = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: const Color(0xFFFDECEF),
      appBar: AppBar(
        title: const Text("Product Details"),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white, // Guarantees white title and back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Product image
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                product["image"],
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // Product name and price
            Text(
              "${product["name"]}\n${product["price"]} EGP",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            // Product description
            Text(
              product["description"] ?? "This is a beautiful bouquet, perfect for gifting.",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),

            const Spacer(),

            // Add to Cart button styled with pill shape and 2-second floating SnackBar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Add product to CartProvider state
                  Provider.of<CartProvider>(context, listen: false).addToCart(product);
                  // Trigger floating 2-second notification SnackBar
                  showAddToCartSnackBar(context, product["name"]);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white, // Ensures crisp white text color
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}