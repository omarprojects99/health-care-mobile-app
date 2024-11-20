import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class PeriodCal extends StatefulWidget {
  const PeriodCal({super.key});

  @override
  State<PeriodCal> createState() => _PeriodCalState();
}

class _PeriodCalState extends State<PeriodCal> {
   DateTime _lastPeriodDate = DateTime.now(); // Initialize with the current date
  TextEditingController _stressController = TextEditingController();
  TextEditingController _activityController = TextEditingController();
  String _result = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _lastPeriodDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _lastPeriodDate) {
      setState(() {
        _lastPeriodDate = picked;
      });
    }
  }

  void _calculatePeriod() {
    int cycleLength = 28; // Default cycle length
    int stressFactor = int.tryParse(_stressController.text) ?? 0;
    int activityFactor = int.tryParse(_activityController.text) ?? 0;

    // Adjust cycle length based on factors like stress and activity
    cycleLength += stressFactor + activityFactor;

    DateTime nextPeriod = _lastPeriodDate.add(Duration(days: cycleLength));

    setState(() {
      _result = 'Next period: ${DateFormat('yyyy-MM-dd').format(nextPeriod)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Period Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text(
                'Last Period Date: ${DateFormat('yyyy-MM-dd').format(_lastPeriodDate)}',
              ),
            ),
            TextField(
              controller: _stressController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter stress level (optional)',
              ),
            ),
            TextField(
              controller: _activityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter activity level (optional)',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculatePeriod,
              child: Text('Calculate'),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}