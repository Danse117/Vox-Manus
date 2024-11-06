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
  CameraController cameraController;
  CameraImage imgCamera;

  initCamera() {
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }

      setState(() {
        cameraController.startImageStream((imageFromStream) =>
            // ignore: unnecessary_set_literal
            {
              if (!isWorking)
                {
                  isWorking = true,
                  imgCamera = imageFromStream,
                }
            });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Returns a widget when flutter reloads app
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
              children: [
                Stack(
                  children: [
                    Center(
                      child: Container(
                          color: Colors.black,
                          height: 320,
                          width: 330,
                          child: Image.asset("assets/camera.png")),
                    ),
                    Center(
                        child: TextButton(
                          onPressed: (){
                            initCamera();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 35),
                            height: 270,
                            width: 360,
                            // ignore: unnecessary_null_comparison
                            child: imgCamera == null
                                ? Container(
                              height: 270,
                              width: 360,
                              child: const Icon(Icons.photo_camera_back,
                                  color: Colors.black, size: 40),
                            )
                                : AspectRatio(
                              aspectRatio: cameraController.value.aspectRatio,
                              child: CameraPreview(cameraController),
                            ),
                          ),
                        )),
                  ],
                )
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
            fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      toolbarHeight: 50,
      elevation: 0.0,
    );
  }

  // Bottom Nav
  BottomNavigationBar bottomNav() {
    return BottomNavigationBar(
      backgroundColor: AppTheme.colors.darkBackgroundColor,
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
