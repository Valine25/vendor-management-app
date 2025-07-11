import 'package:flutter/material.dart';
import '../models/vendor.dart';
import 'add_order_screen.dart';
import 'add_feedback_screen.dart';
import '../database/db_helper.dart';

class VendorDetailScreen extends StatefulWidget {
  final Vendor vendor;
  final Function(Vendor updatedVendor)? onVendorUpdated;

  VendorDetailScreen({required this.vendor, this.onVendorUpdated});

  @override
  State<VendorDetailScreen> createState() => _VendorDetailScreenState();
}

class _VendorDetailScreenState extends State<VendorDetailScreen> {
  late Vendor vendor;
  bool isChanged = false;

  @override
  void initState() {
    super.initState();
    vendor = widget.vendor;
  }

  void toggleInactive() async{
    setState(() {
      vendor.isInactive = !vendor.isInactive;
      isChanged = true;
    });
    await DBHelper().updateVendor(vendor);
  }

  Future<bool> _onWillPop() async {
    if (isChanged && widget.onVendorUpdated != null) {
      widget.onVendorUpdated!(vendor);
    }
    Navigator.pop(context);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
            ),
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
                ...vendor.orders.map(
                  (order) => Card(
                    color: const Color(0xFF1E1E1E),
                    child: ListTile(
                      title: Text(
                        order.product,
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        "Qty: ${order.quantity}, Date: ${order.date.toLocal().toString().split(' ')[0]}",
                        style: TextStyle(color: Colors.white60),
                      ),
                      trailing: Text(
                        order.status,
                        style: TextStyle(color: Colors.tealAccent),
                      ),
                    ),
                  ),
                ),

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
                      if (result != null) {
                        final updated = await DBHelper().getVendorById(vendor.id!);
                        if (updated != null) {
                          setState(() {
                            vendor = updated;
                            isChanged = true;
                          });
                        }
                      }
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
                      if (result != null) {
                        final updated = await DBHelper().getVendorById(vendor.id!);
                        if (updated != null) {
                          setState(() {
                            vendor = updated;
                            isChanged = true;
                          });
                        }
                      }
                    },
                    icon: Icon(Icons.feedback),
                    label: Text("Add Feedback"),
                  ),
                ],
              ),
            ],
          ),
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
