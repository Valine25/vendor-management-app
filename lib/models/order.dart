class Order {
  int? id;
  int vendorId;
  String product;
  int quantity;
  String status;
  DateTime date;

  Order({
    this.id,
    required this.vendorId,
    required this.product,
    required this.quantity,
    required this.status,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'vendorId': vendorId,
      'product': product,
      'quantity': quantity,
      'status': status,
      'date': date.toIso8601String(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      vendorId: map['vendorId'],
      product: map['product'],
      quantity: map['quantity'],
      status: map['status'],
      date: DateTime.parse(map['date']),
    );
  }
}
