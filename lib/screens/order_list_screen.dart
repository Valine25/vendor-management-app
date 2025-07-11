import 'package:flutter/material.dart';
import '../models/vendor.dart';
import '../database/db_helper.dart';

class OrderListScreen extends StatefulWidget {
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  List<Vendor> _vendors = [];

  @override
  void initState() {
    super.initState();
    _loadVendors();
  }

  Future<void> _loadVendors() async {
    final vendors = await DBHelper().getAllVendorsWithOrders(); 
    setState(() {
      _vendors = vendors;
    });
  }

  @override
  Widget build(BuildContext context) {
    final allOrders = _vendors.expand((v) => v.orders).toList();

    return Scaffold(
      appBar: AppBar(title: Text("All Orders")),
      backgroundColor: Color(0xFF121212),
      body: allOrders.isEmpty
          ? Center(child: Text("No orders yet", style: TextStyle(color: Colors.white70)))
          : ListView.builder(
              itemCount: allOrders.length,
              itemBuilder: (context, index) {
                final order = allOrders[index];
                return Card(
                  color: Color(0xFF1E1E1E),
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(order.product, style: TextStyle(color: Colors.white)),
                    subtitle: Text(
                      "Qty: ${order.quantity}, Date: ${order.date.toLocal().toString().split(' ')[0]}",
                      style: TextStyle(color: Colors.white70),
                    ),
                    trailing: Text(order.status, style: TextStyle(color: Colors.deepPurpleAccent)),
                  ),
                );
              },
            ),
    );
  }
}
