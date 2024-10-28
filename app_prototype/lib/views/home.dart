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

  @override
  Widget build(BuildContext context) {
    // Returns a widget when flutter reloads app
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: appBar(),
          backgroundColor: AppTheme.colors.darkLightBackgroundColor,
          body: Container(
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 320,
                    width: 320,
                    color: AppTheme.colors.primaryColor,
                  )
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
