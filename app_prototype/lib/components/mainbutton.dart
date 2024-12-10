import 'package:flutter/material.dart';
import 'package:app_prototype/theme/app_theme.dart';

class MainButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;

  const MainButton({super.key, required this.onTap, required this.buttonText});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 35),
        decoration: BoxDecoration(
          color: AppTheme.colors.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
