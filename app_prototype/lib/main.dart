import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'views/splashpage.dart';

List<CameraDescription> cameras = [];

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp( const MyApp() );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        fontFamily: 'Sans-serif',
        ),
      home: AppSplashPage()
      );
  }
}