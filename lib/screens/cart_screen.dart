import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bloomista_app/cart_provider.dart';// Import the provider file

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
        child: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            final cartItems = cartProvider.cartItems;

            return Column(
              children: [
                Expanded(
                  child: cartItems.isEmpty
                      ? const Center(child: Text("Your cart is empty"))
                      : ListView.separated(
                          itemCount: cartItems.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final item = cartItems[index];
                            return Card(
                              child: ListTile(
                                leading: Image.asset(item["image"], width: 50, height: 50),
                                title: Text(item["name"]),
                                subtitle: Text("${item["price"]} EGP"),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(item["isFavorite"]
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                          color: Colors.pink),
                                      onPressed: () => cartProvider.toggleFavorite(index),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle, color: Colors.pink),
                                      onPressed: () => cartProvider.decreaseQuantity(index),
                                    ),
                                    Text("${item["quantity"]}"),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle, color: Colors.pink),
                                      onPressed: () => cartProvider.increaseQuantity(index),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      onPressed: () => cartProvider.removeFromCart(index),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
                const SizedBox(height: 20),
                Text("Total: ${cartProvider.totalPrice} EGP",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: cartItems.isEmpty
                        ? null
                        : () {
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
            );
          },
        ),
      ),
    );
  }
}
