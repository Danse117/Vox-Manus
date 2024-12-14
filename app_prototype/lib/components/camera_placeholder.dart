import 'package:flutter/material.dart';
import 'package:app_prototype/theme/app_theme.dart';

class CameraPlaceholder extends StatelessWidget {
  const CameraPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [AppTheme.colors.primaryLight, Colors.black26],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: Icon(Icons.photo_camera,
            color: AppTheme.colors.primaryLight, size: 40),
      );
  }
}
