import 'package:flutter/material.dart';
import '../models/vendor.dart';

class FeedbackListScreen extends StatelessWidget {
  final List<Vendor> vendors;

  FeedbackListScreen({required this.vendors});

  @override
  Widget build(BuildContext context) {
    final feedbackVendors = vendors.where((v) => v.feedback.isNotEmpty).toList();

    return Scaffold(
      appBar: AppBar(title: Text("Feedbacks")),
      backgroundColor: Color(0xFF121212),
      body: feedbackVendors.isEmpty
          ? Center(child: Text("No feedbacks yet", style: TextStyle(color: Colors.white70)))
          : ListView.builder(
              itemCount: feedbackVendors.length,
              itemBuilder: (context, index) {
                final vendor = feedbackVendors[index];
                return Card(
                  color: Color(0xFF1E1E1E),
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(vendor.name, style: TextStyle(color: Colors.white)),
                    subtitle: Text(vendor.feedback, style: TextStyle(color: Colors.white70)),
                    trailing: Text("${vendor.rating}/5", style: TextStyle(color: Colors.amberAccent)),
                  ),
                );
              },
            ),
    );
  }
}
