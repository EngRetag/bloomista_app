import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bloomista_app/cart_provider.dart';

// ProductCard widget to display product info and actions
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Product image
          GestureDetector(
            onTap: () => onViewDetails(product),
            child: Image.asset(
              product["image"],
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
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
            "${product["price"]} EGP",
            style: const TextStyle(color: Colors.pink),
          ),
          const SizedBox(height: 10),

          // Add to Cart button
          ElevatedButton(
            onPressed: () => onAddToCart(product),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text("Add to Cart"),
          ),
          const SizedBox(height: 5),

          // Details button
          OutlinedButton(
            onPressed: () => onViewDetails(product),
            style: OutlinedButton.styleFrom(
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

// CatalogScreen with product list and cart functionality
class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  // Product list
  final List<Map<String, dynamic>> products = const [
    {
      "name": "Red Roses Bouquet",
      "price": 750,
      "image": "assets/images/Red_Roses_Bouquet.png",
      "description": "A stunning bouquet of red roses, symbolizing love and passion."
    },
    {
      "name": "Blue Roses Bouquet",
      "price": 600,
      "image": "assets/images/Blue_Roses_Bouquet.png",
      "description": "Elegant blue roses that represent mystery and uniqueness."
    },
    {
      "name": "Red & White Roses Bouquet",
      "price": 650,
      "image": "assets/images/Red_White_Roses_Bouquet.png",
      "description": "A romantic mix of red and white roses, perfect for special occasions."
    },
    {
      "name": "Golden Roses Bouquet",
      "price": 400,
      "image": "assets/images/Golden_Roses_Bouquet.png",
      "description": "Golden roses that shine with elegance and luxury."
    },
  ];

  // Function to add product to cart using CartProvider
  void _addToCart(BuildContext context, Map<String, dynamic> product) {
    Provider.of<CartProvider>(context, listen: false).addToCart(product);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${product["name"]} added to cart!"),
        backgroundColor: Colors.pink,
        action: SnackBarAction(
          label: "Go to Cart",
          textColor: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
        ),
      ),
    );
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
          return ProductCard(
            product: product,
            onAddToCart: (p) => _addToCart(context, p),
            onViewDetails: (p) => _viewDetails(context, p),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
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
