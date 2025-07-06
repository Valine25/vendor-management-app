import 'package:flutter/material.dart';
import '../models/vendor.dart';

class AddVendorScreen extends StatefulWidget {
  @override
  State<AddVendorScreen> createState() => _AddVendorScreenState();
}

class _AddVendorScreenState extends State<AddVendorScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final companyController = TextEditingController();
  final contactController = TextEditingController();
  final productController = TextEditingController(); // Comma-separated

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Vendor")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildTextField("Name", nameController),
              buildTextField("Company", companyController),
              buildTextField("Contact", contactController),
              buildTextField("Products (comma-separated)", productController),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Vendor vendor = Vendor(
                      name: nameController.text,
                      company: companyController.text,
                      contact: contactController.text,
                      products: productController.text
                          .split(',')
                          .map((p) => p.trim())
                          .toList(),
                    );
                    Navigator.pop(context, vendor);
                  }
                },
                child: Text("Add Vendor"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
        validator: (value) => value == null || value.isEmpty ? "Required" : null,
      ),
    );
  }
}
