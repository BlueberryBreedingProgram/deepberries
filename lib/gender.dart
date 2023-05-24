import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'race.dart';
import 'global_state.dart';

class GenderPage extends StatefulWidget {
  @override
  _GenderPageState createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  String? _selectedGender;
  TextEditingController _ageController = TextEditingController();
  String? _age;

  @override
  Widget build(BuildContext context) {
    GlobalState globalState = Provider.of<GlobalState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gender and Age'),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.blue[50],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Please indicate your gender.',
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              DropdownButton<String>(
                value: _selectedGender,
                items: [
                  DropdownMenuItem(value: 'Male', child: Text('Male')),
                  DropdownMenuItem(value: 'Female', child: Text('Female')),
                  DropdownMenuItem(value: 'I prefer not to answer', child: Text('I prefer not to answer')),
                ],
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGender = newValue;
                  });
                },
                hint: Text('Select Gender'),
              ),
              SizedBox(height: 30),
              Text(
                'Please indicate your age.',
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Container(
                width: 300,
                child: TextField(
                  controller: _ageController,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_selectedGender != null && _ageController.text.isNotEmpty) {
                    globalState.selectedGender = _selectedGender;
                    globalState.age = _ageController.text;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RacePage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill in both gender and age fields'),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
