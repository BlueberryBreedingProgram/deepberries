import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sample.dart';
import 'camera.dart';
import 'global_state.dart';

class RacePage extends StatefulWidget {
  @override
  _RacePageState createState() => _RacePageState();
}

class _RacePageState extends State<RacePage> {
  String? _ethnicity;
  String? _race;
  String? _blueberryConsumption;

  void onNextPressed() {
    GlobalState globalState = Provider.of<GlobalState>(context, listen: false);

    if (_ethnicity == null || _race == null || _blueberryConsumption == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please answer all questions')),
      );
    } else {
      globalState.ethnicity = _ethnicity;
      globalState.race = _race;
      globalState.blueberryConsumption = _blueberryConsumption;

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CameraPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Race and Ethnicity'),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
        backgroundColor: Colors.blue[50],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What is your ethnic background?',
              style: TextStyle(fontSize: 20),
            ),
            RadioListTile<String>(
              title: const Text('Hispanic'),
              value: 'Hispanic',
              groupValue: _ethnicity,
              onChanged: (String? value) {
                setState(() {
                  _ethnicity = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Non-Hispanic'),
              value: 'Non-Hispanic',
              groupValue: _ethnicity,
              onChanged: (String? value) {
                setState(() {
                  _ethnicity = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Text(
              'Which of the following best describes you?',
              style: TextStyle(fontSize: 20),
            ),
            RadioListTile<String>(
              title: const Text('Asian/Pacific Islander'),
              value: 'Asian/Pacific Islander',
              groupValue: _race,
              onChanged: (String? value) {
                setState(() {
                  _race = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Black or African American'),
              value: 'Black or African American',
              groupValue: _race,
              onChanged: (String? value) {
                setState(() {
                  _race = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('White or Caucasian'),
              value: 'White or Caucasian',
              groupValue: _race,
              onChanged: (String? value) {
                setState(() {
                  _race = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Native American, Alaska Native, Aleutian'),
              value: 'Native American, Alaska Native, Aleutian',
              groupValue: _race,
              onChanged: (String? value) {
                setState(() {
                  _race = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Other'),
              value: 'Other',
              groupValue: _race,
              onChanged: (String? value) {
                setState(() {
                  _race = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Text(
              'How often do you eat fresh blueberries?',
              style: TextStyle(fontSize: 20),
            ),
            RadioListTile<String>(
              title: const Text('Once a day'),
              value: 'Once a day',
              groupValue: _blueberryConsumption,
              onChanged: (String? value) {
                setState(() {
                  _blueberryConsumption = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('2-3 times a week'),
              value: '2-3 times a week',
              groupValue: _blueberryConsumption,
              onChanged: (String? value) {
                setState(() {
                  _blueberryConsumption = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Once per week'),
              value: 'Once per week',
              groupValue: _blueberryConsumption,
              onChanged: (String? value) {
                setState(() {
                  _blueberryConsumption = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('2-3 times a month'),
              value: '2-3 times a month',
              groupValue: _blueberryConsumption,
              onChanged: (String? value) {
                setState(() {
                  _blueberryConsumption = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Once per month'),
              value: 'Once per month',
              groupValue: _blueberryConsumption,
              onChanged: (String? value) {
                setState(() {
                  _blueberryConsumption = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Twice per year'),
              value: 'Twice per year',
              groupValue: _blueberryConsumption,
              onChanged: (String? value) {
                setState(() {
                  _blueberryConsumption = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Once per year'),
              value: 'Once per year',
              groupValue: _blueberryConsumption,
              onChanged: (String? value) {
                setState(() {
                  _blueberryConsumption = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Never'),
              value: 'Never',
              groupValue: _blueberryConsumption,
              onChanged: (String? value) {
                setState(() {
                  _blueberryConsumption = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: onNextPressed,
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
