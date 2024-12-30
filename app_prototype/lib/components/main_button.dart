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
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: AppTheme.colors.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
        child: Text(
          buttonText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
