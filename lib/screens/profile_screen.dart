import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDECEF),

      body: SafeArea(
        child: Column(
          children: [

            // Top Space
            const SizedBox(height: 20),

            // Page Title
            const Text(
              "My Profile",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Profile Image
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 55,
                color: Colors.pink,
              ),
            ),

            const SizedBox(height: 30),

            // White Container
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: const BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),

                child: Column(
                  children: [

                    // Full Name Field
                    buildTextField("Full Name"),

                    const SizedBox(height: 15),

                    // Email Field
                    buildTextField("Email Address"),

                    const SizedBox(height: 15),

                    // Phone Field
                    buildTextField("Phone Number"),

                    const SizedBox(height: 35),

                    // Save Button
                    SizedBox(
                      width: double.infinity,

                      child: ElevatedButton(
                        onPressed: () {},

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,

                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),

                        child: const Text(
                          "Save Changes",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable TextField Widget
  Widget buildTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,

        filled: true,
        fillColor: const Color(0xFFF7F7F7),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}