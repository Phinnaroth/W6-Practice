import 'package:flutter/material.dart';
import '../models/course.dart';

const Color mainColor = Colors.blue;

class CourseScoreForm extends StatefulWidget {
  const CourseScoreForm({super.key});

  @override
  State<CourseScoreForm> createState() {
    return _CourseScoreFormState();
  }
}

class _CourseScoreFormState extends State<CourseScoreForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _scoreController = TextEditingController(); 

  @override
  void dispose() {
    _nameController.dispose();
    _scoreController.dispose();
    super.dispose();
  }

  void _saveItem() {
    if (!_formKey.currentState!.validate()) return;

    String enteredName = _nameController.text.trim();
    double? enteredScore = double.tryParse(_scoreController.text);

    if (enteredScore == null) return;

    Navigator.of(context).pop(
      CourseScore(studentName: enteredName, studentScore: enteredScore),
    );
  }





  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty || value.trim().length > 50) {
      return 'Must be between 1 and 50 characters.';
    }
    return null;
  }

  String? validateScore(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) return 'Score is required.';

    final score = double.tryParse(value);
    if (score == null || score < 0 || score > 100) {
      return 'Must be a score between 0 and 100';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text("Add Score", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                maxLength: 50,
                decoration: const InputDecoration(label: Text('Name')),
                validator: validateName,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _scoreController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(label: Text('Score')),
                validator: validateScore,
              ),
              const Expanded(child: SizedBox(height: 12)),
              ElevatedButton(
                onPressed: _saveItem,
                child: const Text("Add score"),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
