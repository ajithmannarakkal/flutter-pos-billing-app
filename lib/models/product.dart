class Product {
  final String id;
  final String name;
  final double price;
  Product({required this.id, required this.name, required this.price});
  factory Product.fromMap(String id, Map<String, dynamic> map) {
    return Product(
      id: id,
      name: map['name'],
      price: (map['price'] as num).toDouble(),
    );
  }
}
