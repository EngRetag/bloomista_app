import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bloomista_app/cart_provider.dart';

/// ProductDetailsScreen:
/// This screen displays the details of a single product (image, name, price, description).
/// It also provides an "Add to Cart" button that adds the product directly
/// to the global CartProvider and shows a confirmation SnackBar.
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Product image
            Image.asset(
              product["image"],
              width: 200,
              height: 200,
              fit: BoxFit.cover,
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
            const Text(
              "This is a beautiful bouquet, perfect for gifting.",
              textAlign: TextAlign.center,
            ),

            const Spacer(),

            // Add to Cart button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Add product to CartProvider
                  Provider.of<CartProvider>(context, listen: false).addToCart(product);

                  // Show confirmation SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${product["name"]} added to cart!"),
                      action: SnackBarAction(
                        label: "Go to Cart",
                        onPressed: () {
                          Navigator.pushNamed(context, '/cart');
                        },
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Add to Cart"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
