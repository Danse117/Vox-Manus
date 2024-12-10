import 'package:flutter/material.dart';

import 'package:app_prototype/components/mainbutton.dart';
import 'package:app_prototype/components/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/google_sign.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.onTap});
  final Function()? onTap;
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  // Sign up function
  void signUserUp() async {
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    try {
      if (passwordController.text == passwordConfirmController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        showErrorMessage("Passwords do not match");
        Navigator.pop(context);
      }
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
                const SizedBox(height: 30),
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
                  "Create an account below!",
                  style: TextStyle(
                    color: AppTheme.colors.primaryColor,
                    fontSize: 20,
                  ),
                ),

                const SizedBox(height: 30),

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

                const SizedBox(height: 10),

                //Confirm Password textfield
                TextFieldWidget(
                    hintText: "Confirm Password",
                    controller: passwordConfirmController,
                    obscureText: true),

                const SizedBox(height: 25),

                //Sign Up Button
                MainButton(onTap: signUserUp, buttonText: "Sign Up!"),
                const SizedBox(height: 20),

                //Continue with Google Button
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        color: AppTheme.colors.primaryColor,
                        thickness: 0.5,
                      )),
                      Text(
                        " Or continue with ",
                        style: TextStyle(
                          color: AppTheme.colors.primaryColor,
                          fontSize: 15,
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 0.5,
                        color: AppTheme.colors.primaryColor,
                      )),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

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
                      "Already have an account?",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login Now!",
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
