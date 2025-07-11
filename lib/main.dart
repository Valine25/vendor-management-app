import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import './screens/dashboard_screen.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vendor Management',
      theme: ThemeData.dark(), 
      home: DashboardScreen(), 
      debugShowCheckedModeBanner: false,
    );
  }
}
