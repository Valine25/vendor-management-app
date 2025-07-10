import 'package:flutter/material.dart';
import '../models/vendor.dart';
import 'vendor_detail_screen.dart';

class VendorListScreen extends StatelessWidget {
  final List<Vendor> vendors;
  final bool showOnlyFlagged;

  VendorListScreen({required this.vendors, this.showOnlyFlagged = false});

  @override
  Widget build(BuildContext context) {
    final filteredVendors = showOnlyFlagged
        ? vendors.where((v) => v.isInactive).toList()
        : vendors;

    return Scaffold(
      appBar: AppBar(
        title: Text(showOnlyFlagged ? "Flagged Vendors" : "All Vendors"),
      ),
      body: filteredVendors.isEmpty
          ? Center(
              child: Text(
                showOnlyFlagged
                    ? "No flagged vendors found."
                    : "No vendors found.",
              ),
            )
          : ListView.builder(
              itemCount: filteredVendors.length,
              itemBuilder: (context, index) {
                final vendor = filteredVendors[index];
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
    );
  }
}
