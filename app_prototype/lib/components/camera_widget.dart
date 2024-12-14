import 'package:app_prototype/components/camera_placeholder.dart';
import 'package:app_prototype/components/show_labels.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
// import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
// import 'package:flutter/services.dart';

/// Widget that handles camera preview and image selection functionality
class CameraWidget extends StatefulWidget {
  final CameraController cameraController;
  final bool isCameraInitialized;

  const CameraWidget({
    super.key,
    required this.cameraController,
    required this.isCameraInitialized,
  });

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  File? _selectedImage;
  late final ImagePicker _picker;
  late final ImageLabeler _imageLabeler;
  List<ImageLabel> _labels = [];
  // List<DetectedObject> _objects = [];
  final String modelPath = '/assets/ml/';
  /*
  late final ObjectDetector _objectDetector;
  final _objectDetectorOptions = ObjectDetectorOptions(
    mode: DetectionMode.stream,
    classifyObjects: true,
    multipleObjects: true,
  );

  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };
  */
  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
    _imageLabeler = ImageLabeler(
      options: ImageLabelerOptions(confidenceThreshold: 0.5),
    );
    // _objectDetector = ObjectDetector(options: _objectDetectorOptions);

    // Start the image stream when camera is initialized=
    // if (widget.isCameraInitialized) {
    // startImageStream();
    // }
  }

  @override
  void dispose() {
    _imageLabeler.close();
    // _objectDetector.close();
    // if (widget.isCameraInitialized) {
    //   widget.cameraController.stopImageStream();
    // }
    super.dispose();
  }

  /*
  InputImage? _inputImageFromCameraImage(CameraImage image,
      CameraController controller, List<CameraDescription> cameras) {
    // get image rotation
    final camera = cameras[0];
    final sensorOrientation = camera.sensorOrientation;

    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation =
          _orientations[controller.value.deviceOrientation];

      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        // front-facing
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        // back-facing
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
    }
    if (rotation == null) {
      return null;
    }

    // get image format
    final format = InputImageFormatValue.fromRawValue(image.format.raw);

    // validate format depending on platform
    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) {
      return null;
    }

    // since format is constraint to nv21 or bgra8888, both only have one plane
    if (image.planes.length != 1) {
      return null;
    }
    final plane = image.planes.first;

    // compose InputImage using bytes
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: format,
        bytesPerRow: plane.bytesPerRow,
      ),
    );
  }
 
  void startImageStream() {
    widget.cameraController.startImageStream((CameraImage image) {
      processStream(image);
    });
  }
Future<void> processStream(CameraImage cameraImage) async {
    print("Processing stream...");

    final inputImage = _inputImageFromCameraImage(
        cameraImage, widget.cameraController, cameras);

    if (inputImage == null) {
      return;
    }

    try {
      final List<DetectedObject> objects =
          await _objectDetector.processImage(inputImage);

      setState(() {
        _objects = objects;
      });

      // Debug output
      for (DetectedObject detectedObject in objects) {
        for (Label label in detectedObject.labels) {
          print(
              'Detected: ${label.text} (${label.confidence.toStringAsFixed(2)})');
        }
      }
    } catch (e) {
    }
  }
 */

  /*
  Image Labeling:
    _processImage()
      - Process image and get labels
      - Calls _imageLabeler.processImage()
    _chooseImage()
      - Opens gallery and allows user to select an image
      - Calls _processImage()
    _captureImage()
      - Captures an image using the camera
      - Calls _processImage()
  */ 
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
  Future<void> _chooseImage() async {

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

  Future<void> _captureImage() async {
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
      return const CameraPlaceholder();
    }

    // Main camera widget layout
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Camera preview or selected image container
        SizedBox(
          height: 600,
          width: 600,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Show either selected image or live camera preview
                _selectedImage != null
                    ? Stack(
                        children: [
                          Image.file(_selectedImage!,
                              fit: BoxFit.fill, height: 600, width: 600),
                          ShowLabels(
                            labels: _labels,
                            top: 0,
                            left: 0,
                            right: 0,
                          ),
                          // Refresh chooseImage button
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: ElevatedButton(
                              onPressed: () {
                                _selectedImage = null;
                                setState(() {});
                              },
                              child: const Icon(Icons.refresh),
                            ),
                          ),
                        ],
                      )
                    : CameraPreview(
                        widget.cameraController,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // Draw bounding boxes for detected objects
                            // if (_objects.isNotEmpty)
                            //   CustomPaint(
                            //     painter: ObjectDetectorPainter(_objects),
                            //   ),
                            // Your existing UI elements
                            Column(
                              verticalDirection: VerticalDirection.up,
                              children: [
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: _chooseImage,
                                      child: const Text('Choose/Capture'),
                                      onLongPress: () {
                                        _captureImage();
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                if (_selectedImage != null && _labels.isNotEmpty)
                  ShowLabels(
                    labels: _labels,
                    top: 0,
                    left: 0,
                    right: 0,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
/*
class ObjectDetectorPainter extends CustomPainter {
  final List<DetectedObject> objects;

  ObjectDetectorPainter(this.objects);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.red;

    for (final DetectedObject object in objects) {
      canvas.drawRect(
        object.boundingBox,
        paint,
      );

      // Optionally draw labels
      TextSpan span = TextSpan(
        text: object.labels.first.text,
        style: const TextStyle(color: Colors.red, fontSize: 16),
      );
      TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(
          canvas, Offset(object.boundingBox.left, object.boundingBox.top - 20));
    }
  }

  @override
  bool shouldRepaint(ObjectDetectorPainter oldDelegate) {
    return oldDelegate.objects != objects;
  }
}
*/