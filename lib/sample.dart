import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Add this import
import 'global_state.dart'; // Add this import
import 'appearance.dart';

class SamplePage extends StatefulWidget {
  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  String? selectedSample;

  @override
  Widget build(BuildContext context) {
    // Access the global state
    final globalState = Provider.of<GlobalState>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample'),
      ),
      backgroundColor: Colors.blue[50],
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Choose the number matching the sample you\'re currently rating:',
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 20),
                  ...[
                    "461",
                    "537",
                    "285",
                    "899",
                    "724",
                    "594",
                    "378",
                    "850",
                    "125",
                    "741",
                  ].map((sampleNumber) {
                    return ListTile(
                      title: Text(sampleNumber,
                          style: TextStyle(fontSize: 20)),
                      leading: Radio(
                        value: sampleNumber,
                        groupValue: selectedSample,
                        onChanged: (String? value) {
                          setState(() {
                            selectedSample = value;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('cup.png'),
                  const Text(
                    'Please make sure the number you\'re selecting matches the number on the sample you\'ve been given',
                    style: TextStyle(fontSize: 12, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Next, you will evaluate this product based on its APPEARANCE. Please do not taste the product until you are prompted to do so.',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: selectedSample != null
                        ? () {
                      // Store the selected sample in the global state
                      globalState.selectedSample = selectedSample;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AppearancePage()));
                    }
                        : null,
                    child: const Text('Continue'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
