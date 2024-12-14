import 'package:app_prototype/components/camera_widget.dart';
import 'package:app_prototype/main.dart';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../components/translate_text.dart';
import '../components/bottom_nav.dart';
import '../components/logout.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final User user = FirebaseAuth.instance.currentUser!;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CameraController _cameraController;
  bool isCameraInitialized = false;
  bool isCameraOn = true;
  bool isTextMode = false;

/*
Camera Functionality:
  toggleMode()
    - toggles the mode between text and camera  
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
  void toggleMode(bool value) {
    setState(() {
      isTextMode = value;
      if (isTextMode && isCameraOn) {
        toggleCamera(false);
      }
    });
  }

  void initCamera() {
    if (isCameraInitialized || isCameraOn) {
      _cameraController = CameraController(
        cameras[0],
        ResolutionPreset.high,
        enableAudio: false,
      );

      _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {
          isCameraInitialized = true;
        });
      }).catchError((error) {
        Text("Error initializing camera: $error");
      });
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
          resizeToAvoidBottomInset: true,
          appBar: appBar(),
          backgroundColor: AppTheme.colors.darkLightBackgroundColor,
          body: Column(
            children: [
              // Mode Toggle (Camera/Text)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.camera_enhance,
                        size: 30, color: AppTheme.colors.primaryLight),
                    Switch(
                      value: isTextMode,
                      onChanged: toggleMode,
                      inactiveThumbColor: AppTheme.colors.primaryColor,
                      inactiveTrackColor: Colors.white,
                    ),
                    Icon(Icons.translate,
                        size: 30, color: AppTheme.colors.primaryLight),
                  ],
                ),
              ),

              // Main Content Area
              Expanded(
                child: isTextMode
                    ? const TextModeWidget()
                    : Column(
                        children: [
                          Expanded(
                            child: CameraWidget(
                              cameraController: _cameraController,
                              isCameraInitialized: isCameraInitialized,
                            ),
                          ),
                          // Camera toggle
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Camera",
                                style: TextStyle(
                                  color: AppTheme.colors.primaryLight,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Switch(
                                value: isCameraOn,
                                onChanged: toggleCamera,
                                inactiveThumbColor:
                                    AppTheme.colors.primaryColor,
                                inactiveTrackColor:
                                    AppTheme.colors.darkLightBackgroundColor,
                                
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ],
          ),
          bottomNavigationBar: bottomNav(context),
        ),
      ),
    );
  }
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
    toolbarHeight: 60,
    elevation: 0.0,
    actions: const [
      LogoutButton(),
    ],
  );
}
