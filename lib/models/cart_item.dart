class CartItem {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  int quantity;
  final String sellerId;
  final String productId;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
    required this.sellerId,
    required this.productId,
  });

  // Helper method to convert CartItem to a Map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'sellerId': sellerId,
      'productId': productId,
    };
  }

  // Helper method to create CartItem from Map
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      name: map['name'],
      price: map['price'].toDouble(),
      imageUrl: map['imageUrl'],
      quantity: map['quantity'],
      sellerId: map['sellerId'],
      productId: map['productId'],
    );
  }

  // Calculate total price for this cart item
  double get totalPrice => price * quantity;

  // Create a copy of the cart item with updated quantity
  CartItem copyWith({
    int? quantity,
  }) {
    return CartItem(
      id: id,
      name: name,
      price: price,
      imageUrl: imageUrl,
      quantity: quantity ?? this.quantity,
      sellerId: sellerId,
      productId: productId,
    );
  }
}
