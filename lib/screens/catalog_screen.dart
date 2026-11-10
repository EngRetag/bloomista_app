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

// ProductCard widget to display product info, discount badges, and action buttons
class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final Function(Map<String, dynamic>) onAddToCart;
  final Function(Map<String, dynamic>) onViewDetails;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    // Check if the product has a discount/sale
    final bool isOnSale = product["onSale"] ?? false;
    final int? oldPrice = product["oldPrice"];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Stack to overlay the "SALE" badge over the product image
          GestureDetector(
            onTap: () => onViewDetails(product),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    product["image"],
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                // Display SALE badge if product is on sale
                if (isOnSale)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "SALE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Product name
          Text(
            product["name"],
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),

          // Product price section (displays old price with line-through if available)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (oldPrice != null) ...[
                Text(
                  "$oldPrice EGP",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 6),
              ],
              Text(
                "${product["price"]} EGP",
                style: const TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Add to Cart button styled with requested padding and border radius
          ElevatedButton(
            onPressed: () => onAddToCart(product),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              foregroundColor: Colors.white, // Ensures crisp white text and icon color
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text("Add to Cart"),
          ),
          const SizedBox(height: 5),

          // Details button
          OutlinedButton(
            onPressed: () => onViewDetails(product),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.pink,
              side: const BorderSide(color: Colors.pink),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text("Details"),
          ),
        ],
      ),
    );
  }
}

// CatalogScreen with product list, bottom navigation, and cart integration
class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  // Static const product list definition
  static const products = [
    {
      "name": "Red Roses Bouquet",
      "price": 750,
      "oldPrice": 850,
      "onSale": true,
      "image": "assets/images/Red_Roses_Bouquet.png",
      "description": "A stunning bouquet of red roses, symbolizing love and passion."
    },
    {
      "name": "Blue Roses Bouquet",
      "price": 500,
      "oldPrice": 550,
      "onSale": true,
      "image": "assets/images/Blue_Roses_Bouquet.png",
      "description": "Elegant blue roses that represent mystery and uniqueness."
    },
    {
      "name": "Red & White Roses Bouquet",
      "price": 600,
      "oldPrice": 630,
      "onSale": true,
      "image": "assets/images/Red_White_Roses_Bouquet.png",
      "description": "A romantic mix of red and white roses, perfect for special occasions."
    },
    {
      "name": "Golden Roses Bouquet",
      "price": 300,
      "oldPrice": 340,
      "onSale": true,
      "image": "assets/images/Golden_Roses_Bouquet.png",
      "description": "Golden roses that shine with elegance and luxury."
    },
  ];

  // Function to handle adding product to cart and triggering the temporary notification
  void _addToCart(BuildContext context, Map<String, dynamic> product) {
    Provider.of<CartProvider>(context, listen: false).addToCart(product);
    showAddToCartSnackBar(context, product["name"]);
  }

  // Function to view product details
  void _viewDetails(BuildContext context, Map<String, dynamic> product) {
    Navigator.pushNamed(context, '/product', arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDECEF),
      appBar: AppBar(
        title: const Text("Catalog"),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.62, // Adjusted ratio to comfortably accommodate padded buttons without layout overflow
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            product: product,
            onAddToCart: (p) => _addToCart(context, p),
            onViewDetails: (p) => _viewDetails(context, p),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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