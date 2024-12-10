import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:app_prototype/theme/app_theme.dart';
import 'auth_page.dart';

class AppSplashPage extends StatefulWidget {
  @override
  _AppSplashPageState createState() => _AppSplashPageState();
}

class _AppSplashPageState extends State<AppSplashPage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 3000,
        splash: Text(
          'Vox Manus',
          style: TextStyle(
              color: AppTheme.colors.primaryColor,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        nextScreen: AuthPage(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: AppTheme.colors.darkBackgroundColor);
  }
}
