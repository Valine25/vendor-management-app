import 'package:flutter/material.dart';

class CustomSidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  CustomSidebar({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: Color(0xFF1E1E1E),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(Icons.business, color: Colors.deepPurpleAccent, size: 28),
                SizedBox(width: 10),
                Text(
                  "TradeNest",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          buildSidebarItem(0, Icons.dashboard, "Dashboard"),
          buildSidebarItem(1, Icons.shopping_cart, "Orders"),
          buildSidebarItem(2, Icons.feedback, "Feedbacks"),
          buildSidebarItem(3, Icons.store, "Vendors"),
        ],
      ),
    );
  }

  Widget buildSidebarItem(int index, IconData icon, String label) {
    final isSelected = index == selectedIndex;
    return InkWell(
      onTap: () => onTap(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        color: isSelected ? Colors.deepPurpleAccent.withOpacity(0.2) : Colors.transparent,
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.deepPurpleAccent : Colors.white70,
              size: 22,
            ),
            SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.deepPurpleAccent : Colors.white70,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
