import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/cart_item.dart';

final cartProvider = ChangeNotifierProvider<CartProvider>((ref) {
  return CartProvider();
});

class CartProvider extends ChangeNotifier {
  static const String _cartKey = 'user_cart';
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  // Load cart from shared preferences
  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_cartKey)) {
      return;
    }

    final extractedData =
        json.decode(prefs.getString(_cartKey)!) as Map<String, dynamic>;
    final Map<String, CartItem> loadedItems = {};

    extractedData.forEach((productId, cartItemData) {
      loadedItems[productId] = CartItem.fromMap(cartItemData);
    });

    _items = loadedItems;
    notifyListeners();
  }

  // Save cart to shared preferences
  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = _items.map((key, item) => MapEntry(key, item.toMap()));
    await prefs.setString(_cartKey, json.encode(cartData));
    notifyListeners();
  }

  // Add item to cart
  Future<void> addItem(
    String productId,
    double price,
    String title,
    String imageUrl,
    String sellerId,
  ) async {
    if (_items.containsKey(productId)) {
      // Item already in cart, increase quantity
      _items.update(
        productId,
        (existingCartItem) =>
            existingCartItem.copyWith(quantity: existingCartItem.quantity + 1),
      );
    } else {
      // Add new item to cart
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          name: title,
          price: price,
          imageUrl: imageUrl,
          quantity: 1,
          sellerId: sellerId,
          productId: productId,
        ),
      );
    }
    await _saveCart();
  }

  // Remove item from cart
  Future<void> removeItem(String productId) async {
    if (_items.containsKey(productId)) {
      _items.remove(productId);
      await _saveCart();
    }
  }

  // Remove single item (for decreasing quantity)
  Future<void> removeSingleItem(String productId) async {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId]!.quantity > 1) {
      // Decrease quantity if more than 1
      _items.update(
        productId,
        (existingCartItem) =>
            existingCartItem.copyWith(quantity: existingCartItem.quantity - 1),
      );
    } else {
      // Remove item if quantity is 1
      _items.remove(productId);
    }

    await _saveCart();
  }

  // Clear the cart
  Future<void> clear() async {
    _items = {};
    await _saveCart();
  }

  // Check if an item is in the cart
  bool isInCart(String productId) {
    return _items.containsKey(productId);
  }

  // Get the quantity of a specific item in the cart
  int getItemQuantity(String productId) {
    return _items[productId]?.quantity ?? 0;
  }
}
