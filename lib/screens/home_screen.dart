import 'package:flutter/material.dart';
import '../models/vendor.dart';
import 'add_vendor_screen.dart';
import 'vendor_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Vendor> vendors = [];

  void addVendor(Vendor vendor) {
    setState(() {
      vendors.add(vendor);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vendor Management"),
      ),
      body: vendors.isEmpty
          ? Center(child: Text("No vendors added yet."))
          : ListView.builder(
              itemCount: vendors.length,
              itemBuilder: (context, index) {
                final vendor = vendors[index];
                return ListTile(
                  title: Text(vendor.name),
                  subtitle: Text(vendor.company),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VendorDetailScreen(vendor: vendor),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddVendorScreen(),
            ),
          );
          if (result != null && result is Vendor) {
            addVendor(result);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
