import 'package:flutter/material.dart';

class MenstrualFormScreen extends StatefulWidget {
  static const screenroute ='men-screen';
  @override
  _MenstrualFormScreenState createState() => _MenstrualFormScreenState();
}

class _MenstrualFormScreenState extends State<MenstrualFormScreen> {
  TextEditingController _cycleLengthController = TextEditingController();
  TextEditingController _stressLevelController = TextEditingController();
  TextEditingController _exerciseLevelController = TextEditingController();
  DateTime _lastPeriodDate = DateTime.now(); // Initialize to the current date.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menstrual Health Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                pickLastPeriodDate();
              },
              child: Text(_lastPeriodDate == null
                  ? 'Pick Last Period Date'
                  : 'Last Period Date: ${_lastPeriodDate.toLocal()}'),
            ),
            TextFormField(
              controller: _cycleLengthController,
              decoration: InputDecoration(labelText: 'Menstrual Cycle Length (in days)'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _stressLevelController,
              decoration: InputDecoration(labelText: 'Stress Level (1-10)'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _exerciseLevelController,
              decoration: InputDecoration(labelText: 'Exercise Level (hours per week)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                predictNextPeriod();
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void pickLastPeriodDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _lastPeriodDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _lastPeriodDate) {
      setState(() {
        _lastPeriodDate = pickedDate;
      });
    }
  }

  void predictNextPeriod() {
    if (_lastPeriodDate == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please select your last period date.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    int cycleLength = int.parse(_cycleLengthController.text);
    int stressLevel = int.parse(_stressLevelController.text);
    double exerciseLevel = double.parse(_exerciseLevelController.text);

    String prediction = calculateNextPeriod(cycleLength, stressLevel, exerciseLevel);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Next Period Prediction',style: TextStyle(fontSize: 30),),
          content: Text(prediction),
          actions: [
            Image.asset('images/logo1.png'),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),

          ],
        );
      },
    );
  }

  String calculateNextPeriod(int cycleLength, int stressLevel, double exerciseLevel) {
    // Simple prediction logic for demonstration purposes.
    int baseCycleLength = 28; // Average menstrual cycle length
    int adjustedCycleLength = (cycleLength + baseCycleLength) ~/ 2;

    // Adjust cycle length based on stress and exercise levels.
    adjustedCycleLength += (stressLevel - 5) ~/ 2;
    adjustedCycleLength -= (exerciseLevel - 3).toInt();

    // Calculate days since the last period.
    int daysSinceLastPeriod = DateTime.now().difference(_lastPeriodDate).inDays;

    // Calculate the remaining days until the next period.
    int daysUntilNextPeriod = adjustedCycleLength - daysSinceLastPeriod;

    return 'Your next period is predicted in $daysUntilNextPeriod days';
  }
}
