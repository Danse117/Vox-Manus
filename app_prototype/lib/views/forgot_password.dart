import 'package:app_prototype/components/text_field.dart';
import 'package:app_prototype/theme/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Password reset email sent, check your email for instructions')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error sending password reset email')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.darkBackgroundColor,
        foregroundColor: AppTheme.colors.primaryColor,
        elevation: 0,
        title: Text(
          'Forgot Password?',
          style: TextStyle(
            color: AppTheme.colors.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: AppTheme.colors.darkLightBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              'Enter your email to reset your password',
              style: TextStyle(
                color: AppTheme.colors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFieldWidget(
              hintText: 'Email',
              controller: emailController,
              obscureText: false,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: passwordReset,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.colors.primaryColor,
              ),
              child: const Text('Reset Password',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
