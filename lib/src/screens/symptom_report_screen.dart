import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SymptomReportScreen extends StatefulWidget {
  const SymptomReportScreen({super.key});

  @override
  State<SymptomReportScreen> createState() => _SymptomReportScreenState();
}

class _SymptomReportScreenState extends State<SymptomReportScreen> {
  final _formKey = GlobalKey<FormState>();
  final Set<String> _selectedSymptoms = {};
  String? _otherSymptoms;
  DateTime? _startDate;
  String? _severity;

  Future<void> _submitReport() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // TODO: Save this data to Firestore

      // FIX: Replaced print with debugPrint.
      debugPrint('Selected Symptoms: $_selectedSymptoms');
      debugPrint('Other Symptoms: $_otherSymptoms');
      debugPrint('Start Date: $_startDate');
      debugPrint('Severity: $_severity');

      // Show a confirmation dialog
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Report Submitted'),
          content: const Text('Thank you for your report. Your data has been recorded.'),
          actions: [
            TextButton(
              onPressed: () {
                // FIX: Added mounted check for async gap.
                if (!mounted) return;
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      // FIX: Added mounted check for async gap.
      if (!mounted) return;
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Symptoms'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Symptoms:', style: Theme.of(context).textTheme.titleLarge),
              ...['Fever', 'Cough', 'Diarrhea', 'Vomiting'].map((symptom) {
                return CheckboxListTile(
                  title: Text(symptom),
                  value: _selectedSymptoms.contains(symptom),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _selectedSymptoms.add(symptom);
                      } else {
                        _selectedSymptoms.remove(symptom);
                      }
                    });
                  },
                );
              }),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Other Symptoms'),
                onSaved: (value) => _otherSymptoms = value,
              ),
              const SizedBox(height: 20),
              ListTile(
                title: Text('Symptom Start Date: ${_startDate?.toLocal().toString().split(' ')[0] ?? 'Not set'}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() {
                      _startDate = date;
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Severity'),
                items: ['Mild', 'Moderate', 'Severe'].map((label) => DropdownMenuItem(
                  value: label,
                  child: Text(label),
                )).toList(),
                onChanged: (value) {
                  setState(() {
                    _severity = value;
                  });
                },
                validator: (value) => value == null ? 'Please select severity' : null,
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
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
