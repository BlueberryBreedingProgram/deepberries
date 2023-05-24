import 'dart:async';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:html' as html;
import 'panelist.dart';
import 'sample.dart';
import 'dart:typed_data';
import 'package:provider/provider.dart'; // Add this import
import 'global_state.dart'; // Add this import
import 'overall.dart'; // Add this import

class AppearancePage extends StatefulWidget {
  @override
  _AppearancePageState createState() => _AppearancePageState();
}

class _AppearancePageState extends State<AppearancePage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  int? appearanceRating;
  List<String> capturedImageUrls = [];

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(firstCamera, ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();

    setState(() {});
  }

  Future<void> captureImage() async {
    try {
      await _initializeControllerFuture;

      final image = await _controller.takePicture();

      html.Blob blob =
          html.Blob([Uint8List.fromList(await image.readAsBytes())]);
      final imageUrl = html.Url.createObjectUrlFromBlob(blob);

      setState(() {
        capturedImageUrls.add(imageUrl);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> uploadImages() async {
    final globalState = Provider.of<GlobalState>(context, listen: false);

    for (String imageUrl in capturedImageUrls) {
      String fileName =
          "appearance_${globalState.panelistId}_${globalState.selectedSample}_${Uuid().v4()}.jpg";
      final storageRef = FirebaseStorage.instance.ref().child(fileName);

      try {
        final data = await html.HttpRequest.request(imageUrl,
            responseType: "arraybuffer");
        final bytes = data.response as ByteBuffer;
        final metadata = SettableMetadata(contentType: 'image/jpeg');
        await storageRef.putData(bytes.asUint8List(), metadata);
      } catch (e) {
        print(e);
      }
    }
  }

  List<bool> isSelected = List.generate(9, (_) => false);

  @override
  Widget build(BuildContext context) {
    // Access the global state
    final globalState = Provider.of<GlobalState>(context, listen: false);

    List<String> labels = [
      "(1) - Dislike Extremely",
      "(2) - Dislike Very Much",
      "(3) - Dislike Moderately",
      "(4) - Dislike Slightly",
      "(5) - Neither Like nor Dislike",
      "(6) - Like Slightly",
      "(7) - Like Moderately",
      "(8) - Like Very Much",
      "(9) - Like Extremely"
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appearance'),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'How much do you LIKE or DISLIKE the ',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                  TextSpan(
                    text: 'OVERALL APPEARANCE',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ' of sample ${globalState.selectedSample}?',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Column(
              children: List<Widget>.generate(9, (index) {
                return ListTile(
                  title: Text(labels[index], style: TextStyle(fontSize: 20)),
                  leading: Radio(
                    value: index + 1,
                    groupValue: appearanceRating,
                    onChanged: (int? value) {
                      setState(() {
                        appearanceRating = value;
                        captureImage();
                      });
                    },
                  ),
                );
              }),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                if (appearanceRating != null) {
                  await uploadImages();
                  globalState.appearance =
                      appearanceRating; // Save appearanceRating to global state
                  // Navigate to the next page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OverallPage()),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Error"),
                        content: Text(
                            "Please select an appearance rating before continuing."),
                        actions: [
                          TextButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
