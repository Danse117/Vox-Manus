import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/bottom_nav.dart';
import '../theme/app_theme.dart';
import '../components/logout.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
    final User user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.darkLightBackgroundColor,
      // App Bar
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // Placeholder for user avatar
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              user.displayName!,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.colors.primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            // User Information
            _buildInfoCard('Email', user.email!),
          ],
        ),
      ),
      // Bottom Nav
      bottomNavigationBar: bottomNav(context),
    );
  }

  // Build Info Card for user information
  // Label: User information label
  // Value: User information value

  //TODO: Add more user information, phone number, first name, last name, etc.
  Widget _buildInfoCard(String label, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text(
              '$label: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// App Bar
AppBar appBar() {
  return AppBar(
    backgroundColor: AppTheme.colors.darkBackgroundColor,
    title: Text(
      'Vox Manus',
      style: TextStyle(
        color: AppTheme.colors.primaryColor,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
    toolbarHeight: 60,
    elevation: 0.0,
    actions: const [
      LogoutButton(),
    ],
  );
}
