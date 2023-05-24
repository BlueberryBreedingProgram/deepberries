import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'global_state.dart';
import 'texture.dart';

class TextPage extends StatefulWidget {
  @override
  _TextPageState createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  TextEditingController posFeedbackController = TextEditingController();
  TextEditingController negFeedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context, listen: false);

    double textFieldWidth = MediaQuery.of(context).size.width * 0.6;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Text'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'ID: ${globalState.panelistId} | Sample: ${globalState.selectedSample}',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.blue[50],
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'What, if anything, do you ',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                    TextSpan(
                      text: 'LIKE',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ' about sample ${globalState.selectedSample}?',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: textFieldWidth,
                child: TextField(
                  controller: posFeedbackController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Type here...",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 30),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'What, if anything, do you ',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                    TextSpan(
                      text: 'DISLIKE',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ' about sample ${globalState.selectedSample}?',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: textFieldWidth,
                child: TextField(
                  controller: negFeedbackController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Type here...",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  globalState.posFeedback = posFeedbackController.text;
                  globalState.negFeedback = negFeedbackController.text;

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TexturePage()),
                  );
                },
                child: Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
