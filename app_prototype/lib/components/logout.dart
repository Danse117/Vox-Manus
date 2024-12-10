import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_prototype/theme/app_theme.dart';

void signUserOut() {

  FirebaseAuth.instance.signOut();
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Are you sure you want to logout?",
                      style: TextStyle(
                          color: AppTheme.colors.darkBackgroundColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  actions: [
                    TextButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                        },
                        child: Text("Logout :)",
                            style: TextStyle(
                                color: AppTheme.colors.primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)))
                  ],
                )),
        icon: Icon(
          Icons.logout,
          color: AppTheme.colors.primaryColor,
        ));
  }
}
