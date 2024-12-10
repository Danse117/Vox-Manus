import 'package:flutter/material.dart';
import 'package:app_prototype/theme/app_theme.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final controller;
  final bool obscureText;

  TextFieldWidget(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        style: TextStyle(color: Colors.white),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.colors.primaryColor),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppTheme.colors.primaryColor,
          ),
          fillColor: AppTheme.colors.darkLightBackgroundColor,
          filled: true,
        ),
      ),
    );
  }
}
