import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bloomista_app/cart_provider.dart';

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

            // Add to Cart button with white text styling and updated SnackBar logic
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Add product to CartProvider
                  Provider.of<CartProvider>(context, listen: false).addToCart(product);

                  // Clear any existing active SnackBars immediately
                  ScaffoldMessenger.of(context).clearSnackBars();

                  // Show floating confirmation SnackBar for 2 seconds
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${product["name"]} added to cart!"),
                      backgroundColor: Colors.pink,
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      action: SnackBarAction(
                        label: "Go to Cart",
                        textColor: Colors.white,
                        onPressed: () {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          Navigator.pushNamed(context, '/cart');
                        },
                      ),
                    ),
                  );
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