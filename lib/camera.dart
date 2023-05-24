import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'sample.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(firstCamera, ResolutionPreset.high);
    _initializeControllerFuture = _controller?.initialize();

    setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      backgroundColor: Colors.blue[50],
      body: Center(
        child: SingleChildScrollView( // Add SingleChildScrollView
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Please make sure your face is centered in the camera view, if not, \nplease adjust your seating position or the monitor.',
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 20),
              Container(
                width: 800,
                height: 600,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  border: Border.all(color: Colors.blue, width: 5),
                ),
                child: _initializeControllerFuture == null
                    ? CircularProgressIndicator()
                    : FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ClipRect(
                        child: OverflowBox(
                          alignment: Alignment.center,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: SizedBox(
                              width: 400,
                              height: 300,
                              child: _controller == null
                                  ? CircularProgressIndicator()
                                  : AspectRatio(
                                aspectRatio: _controller?.value.aspectRatio ?? 1,
                                child: CameraPreview(_controller!),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SamplePage()));
                },
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

