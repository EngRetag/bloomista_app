import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  bool _otpSent = false; // Track if OTP was sent
  bool _otpVerified = false; // Track if OTP was verified

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDECEF),
      appBar: AppBar(
        title: const Text("Forgot Password"),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Reset your password",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Step 1: Enter Email
            if (!_otpSent) ...[
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: "Enter your email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_emailController.text.contains("@")) {
                    setState(() {
                      _otpSent = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("OTP sent to your email")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                child: const Text("Send OTP"),
              ),
            ],

            // Step 2: Enter OTP
            if (_otpSent && !_otpVerified) ...[
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Enter 4-digit OTP",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_otpController.text == "1234") { // temporary check
                    setState(() {
                      _otpVerified = true;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Invalid OTP")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                child: const Text("Verify OTP"),
              ),
            ],

            // Step 3: Enter New Password
            if (_otpVerified) ...[
              TextField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Enter new password",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_newPasswordController.text.length >= 6) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Password reset successful")),
                    );
                    Navigator.pushNamed(context, '/login');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Password too short")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                child: const Text("Save New Password"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
