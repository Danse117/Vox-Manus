import 'package:flutter/material.dart';
import 'package:app_prototype/theme/app_theme.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final bool obscureText;

  const TextFieldWidget(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.colors.primaryColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          fillColor: AppTheme.colors.darkLightBackgroundColor,
          filled: true,
        ),
      ),
    );
  }
}
