import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

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
  @override
  Widget build(BuildContext context) {
    if (!widget.isCameraInitialized ||
        !widget.cameraController.value.isInitialized) {
      return Container(
        color: Colors.black,
        height: 400,
        width: 400,
        child:
            const Icon(Icons.photo_camera_back, color: Colors.white, size: 40),
      );
    }
    return Flexible(
      flex: 1,
      child: SizedBox(
        height: 400,
        width: 400,
        child: AspectRatio(
          aspectRatio: widget.cameraController.value.aspectRatio,
          child: CameraPreview(widget.cameraController),
        ),
      ),
    );
  }
}
