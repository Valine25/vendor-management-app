import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(VendorApp());
}

class VendorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vendor Portal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: HomeScreen(),
    );
  }
}
