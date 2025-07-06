import 'package:flutter/material.dart';
import '../models/vendor.dart';

class AddOrderScreen extends StatefulWidget {
  final Vendor vendor;

  AddOrderScreen({required this.vendor});

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final productController = TextEditingController();
  final quantityController = TextEditingController();
  String selectedStatus = 'Pending';
  DateTime selectedDate = DateTime.now();

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void saveOrder() {
    if (_formKey.currentState!.validate()) {
      final newOrder = Order(
        product: productController.text,
        quantity: int.parse(quantityController.text),
        date: selectedDate,
        status: selectedStatus,
      );

      widget.vendor.orders.add(newOrder);
      Navigator.pop(context, true); // return success
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Order")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildTextField("Product Name", productController),
              buildTextField("Quantity", quantityController,
                  isNumber: true),
              buildDatePicker(context),
              buildDropdown(),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: saveOrder,
                icon: Icon(Icons.check),
                label: Text("Save Order"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration:
            InputDecoration(labelText: label, border: OutlineInputBorder()),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        validator: (value) =>
            (value == null || value.isEmpty) ? "Required" : null,
      ),
    );
  }

  Widget buildDatePicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Date: ${selectedDate.toLocal().toString().split(' ')[0]}",
            ),
          ),
          TextButton(
            onPressed: () => pickDate(context),
            child: Text("Select Date"),
          )
        ],
      ),
    );
  }

  Widget buildDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: selectedStatus,
        items: ['Pending', 'Delivered', 'Cancelled']
            .map((status) => DropdownMenuItem(
                  child: Text(status),
                  value: status,
                ))
            .toList(),
        onChanged: (value) => setState(() {
          selectedStatus = value!;
        }),
        decoration: InputDecoration(
          labelText: "Status",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
