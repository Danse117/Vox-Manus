import 'dart:io';
import 'package:app_prototype/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CameraController _cameraController;
  bool isCameraInitialized = false;
  bool isCameraOn = true;
  String errorMessage = '';


/*
Camera Functionality:
  initCamera() 
    - initializes the camera controller
        - checks if the camera is already initialized or if the camera is off
        - tries to initialize the camera controller
        - sets the state to update the UI if the camera is initialized successfully
  toggleCamera()
    - toggles the camera on and off
        - checks if the camera is already initialized or if the camera is off
        - if the camera is on, it initializes the camera controller
        - if the camera is off, it disposes of the camera controller
  CameraWidget
    - displays the camera preview
        - displays an error message if there is an error with the camera
        - displays a loading indicator if the camera is not initialized
        - displays the camera preview if the camera is initialized 
*/
  void initCamera() {
    if (isCameraInitialized || !isCameraOn) return;
    try {
      _cameraController = CameraController(
        cameras[0], 
        ResolutionPreset.medium,
        enableAudio: false,
      );

      _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {
          isCameraInitialized = true;
        });
      });
    } catch (e) {
      print("Camera init error: $e");
    }
  }

  // Toggle the camera on/off based on the switch
  void toggleCamera(bool value) {
    setState(() {
      isCameraOn = value;
      if (isCameraOn) {
        initCamera();
      } else if (isCameraInitialized) {
        _cameraController.dispose();
        isCameraInitialized = false;
      }
    });
  }

/*
State Functionality:
  initState()
    - initializes the camera
  dispose()
    - disposes of the camera controller
  build()
    - displays the application UI
        - displays the app bar
        - displays the camera preview
        - displays the toggle switch for the camera
        - displays the bottom navigation bar
*/
  @override
  void initState() {
    super.initState();
    initCamera();
  }

  @override
  void dispose() {
    if (isCameraInitialized) {
      _cameraController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: appBar(),
          backgroundColor: AppTheme.colors.darkLightBackgroundColor,
          body: Container(
            decoration: BoxDecoration(
              color: AppTheme.colors.primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: [
                    Center(
                      child: CameraWidget(
                        cameraController: _cameraController,
                        isCameraInitialized: isCameraInitialized,
                        errorMessage: errorMessage,
                      ),
                    ),
                  ],
                ),
                // Toggle switch for turning the camera on and off
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Camera",
                        style: TextStyle(
                          color: AppTheme.colors.darkBackgroundColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Switch(
                        value: isCameraOn,
                        onChanged: toggleCamera,
                        inactiveThumbColor: AppTheme.colors.primaryColor,
                        inactiveTrackColor:
                            AppTheme.colors.darkLightBackgroundColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: bottomNav(),
        ),
      ),
    );
  }

  // App Bar
  AppBar appBar() {
    return AppBar(
      backgroundColor: AppTheme.colors.darkBackgroundColor,
      title: Text(
        'Vox Manus',
        style: TextStyle(
          color: AppTheme.colors.primaryColor,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      toolbarHeight: 50,
      elevation: 0.0,
    );
  }

  // Bottom Nav
  BottomNavigationBar bottomNav() {
    return BottomNavigationBar(
      backgroundColor: AppTheme.colors.darkLightBackgroundColor,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: AppTheme.colors.primaryColor),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.translate, color: AppTheme.colors.primaryColor),
          label: 'Translate',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle, color: AppTheme.colors.primaryColor),
          label: 'Account',
        ),
      ],
    );
  }
}

// Separate widget for camera preview
class CameraWidget extends StatefulWidget {
  final CameraController cameraController;
  final bool isCameraInitialized;
  final String errorMessage;

  const CameraWidget({
    required this.cameraController,
    required this.isCameraInitialized,
    required this.errorMessage,
  });

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.errorMessage.isNotEmpty) {
      return Center(
        child: Text(
          widget.errorMessage,
          style: const TextStyle(color: Colors.red, fontSize: 16),
        ),
      );
    }

    if (!widget.isCameraInitialized ||
        !widget.cameraController.value.isInitialized) {
      return Container(
        color: Colors.black,
        height: 320,
        width: 330,
        child:
            const Icon(Icons.photo_camera_back, color: Colors.white, size: 40),
      );
    }

    return SizedBox(
      height: 500,
      width: 400,
      child: AspectRatio(
        aspectRatio: widget.cameraController.value.aspectRatio,
        child: CameraPreview(widget.cameraController),
      ),
    );
  }
}

