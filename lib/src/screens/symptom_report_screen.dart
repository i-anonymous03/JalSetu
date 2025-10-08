import 'package:flutter/material.dart';

class SymptomReportScreen extends StatefulWidget {
  const SymptomReportScreen({super.key});

  @override
  _SymptomReportScreenState createState() => _SymptomReportScreenState();
}

class _SymptomReportScreenState extends State<SymptomReportScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _fever = false;
  bool _diarrhoea = false;
  bool _vomiting = false;
  bool _stomachPain = false;
  final _notesController = TextEditingController();
  bool _isLoading = false;

  void _submitReport() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // TODO: Save this data to Firestore
      // You would create a new document in a "symptom_reports" collection
      // Include the user's ID, timestamp, location, and the symptoms.
      print('Fever: $_fever');
      print('Diarrhoea: $_diarrhoea');
      print('Vomiting: $_vomiting');
      print('Stomach Pain: $_stomachPain');
      print('Notes: ${_notesController.text}');

      // Simulate network request
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Health report submitted successfully!'),
              backgroundColor: Colors.green),
        );
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Health Symptoms'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please select the symptoms you are experiencing:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text('Fever'),
                value: _fever,
                onChanged: (bool? value) {
                  setState(() {
                    _fever = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Diarrhoea'),
                value: _diarrhoea,
                onChanged: (bool? value) {
                  setState(() {
                    _diarrhoea = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Vomiting'),
                value: _vomiting,
                onChanged: (bool? value) {
                  setState(() {
                    _vomiting = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Stomach Pain / Cramps'),
                value: _stomachPain,
                onChanged: (bool? value) {
                  setState(() {
                    _stomachPain = value!;
                  });
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Additional Notes (Optional)',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 24),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: _submitReport,
                    child: const Text('Submit Report'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}