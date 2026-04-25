class InventoryModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final bool isLowStock;
  final String productType;
  final Map<String, int>? variant;

  InventoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.isLowStock,
    required this.productType,
    this.variant,
  });

  factory InventoryModel.fromMap(Map<String, dynamic> map) {
    return InventoryModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      quantity: map['quantity'],
      isLowStock: map['isLowStock'],
      productType: map['productType'],
      variant: map['variant'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'isLowStock': isLowStock,
      'variant': variant,
    };
  }
}

class VariantModel {
  final int id;
  final String name;
  final int quantity;
  final String color;

  VariantModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.color,
  });

  factory VariantModel.fromMap(Map<String, dynamic> map) {
    return VariantModel(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'],
      color: map['color'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'quantity': quantity, 'color': color};
  }
}
