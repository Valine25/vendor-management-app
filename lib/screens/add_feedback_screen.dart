import 'package:flutter/material.dart';
import '../models/vendor.dart';

class AddFeedbackScreen extends StatefulWidget {
  final Vendor vendor;

  AddFeedbackScreen({required this.vendor});

  @override
  State<AddFeedbackScreen> createState() => _AddFeedbackScreenState();
}

class _AddFeedbackScreenState extends State<AddFeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final feedbackController = TextEditingController();
  int selectedRating = 5;

  void saveFeedback() {
    if (_formKey.currentState!.validate()) {
      widget.vendor.feedback = feedbackController.text;
      widget.vendor.rating = selectedRating;
      Navigator.pop(context, true); // return success
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Feedback")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: feedbackController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Feedback",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? "Required" : null,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: selectedRating,
                items: List.generate(5, (index) {
                  final val = index + 1;
                  return DropdownMenuItem(
                    value: val,
                    child: Text("$val Star${val > 1 ? 's' : ''}"),
                  );
                }),
                onChanged: (value) => setState(() {
                  selectedRating = value!;
                }),
                decoration: InputDecoration(
                  labelText: "Rating",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: saveFeedback,
                icon: Icon(Icons.check),
                label: Text("Save Feedback"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
