import 'package:flutter/material.dart';
import '../models/vendor.dart';
import '../models/order.dart';
import '../database/db_helper.dart';

class AddOrderScreen extends StatefulWidget {
  final Vendor vendor;

  AddOrderScreen({required this.vendor});

  @override
  _AddOrderScreenState createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final productController = TextEditingController();
  final quantityController = TextEditingController();
  String selectedStatus = 'Pending';
  DateTime selectedDate = DateTime.now();

  Future<void> pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) =>
          Theme(data: ThemeData.dark(), child: child!),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void>  saveOrder() async {
  if (_formKey.currentState!.validate()) {
    final newOrder = Order(
      vendorId: widget.vendor.id!,
      product: productController.text,
      quantity: int.parse(quantityController.text),
      date: selectedDate,
      status: selectedStatus,
    );

    await DBHelper().insertOrder(newOrder, widget.vendor.id!);

   
    Navigator.pop(context, true);
  }
}

  Widget buildTextField(
    String label,
    TextEditingController controller, {
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
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

  Widget buildDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: selectedStatus,
        dropdownColor: Color(0xFF2A2A2A),
        items: ['Pending', 'Delivered', 'Cancelled'].map((status) {
          return DropdownMenuItem(
            value: status,
            child: Text(status, style: TextStyle(color: Colors.white)),
          );
        }).toList(),
        onChanged: (value) => setState(() => selectedStatus = value!),
        decoration: InputDecoration(
          labelText: "Order Status",
          labelStyle: TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Color(0xFF2A2A2A),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget buildDatePicker() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Date: ${selectedDate.toLocal().toString().split(' ')[0]}",
            style: TextStyle(color: Colors.white),
          ),
          TextButton(
            onPressed: () => pickDate(context),
            child: Text("Select Date"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        title: Text("Add Order"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildTextField("Product", productController),
              buildTextField("Quantity", quantityController, isNumber: true),
              buildDatePicker(),
              buildDropdown(),
              Center(
                child: SizedBox(
                  height: 40,
                  width: 130,
                  child: ElevatedButton.icon(
                    onPressed: saveOrder,
                    icon: Icon(Icons.check, size: 18),
                    label: Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
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
