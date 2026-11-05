import 'package:flutter/material.dart';

class PersonInfoPage extends StatelessWidget {
  final String userId;
  final String userRole;
  final String password;

  // Constructor to accept arguments
  const PersonInfoPage({
    super.key,
    required this.userId,
    required this.userRole,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Displaying user profile data
            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                'https://th.bing.com/th/id/OIP.UYagQDMo7CCbBLXOPB5etAHaHa?rs=1&pid=ImgDetMain',
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "User ID: $userId", // Display userId dynamically
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "Role: $userRole", // Display userRole dynamically
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "Password: $password", // Display password dynamically (consider security)
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
