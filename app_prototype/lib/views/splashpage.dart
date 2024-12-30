import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:app_prototype/theme/app_theme.dart';
import 'auth_page.dart';

class AppSplashPage extends StatefulWidget {
  const AppSplashPage({super.key});

  @override
  _AppSplashPageState createState() => _AppSplashPageState();
}

class _AppSplashPageState extends State<AppSplashPage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 3000,
        splashIconSize: 250,
        splash: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Vox Manus',
                style: TextStyle(
                    color: AppTheme.colors.primaryColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Hands speak, we listen',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        nextScreen: const AuthPage(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: AppTheme.colors.darkBackgroundColor);
  }
}
