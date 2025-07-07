import 'package:flutter/material.dart';
import '../models/vendor.dart';

class AddFeedbackScreen extends StatefulWidget {
  final Vendor vendor;

  AddFeedbackScreen({required this.vendor});

  @override
  _AddFeedbackScreenState createState() => _AddFeedbackScreenState();
}

class _AddFeedbackScreenState extends State<AddFeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final feedbackController = TextEditingController();
  int rating = 0;

  void saveFeedback() {
    if (_formKey.currentState!.validate()) {
      widget.vendor.feedback = feedbackController.text;
      widget.vendor.rating = rating;
      Navigator.pop(context, true);
    }
  }

  Widget buildRatingStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
          onPressed: () {
            setState(() {
              rating = index + 1;
            });
          },
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        title: Text("Add Feedback"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildRatingStars(),
              TextFormField(
                controller: feedbackController,
                style: TextStyle(color: Colors.white),
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Feedback",
                  labelStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Color(0xFF2A2A2A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? "Required" : null,
              ),
              Center(child:SizedBox(height: 30,
              child:ElevatedButton.icon(
                onPressed: saveFeedback,
                icon: Icon(Icons.send, size: 18),
                label: Text("Submit", style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),),)
            ],
          ),
        ),
      ),
    );
  }
}
