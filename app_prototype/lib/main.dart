import 'package:app_prototype/views/account_page.dart';
import 'package:app_prototype/views/splashpage.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app_prototype/views/home.dart';
import 'package:app_prototype/views/account_page.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  cameras = await availableCameras();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Sans-serif',
      ),
      home: AppSplashPage(),
      routes: {
        '/home': (context) => HomePage(),
        '/account': (context) => AccountPage(),
        '/splash': (context) => AppSplashPage(),
      },
    );
  }
}
