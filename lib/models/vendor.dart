import 'order.dart';

class Vendor {
  int? id;
  String name;
  String company;
  String contact;
  List<String> products;
  String feedback;
  double rating;
  List<Order> orders;
  bool isInactive;

  Vendor({
    this.id,
    required this.name,
    required this.company,
    required this.contact,
    required this.products,
    this.feedback = '',
    this.rating = 0.0,
    this.orders = const [],
    this.isInactive = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'company': company,
      'contact': contact,
      'products': products.join(','),
      'feedback': feedback,
      'rating': rating,
      'isInactive': isInactive ? 1 : 0,
    };
  }

  factory Vendor.fromMap(Map<String, dynamic> map) {
    return Vendor(
      id: map['id'],
      name: map['name'],
      company: map['company'],
      contact: map['contact'],
      products: map['products'].toString().split(','),
      feedback: map['feedback'],
      rating: map['rating'] is int
          ? (map['rating'] as int).toDouble()
          : map['rating'],
      isInactive: map['isInactive'] == 1,
    );
  }
}
