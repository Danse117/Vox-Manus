import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_prototype/components/main_button.dart';
import 'package:app_prototype/components/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final displayNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  // Sign up function
  Future signUserUp() async {
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    try {
      if (passwordController.text == passwordConfirmController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        await FirebaseAuth.instance.currentUser!.updateProfile(
          displayName: displayNameController.text.trim(),
        );
        addUserInformation(
            emailController.text.trim(),
            displayNameController.text.trim(),
            firstNameController.text.trim(),
            lastNameController.text.trim());
      } else {
        showErrorMessage("Passwords do not match");
        Navigator.pop(context);
      }
      // Pop the loading dialog AFTER the user is signed in
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Pop the loading dialog if there is an error
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // Show error message
      showErrorMessage(e.code);
    }
  }

// Adding User information to collection on Google Firestore
  Future addUserInformation(
      String email, String userName, String firstName, String lastName) async {
    await FirebaseFirestore.instance.collection("Users").add({
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "userName": userName,
    });
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
                const SizedBox(height: 10),

                // Welcome Text
                const Text(
                  "Create an account below!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                //Display Name textfield
                TextFieldWidget(
                    hintText: "First Name",
                    controller: firstNameController,
                    obscureText: false),

                const SizedBox(height: 10),

                //Display Name textfield
                TextFieldWidget(
                    hintText: "Last Name",
                    controller: lastNameController,
                    obscureText: false),

                const SizedBox(height: 10),

                //Display Name textfield
                TextFieldWidget(
                    hintText: "Display Name",
                    controller: displayNameController,
                    obscureText: false),
                const SizedBox(height: 10),

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
                const Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      Text(
                        "Passwords must have: 8 characters, 1 uppercase, 1 lowercase, 1 number, and 1 special character. Ex. Password123!",
                        style: TextStyle(
                            color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
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
                      const Text(
                        " Or continue with ",
                        style: TextStyle(
                          color: Colors.white,
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
