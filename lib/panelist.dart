import 'package:flutter/material.dart';
import 'gender.dart';
import 'main.dart';
import 'package:provider/provider.dart';
import 'global_state.dart';

class PanelistPage extends StatefulWidget {
  @override
  _PanelistPageState createState() => _PanelistPageState();
}

class _PanelistPageState extends State<PanelistPage> {
  TextEditingController _controller = TextEditingController();
  String? _panelistId;

  @override
  Widget build(BuildContext context) {
    GlobalState globalState = Provider.of<GlobalState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panelist'),
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
                'Please enter your PANELIST ID number.',
                style: TextStyle(fontSize: 40, color: Colors.red),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Container(
                width: 300,
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Panelist ID',
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    globalState.panelistId = _controller.text;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GenderPage()), // Assuming you have created GenderPage class in gender.dart
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter your Panelist ID'),
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

