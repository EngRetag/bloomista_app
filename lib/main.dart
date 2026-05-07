import 'package:flutter/material.dart';
import 'screens/thank_you_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const BloomistaApp());
}

// Root application widget
class BloomistaApp extends StatelessWidget {
  const BloomistaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // Application title
      title: 'Bloomista App',

      // Global theme settings
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),

      // Initial screen when the app starts
      home: const ThankYouScreen(),

      // Named routes for navigation
      routes: {
        '/profile': (context) => const ProfileScreen(),
        '/thankyou': (context) => const ThankYouScreen(),
      },
    );
  }
}