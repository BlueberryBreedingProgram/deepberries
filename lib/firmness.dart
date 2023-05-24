import 'dart:async';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:html' as html;
import 'package:provider/provider.dart';
import 'global_state.dart';
import 'firmness.dart';
import 'juiciness.dart';

class FirmnessPage extends StatefulWidget {
  @override
  _FirmnessPageState createState() => _FirmnessPageState();
}

class _FirmnessPageState extends State<FirmnessPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  double? firmnessRating;
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
          "firmness_${globalState.panelistId}_${globalState.selectedSample}_${Uuid().v4()}.jpg";
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

  @override
  Widget build(BuildContext context) {
    // Access the global state
    final globalState = Provider.of<GlobalState>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Firmness'),
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
                    text: 'Please rate the ',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                  TextSpan(
                    text: 'FIRMNESS',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ' of sample ${globalState.selectedSample}.',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Low firmness", style: TextStyle(fontSize: 20)),
                SizedBox(width: 20),
                Expanded(
                  child: Slider(
                    value: firmnessRating ?? 0,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    onChanged: (double value) {
                      setState(() {
                        firmnessRating = value;
                      });
                    },
                    onChangeEnd: (double value) {
                      // Capture image when the user stops dragging the slider
                      captureImage();
                    },
                  ),
                ),

                SizedBox(width: 20),
                Text("High firmness", style: TextStyle(fontSize: 20)),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Selected firmness: ${firmnessRating?.toStringAsFixed(0) ?? 'Not Selected'}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                if (firmnessRating != null) {
                  await uploadImages();
                  globalState.firmness =
                      firmnessRating; // Save firmnessRating to global state
                  // Navigate to the next page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JuicinessPage()),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Error"),
                        content: Text(
                            "Please select a firmness rating before continuing."),
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
