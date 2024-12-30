import 'package:flutter/material.dart';
import 'app_theme.dart';

@override
class Utils {
  void showErrorMessage(String message) {
    Future build(BuildContext context) {
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: AppTheme.colors.darkLightBackgroundColor,
                title: Center(
                  child: Text(message,
                      style: TextStyle(
                        color: AppTheme.colors.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ));
    }
  }
}
