import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  bool _showCameraIcon = true;

  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Email validation
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email);
  }

  // Phone validation
  bool _isValidPhone(String phone) {
    final phoneRegex = RegExp(r'^[0-9]{10,}$');
    return phoneRegex.hasMatch(phone);
  }

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  // Load saved data (name, email, phone, image path)
  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString("name") ?? "";
      _emailController.text = prefs.getString("email") ?? "";
      _phoneController.text = prefs.getString("phone") ?? "";

      final imagePath = prefs.getString("profileImage");
      if (imagePath != null && imagePath.isNotEmpty) {
        _image = File(imagePath);
        _showCameraIcon = false;
      }
    });
  }

  // Save data (name, email, phone, image path)
  Future<void> _saveProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", _nameController.text.trim());
    await prefs.setString("email", _emailController.text.trim());
    await prefs.setString("phone", _phoneController.text.trim());

    if (_image != null) {
      await prefs.setString("profileImage", _image!.path);
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Choose Image Source"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.camera),
            child: const Text("Camera"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
            child: const Text("Gallery"),
          ),
        ],
      ),
    );

    if (source != null) {
      final pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 600,
        maxHeight: 600,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          _showCameraIcon = false;
        });

        // Save image path permanently
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("profileImage", pickedFile.path);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDECEF),
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Colors.pink,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Profile image with camera icon
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? const Icon(Icons.person, size: 55, color: Colors.pink)
                      : null,
                ),
                if (_showCameraIcon)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.pink),
                      onPressed: _pickImage,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 30),

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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Name field
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: "Full Name",
                          filled: true,
                          fillColor: Color(0xFFF7F7F7),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Name cannot be empty. Please enter your full name.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),

                      // Email field
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: "Email Address",
                          filled: true,
                          fillColor: Color(0xFFF7F7F7),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Email is required.";
                          }
                          if (!_isValidEmail(value.trim())) {
                            return "Invalid email format. Example: user@example.com";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),

                      // Phone field
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: "Phone Number",
                          filled: true,
                          fillColor: Color(0xFFF7F7F7),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Phone number is required.";
                          }
                          if (!_isValidPhone(value.trim())) {
                            return "Invalid phone number. Must be at least 10 digits.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 35),

                      // Save button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await _saveProfileData(); // Save data permanently
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Changes Saved!")),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text("Save Changes"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
