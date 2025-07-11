import 'package:flutter/material.dart';
import '../models/vendor.dart';
import '../screens/vendor_detail_screen.dart';
import '../database/db_helper.dart';

class VendorListScreen extends StatefulWidget {
  final List<Vendor> vendors;
  final bool showOnlyFlagged;

  VendorListScreen({required this.vendors, this.showOnlyFlagged = false});

  @override
  _VendorListScreenState createState() => _VendorListScreenState();
}

class _VendorListScreenState extends State<VendorListScreen> {
  late List<Vendor> _filteredVendors;

  @override
  void initState() {
    super.initState();
    _filteredVendors = widget.showOnlyFlagged
        ? widget.vendors.where((v) => v.isInactive).toList()
        : widget.vendors;
  }

  Future<void> _deleteVendor(int id) async {
    await DBHelper().deleteVendor(id);
    setState(() {
      _filteredVendors.removeWhere((vendor) => vendor.id == id);
    });
  }

  void _confirmDelete(int vendorId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Vendor'),
        content: Text('Are you sure you want to delete this vendor?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _deleteVendor(vendorId);
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.showOnlyFlagged ? "Flagged Vendors" : "All Vendors"),
      ),
      body: _filteredVendors.isEmpty
          ? Center(
              child: Text(
                widget.showOnlyFlagged
                    ? "No flagged vendors found."
                    : "No vendors found.",
              ),
            )
          : ListView.builder(
              itemCount: _filteredVendors.length,
              itemBuilder: (context, index) {
                final vendor = _filteredVendors[index];
                return ListTile(
                  title: Text(vendor.name),
                  subtitle: Text(vendor.company),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _confirmDelete(vendor.id!),
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
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
