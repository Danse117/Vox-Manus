import 'package:app_prototype/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isWorking = false;
  String result = "";
  late CameraController cameraController;
  late CameraImage imgCamera;
  bool isCameraInitialized = false;
  bool isCameraOn = true;  // New flag to control camera state
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  void initCamera() {
    if (isCameraInitialized || !isCameraOn) return;

    try {
      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.medium,
      );

      cameraController.initialize().then((_) {
        if (!mounted) return;

        setState(() {
          isCameraInitialized = true;
          cameraController.startImageStream((imageFromStream) {
            if (!isWorking) {
              setState(() {
                isWorking = true;
                imgCamera = imageFromStream;
              });
            }
          });
        });
      }).catchError((e) {
        setState(() {
          errorMessage = 'Error initializing camera: $e';
        });
        print(errorMessage);
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error setting up camera: $e';
      });
      print(errorMessage);
    }
  }

  // Toggle the camera on/off based on the switch
  void toggleCamera(bool value) {
    setState(() {
      isCameraOn = value;

      if (isCameraOn) {
        initCamera();
      } else if (isCameraInitialized) {
        cameraController.stopImageStream();
        isCameraInitialized = false;
      }
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
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
              children: [
                Stack(
                  children: [
                    Center(
                      child: CameraWidget(
                        cameraController: cameraController,
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
                        inactiveTrackColor: AppTheme.colors.darkLightBackgroundColor,
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
class CameraWidget extends StatelessWidget {
  final CameraController cameraController;
  final bool isCameraInitialized;
  final String errorMessage;

  const CameraWidget({
    required this.cameraController,
    required this.isCameraInitialized,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (errorMessage.isNotEmpty) {
      return Center(
        child: Text(
          errorMessage,
          style: const TextStyle(color: Colors.red, fontSize: 16),
        ),
      );
    }

    if (!isCameraInitialized || !cameraController.value.isInitialized) {
      return Container(
        color: Colors.black,
        height: 320,
        width: 330,
        child: const Icon(Icons.photo_camera_back,
            color: Colors.white, size: 40),
      );
    }

    return SizedBox(
      height: 320,
      width: 330,
      child: AspectRatio(
        aspectRatio: cameraController.value.aspectRatio,
        child: CameraPreview(cameraController),
      ),
    );
  }
}
