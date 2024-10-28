import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Returns a widget when flutter reloads app
    return Scaffold(
      appBar: appBar(),
      backgroundColor: AppTheme.colors.darkLightBackgroundColor,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          color: Colors.amber[600],
          width: 48.0,
          height: 48.0,
        ),
      ),
      bottomNavigationBar: bottomNav(),
      // Navi
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
