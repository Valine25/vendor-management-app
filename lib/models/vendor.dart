
class Order {
  String product;
  int quantity;
  DateTime date;
  String status;

  Order({
    required this.product,
    required this.quantity,
    required this.date,
    required this.status,
  });
}

class Vendor {
  String name;
  String company;
  String contact;
  List<String> products;
  List<Order> orders;
  String feedback;
  int rating;
  bool isInactive;

  Vendor({
    required this.name,
    required this.company,
    required this.contact,
    required this.products,
    List<Order>? orders,
    this.feedback = '',
    this.rating = 0,
    this.isInactive = false,
  }): this.orders=orders?? [];
}
