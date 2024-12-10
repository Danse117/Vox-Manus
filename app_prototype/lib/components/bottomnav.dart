import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// Bottom Nav
BottomNavigationBar bottomNav() {
  return BottomNavigationBar(
    backgroundColor: AppTheme.colors.darkLightBackgroundColor,
    selectedItemColor: AppTheme.colors.primaryColor,
    unselectedItemColor: AppTheme.colors.primaryColor,
    selectedLabelStyle: const TextStyle(color: Colors.white),
    unselectedLabelStyle: const TextStyle(color: Colors.white),
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home, color: AppTheme.colors.primaryColor),
        label: 'Home',
        key: Key('home'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle, color: AppTheme.colors.primaryColor),
        label: 'Account',
        key: Key('account'),
      ),
    ],
  );
}
