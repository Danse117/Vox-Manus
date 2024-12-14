import 'package:app_prototype/components/main_button.dart';
import 'package:app_prototype/components/text_field.dart';
import 'package:app_prototype/views/forgot_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/google_sign.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.onTap});
  final Function()? onTap;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Sign in function
  void signUserIn() async {
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Pop the loading dialog AFTER the user is signed in
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Pop the loading dialog if there is an error
      Navigator.pop(context);
      // Show error message
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
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

  // Build the login page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.darkLightBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                const SizedBox(height: 50),
                Text(
                  'Vox Manus',
                  style: TextStyle(
                    color: AppTheme.colors.primaryColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Welcome Text
                Text(
                  "Welcome!",
                  style: TextStyle(
                    color: AppTheme.colors.primaryLight,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 50),

                //Username textfield
                TextFieldWidget(
                    hintText: "Email",
                    controller: emailController,
                    obscureText: false),

                const SizedBox(height: 10),

                //Password textfield
                TextFieldWidget(
                    hintText: "Password",
                    controller: passwordController,
                    obscureText: true),

                const SizedBox(height: 25),

                // Forgot Password Text
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage()),
                    );
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: AppTheme.colors.primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                //Login Button
                MainButton(onTap: signUserIn, buttonText: "Login"),

                const SizedBox(height: 25),

                //Continue with Google Button
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        color: AppTheme.colors.primaryColor,
                        thickness: 1,
                      )),
                      Text(
                        " Or continue with ",
                        style: TextStyle(
                          color: AppTheme.colors.primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 1,
                        color: AppTheme.colors.primaryColor,
                      )),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => GoogleSignInService().signInWithGoogle(),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child:
                            Image.asset("assets/google_logo.png", height: 35),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register Now!",
                        style: TextStyle(
                            color: AppTheme.colors.primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
