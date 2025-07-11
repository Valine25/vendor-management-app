import 'package:flutter/material.dart';
import '../models/vendor.dart';
import '../database/db_helper.dart';

class AddFeedbackScreen extends StatefulWidget {
  final Vendor vendor;

  const AddFeedbackScreen({super.key, required this.vendor});

  @override
    _AddFeedbackScreenState createState() => _AddFeedbackScreenState();
}

class _AddFeedbackScreenState extends State<AddFeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final feedbackController = TextEditingController();
  int rating = 0;

  void saveFeedback() async {
    if (_formKey.currentState!.validate()) {
      widget.vendor.feedback = feedbackController.text;
      widget.vendor.rating = rating.toDouble();

      await DBHelper().updateVendor(widget.vendor);

      
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
  void initState() {
    super.initState();
    feedbackController.text = widget.vendor.feedback;
    rating = widget.vendor.rating.toInt();
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
              Center(
                child: SizedBox(
                  height: 38,
                  width: 140,
                  child: ElevatedButton.icon(
                    onPressed: saveFeedback,
                    icon: Icon(Icons.send, size: 18),
                    label: Text("Submit", style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 1,
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
