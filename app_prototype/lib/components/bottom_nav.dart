import 'package:app_prototype/views/view_translations.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/page_transition.dart';
import '../views/home.dart';
import '../views/account_page.dart';

// Bottom Nav
BottomNavigationBar bottomNav(BuildContext context) {
  return BottomNavigationBar(
    backgroundColor: AppTheme.colors.darkBackgroundColor,
    selectedItemColor: AppTheme.colors.primaryColor,
    unselectedItemColor: AppTheme.colors.primaryColor,
    selectedLabelStyle: const TextStyle(color: Colors.white),
    unselectedLabelStyle: const TextStyle(color: Colors.white),
    onTap: (index) {
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            PageTransitions.fadeTransition(HomePage()),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            PageTransitions.fadeTransition(const ViewTranslations()),
          );
          break;
          case 2:
          Navigator.pushReplacement(
            context,
            PageTransitions.fadeTransition(const AccountPage()),
          );
          break;
      }
    },
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home, color: AppTheme.colors.primaryColor),
        label: 'Home',
        tooltip: 'Home',
        key: Key('home'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.translate, color: AppTheme.colors.primaryColor),
        label: 'Translations',
        tooltip: 'Translations',
        key: Key('translations'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle, color: AppTheme.colors.primaryColor),
        label: 'Account',
        tooltip: 'Account',
        key: Key('account'),
      ),
    ],
  );
}
