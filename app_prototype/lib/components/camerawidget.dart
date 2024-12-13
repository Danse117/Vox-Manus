import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../theme/app_theme.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';

/// Widget that handles camera preview and image selection functionality
class CameraWidget extends StatefulWidget {
  final CameraController cameraController;
  final bool isCameraInitialized;

  const CameraWidget({
    required this.cameraController,
    required this.isCameraInitialized,
  });

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  bool _isStreamMode = true;
  File? _selectedImage;
  late final ImagePicker _picker;
  late final ImageLabeler _imageLabeler;
  List<ImageLabel> _labels = [];
  final String modelPath = 'assets/ml/First_Train_20_float32.tflite';
  
  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
    _imageLabeler = ImageLabeler(
      options: ImageLabelerOptions(confidenceThreshold: 0.50),
    );
  }

  @override
  void dispose() {
    _imageLabeler.close();
    super.dispose();
  }

  /// Process image and get labels
  Future<void> _processImage(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    try {
      _labels = await _imageLabeler.processImage(inputImage);
      setState(() {}); // Trigger rebuild to show labels
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to process image: $e')),
      );
    }
  }

  /// Opens gallery and allows user to select an image
  Future<void> chooseImage() async {
    try {
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _selectedImage = File(pickedImage.path);
          _labels = []; // Clear previous labels
        });
        await _processImage(pickedImage.path);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to pick image')),
      );
    }
  }

  /// Captures an image using the camera
  Future<void> captureImage() async {
    try {
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        setState(() {
          _selectedImage = File(pickedImage.path);
          _labels = []; // Clear previous labels
        });
        await _processImage(pickedImage.path);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to capture image')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show placeholder if camera is not initialized
    if (!widget.isCameraInitialized) {
      return Container(
        height: 400,
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [AppTheme.colors.primaryLight, Colors.black26],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: Icon(Icons.photo_camera_back,
            color: AppTheme.colors.primaryLight, size: 40),
      );
    }

    // Main camera widget layout
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 500,
        maxWidth: 400,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Camera preview or selected image container
          Container(
            height: 400,
            width: 400,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Show either selected image or live camera preview
                  _selectedImage != null
                      ? Image.file(_selectedImage!, fit: BoxFit.cover)
                      : CameraPreview(widget.cameraController),

                  // Mode indicator overlay
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.black54,
                    child: Text(
                      _isStreamMode ? 'Stream Mode' : 'Capture Mode',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),

                  if (_selectedImage != null && _labels.isNotEmpty)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.black54,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _labels
                              .map((label) => Text(
                                    '${label.label}: ${(label.confidence * 100).toStringAsFixed(1)}%',
                                    style: const TextStyle(color: Colors.white),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Control buttons row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Mode toggle button
              ElevatedButton.icon(
                onPressed: _toggleCameraMode,
                icon: Icon(_isStreamMode ? Icons.camera_alt : Icons.videocam),
                label: Text(
                    _isStreamMode ? 'Switch to Capture' : 'Switch to Stream'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isStreamMode ? Colors.blue : Colors.green,
                ),
              ),
              // Image selection button (only visible in capture mode)
              if (!_isStreamMode)
                ElevatedButton(
                  onPressed: chooseImage,
                  child: const Text('Choose Image'),
                  onLongPress: () {
                    captureImage();
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  /// Toggles between stream and capture modes
  /// Resets selected image when switching to stream mode
  void _toggleCameraMode() {
    setState(() {
      _isStreamMode = !_isStreamMode;
      // Clear selected image when switching to stream mode
      if (_isStreamMode) {
        _selectedImage = null;
      }
    });
  }
}
