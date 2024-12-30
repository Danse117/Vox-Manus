import 'package:app_prototype/components/logout.dart';
import 'package:app_prototype/components/bottom_nav.dart';
import 'package:app_prototype/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ViewTranslations extends StatefulWidget {
  const ViewTranslations({super.key});

  @override
  State<ViewTranslations> createState() => _ViewTranslationsState();
}

//TODO: Implement user saving last 5 translations
class _ViewTranslationsState extends State<ViewTranslations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: AppTheme.colors.darkLightBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Previous Translations',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.colors.primaryLight),
            ),
            Divider(
              color: AppTheme.colors.primaryLight,
              thickness: 2,
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNav(context),
    );
  }
}

// App Bar
AppBar appBar() {
  return AppBar(
    backgroundColor: AppTheme.colors.darkBackgroundColor,
    title: Text(
      'Vox Manus',
      style: TextStyle(
        color: AppTheme.colors.primaryLight,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
    toolbarHeight: 60,
    elevation: 0.0,
    actions: const [
      LogoutButton(),
    ],
  );
}
