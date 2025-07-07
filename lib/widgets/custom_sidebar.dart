
import 'package:flutter/material.dart';

class CustomSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF4B0082), // Indigo Purple
            Color(0xFF8A2BE2), // Blue Violet
          ],
        ),
        boxShadow: [
          BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.storefront, size: 30, color: Colors.deepPurpleAccent),
                ),
                SizedBox(height: 10),
                Text(
                  'TradeNest',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Vendor Admin',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          sidebarItem(Icons.dashboard, "Dashboard"),
          sidebarItem(Icons.shopping_cart, "Orders"),
          sidebarItem(Icons.people, "Vendors"),
          sidebarItem(Icons.feedback, "Feedback"),
          

          Spacer(),

          Divider(color: Colors.white24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.logout, color: Colors.white70),
              label: Text("Logout", style: TextStyle(color: Colors.white70)),
            ),
          )
        ],
      ),
    );
  }

  Widget sidebarItem(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(
        label,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      onTap: () {
        // You can add functionality here later
      },
    );
  }
}
