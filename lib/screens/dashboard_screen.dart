import 'package:flutter/material.dart';
import '../models/vendor.dart';
import 'vendor_detail_screen.dart';
import 'add_vendor_screen.dart';
import 'vendor_list_screen.dart';
import 'order_list_screen.dart';
import 'feedback_list_screen.dart';
import '../widgets/custom_sidebar.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Vendor> vendors = [];
  int selectedTab = 0;

  void addVendor(Vendor vendor) {
    setState(() {
      vendors.add(vendor);
    });
  }

  int get flaggedCount => vendors.where((v) => v.isInactive).length;
  int get orderCount => vendors.fold(0, (sum, v) => sum + v.orders.length);
  int get feedbackCount => vendors.where((v) => v.feedback.isNotEmpty).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: Row(
        children: [
          CustomSidebar(
            selectedIndex: selectedTab,
            onTap: (index) {
              setState(() {
                selectedTab = index;
              });
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: getCurrentTab(),
            ),
          ),
        ],
      ),
      floatingActionButton: selectedTab == 3
          ? FloatingActionButton(
              backgroundColor: Colors.deepPurpleAccent,
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddVendorScreen()),
                );
                if (result != null && result is Vendor) {
                  addVendor(result);
                }
              },
              child: Icon(Icons.add),
              tooltip: "Add Vendor",
            )
          : null,
    );
  }

  Widget getCurrentTab() {
    if (selectedTab == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Vendor Dashboard",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dashboardCard("Total Vendors", vendors.length.toString(), Icons.store),
              dashboardCard("Orders", orderCount.toString(), Icons.shopping_cart),
              dashboardCard("Flagged", flaggedCount.toString(), Icons.flag),
              dashboardCard("Feedbacks", feedbackCount.toString(), Icons.feedback),
            ],
          ),
          SizedBox(height: 30),
          Text(
            "Recent Vendors",
            style: TextStyle(fontSize: 20, color: Colors.white70),
          ),
          SizedBox(height: 10),
          Expanded(
            child: vendors.isEmpty
                ? Center(
                    child: Text(
                      "No vendors yet.",
                      style: TextStyle(color: Colors.white54),
                    ),
                  )
                : ListView.builder(
                    itemCount: vendors.length,
                    itemBuilder: (context, index) {
                      final vendor = vendors[index];
                      return Card(
                        color: Color(0xFF1E1E1E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(vendor.name, style: TextStyle(color: Colors.white)),
                          subtitle: Text(vendor.company, style: TextStyle(color: Colors.white70)),
                          trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => VendorDetailScreen(vendor: vendor),
                              ),
                            );
                            if (result != null && result is Vendor) {
                              setState(() {
                                vendors[index] = result;
                              });
                            }
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      );
    } else if (selectedTab == 1) {
      return OrderListScreen(vendors: vendors);
    } else if (selectedTab == 2) {
      return FeedbackListScreen(vendors: vendors);
    } else {
      return VendorListScreen(vendors: vendors);
    }
  }

  Widget dashboardCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white70),
            SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(title, style: TextStyle(color: Colors.white54)),
          ],
        ),
      ),
    );
  }
}
