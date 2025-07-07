import 'package:flutter/material.dart';
import '../models/vendor.dart';

class AddVendorScreen extends StatefulWidget {
  @override
  _AddVendorScreenState createState() => _AddVendorScreenState();
}

class _AddVendorScreenState extends State<AddVendorScreen> {
  final nameController = TextEditingController();
  final companyController = TextEditingController();
  final contactController = TextEditingController();
  final productController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void saveVendor() {
    if (_formKey.currentState!.validate()) {
      final vendor = Vendor(
        name: nameController.text,
        company: companyController.text,
        contact: contactController.text,
        products: productController.text
            .split(',')
            .map((e) => e.trim())
            .toList(),
      );
      Navigator.pop(context, vendor);
    }
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Color(0xFF2A2A2A),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? "Required" : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(title: Text("Add Vendor"), backgroundColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildTextField("Vendor Name", nameController),
              buildTextField("Company", companyController),
              buildTextField("Contact Info", contactController),
              buildTextField("Products (comma separated)", productController),
              Center(
                
                child: SizedBox(
                  height: 38,
                  width: 120,
                  child: ElevatedButton.icon(
                    onPressed: saveVendor,
                    icon: Icon(Icons.check, size: 16),
                    label: Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 1,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
