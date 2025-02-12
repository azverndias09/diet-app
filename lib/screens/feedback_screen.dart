import 'package:flutter/material.dart';
import 'package:nutrition_tracker/services/firestore_service.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _feedbackController,
              decoration: InputDecoration(labelText: 'Your Feedback'),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String feedback = _feedbackController.text;
                await FirestoreService().saveFeedback(feedback);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Feedback submitted successfully!')));
              },
              child: Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}
