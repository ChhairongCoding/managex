class InventoryModel {
  final int id;
  final String name;
  final double price;
  int quantity;
  final bool isLowStock;
  final String productType;
  final Map<String, int>? variant;

  InventoryModel({
    required this.id,
    required this.name,
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
      'price': price,
      'quantity': quantity,
      'isLowStock': isLowStock,
      'variant': variant,
    };
  }

  InventoryModel copyWith({required int quantity}) {
    return copyWith(quantity: quantity);
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
