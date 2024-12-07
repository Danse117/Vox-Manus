import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: (){
          signInWithGoogle();
        }, child: Text("Sign in with Google")
        ),
      ),
    );
  }
}

signInWithGoogle() async {
  
  FirebaseAuth.instance.signInWithPopup(GoogleAuthProvider());
}
