import 'package:flutter/material.dart';
import '../models/vendor.dart';
import 'add_order_screen.dart'; // we'll create next
import 'add_feedback_screen.dart'; // we'll create after that

class VendorDetailScreen extends StatefulWidget {
  final Vendor vendor;

  VendorDetailScreen({required this.vendor});

  @override
  State<VendorDetailScreen> createState() => _VendorDetailScreenState();
}

class _VendorDetailScreenState extends State<VendorDetailScreen> {
  void toggleInactive() {
    setState(() {
      widget.vendor.isInactive = !widget.vendor.isInactive;
    });
  }

  @override
  Widget build(BuildContext context) {
    final vendor = widget.vendor;

    return Scaffold(
      appBar: AppBar(
        title: Text(vendor.name),
        actions: [
          IconButton(
            icon: Icon(
              vendor.isInactive ? Icons.flag : Icons.flag_outlined,
              color: vendor.isInactive ? Colors.red : null,
            ),
            tooltip: vendor.isInactive ? "Unflag" : "Flag Inactive",
            onPressed: toggleInactive,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            sectionTitle("Vendor Info"),
            detailRow("Company", vendor.company),
            detailRow("Contact", vendor.contact),
            sectionTitle("Products Supplied"),
            ...vendor.products.map((p) => bulletItem(p)),
            SizedBox(height: 16),
            sectionTitle("Feedback & Rating"),
            Text("Rating: ${vendor.rating}/5"),
            if (vendor.feedback.isNotEmpty)
              Text("Feedback: ${vendor.feedback}"),
            SizedBox(height: 16),
            sectionTitle("Order History"),
            if (vendor.orders.isEmpty)
              Text("No orders yet.")
            else
              ...vendor.orders.map((order) => Card(
                    child: ListTile(
                      title: Text(order.product),
                      subtitle: Text(
                          "Qty: ${order.quantity}, Date: ${order.date.toLocal().toString().split(' ')[0]}"),
                      trailing: Text(order.status),
                    ),
                  )),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddOrderScreen(vendor: vendor),
                      ),
                    );
                    if (result != null) setState(() {});
                  },
                  icon: Icon(Icons.add_shopping_cart),
                  label: Text("Add Order"),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddFeedbackScreen(vendor: vendor),
                      ),
                    );
                    if (result != null) setState(() {});
                  },
                  icon: Icon(Icons.feedback),
                  label: Text("Add Feedback"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 4),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text("$label: $value"),
    );
  }

  Widget bulletItem(String value) {
    return Row(
      children: [
        Text("• "),
        Expanded(child: Text(value)),
      ],
    );
  }
}
