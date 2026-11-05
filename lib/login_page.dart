import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final String loginUrl = "http://192.168.0.127/api/users/login_user.php";

  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final Map<String, dynamic> loginData = {
        'user_id': userIdController.text,
        'password': passwordController.text,
      };

      try {
        final response = await http.post(
          Uri.parse(loginUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(loginData),
        );

        final responseData = jsonDecode(response.body);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseData['message']),
            backgroundColor:
                responseData['success'] ? Colors.green : Colors.red,
          ),
        );

        if (responseData['success'] == true) {
          Navigator.pushReplacementNamed(
            context,
            '/home',
            arguments: {
              'userId': userIdController.text,
              'userRole': responseData['role'],
            },
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Connection Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.orangeAccent], // New color scheme
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // App Logo (Enlarged)
                Image.asset(
                  'assets/images/logo.png', // Update this path if needed
                  height: 160, // Enlarged logo
                  width: 160, // Enlarged logo
                ),
                const SizedBox(height: 30),

                // App Name (Larger Text and Different Color)
                const Text(
                  'One Team', // Replace with your app's name
                  style: TextStyle(
                    fontSize: 35, // Larger font size
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Text color updated
                  ),
                ),
                const SizedBox(height: 40),

                // Login Card (Updated Design)
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // User ID Field (Updated Style)
                        TextFormField(
                          controller: userIdController,
                          decoration: InputDecoration(
                            labelText: 'User ID',
                            labelStyle: const TextStyle(
                                color: Colors.teal), // Updated color
                            hintText: 'Enter your User ID',
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.teal),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? "Enter User ID"
                              : null,
                        ),
                        const SizedBox(height: 18),

                        // Password Field (Updated Style)
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                                color: Colors.teal), // Updated color
                            hintText: 'Enter your Password',
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.teal),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? "Enter Password"
                              : null,
                        ),
                        const SizedBox(height: 30),

                        // Enlarged Login Button (Updated Design)
                        ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal, // Updated color
                            padding: const EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 50), // Enlarged button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 18, // Enlarged font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: const Text("Login"),
                        ),
                        const SizedBox(height: 20),

                        // Forgot Password (Updated Text Style)
                        GestureDetector(
                          onTap: () {
                            // Add navigation for forgot password if needed
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.w500,
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
        ),
      ),
    );
  }
}
