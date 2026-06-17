import 'package:flutter/material.dart';

/// CartProvider manages cart state globally
class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  int get totalPrice {
    return _cartItems.fold(0, (sum, item) {
      final int price = item["price"] as int;
      final int quantity = item["quantity"] as int;
      return sum + price * quantity;
    });
  }

  void addToCart(Map<String, dynamic> product) {
    final existingIndex = _cartItems.indexWhere((item) => item["name"] == product["name"]);
    if (existingIndex != -1) {
      _cartItems[existingIndex]["quantity"]++;
    } else {
      _cartItems.add({
        "name": product["name"],
        "price": product["price"],
        "image": product["image"],
        "quantity": 1,
        "isFavorite": false,
      });
    }
    notifyListeners();
  }

  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void toggleFavorite(int index) {
    _cartItems[index]["isFavorite"] = !_cartItems[index]["isFavorite"];
    notifyListeners();
  }

  void increaseQuantity(int index) {
    _cartItems[index]["quantity"]++;
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (_cartItems[index]["quantity"] > 1) {
      _cartItems[index]["quantity"]--;
      notifyListeners();
    }
  }
}
