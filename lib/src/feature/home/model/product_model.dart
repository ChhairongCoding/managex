class ProductModel {
  final int id;
  final String name;
  final String sku;
  final String category;
  final double price;
  final int qty;
  final int inStock;
  final String imageUrl;

  ProductModel({
    required this.id,
    required this.name,
    required this.sku,
    required this.category,
    required this.price,
    required this.qty,
    required this.inStock,
    required this.imageUrl,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      sku: map['sku'],
      category: map['category'],
      price: map['price'],
      qty: map['qty'],
      inStock: map['inStock'],
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sku': sku,
      'category': category,
      'price': price,
      'qty': qty,
      'inStock': inStock,
      'imageUrl': imageUrl,
    };
  }
}
