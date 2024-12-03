import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'views/splashpage.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

List<CameraDescription> cameras = [];

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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