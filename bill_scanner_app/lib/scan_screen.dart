import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'dart:io';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  XFile? _image; // Stores captured image
  String _scannedText = "Scanned text will appear here.";

  final ImagePicker _picker = ImagePicker();
  final textRecognizer = TextRecognizer(); // Google ML Kit OCR

  // Function to capture image from camera
  Future<void> _captureImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = image;
      });
      _scanText(File(image.path));
    }
  }

  // Function to extract text using OCR
  Future<void> _scanText(File imageFile) async {
    final InputImage inputImage = InputImage.fromFile(imageFile);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    setState(() {
      _scannedText = recognizedText.text;
    });
  }

  @override
  void dispose() {
    textRecognizer.close(); // Cleanup when screen is closed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bill Scanner")),
      body: Column(
        children: [
          SizedBox(height: 20),
          _image != null
              ? Image.file(File(_image!.path), height: 200)
              : Container(),
          SizedBox(height: 20),
          Text(_scannedText, textAlign: TextAlign.center),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _captureImage,
            child: Text("Capture Bill"),
          ),
        ],
      ),
    );
  }
}
