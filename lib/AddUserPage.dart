import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddUserPage extends StatefulWidget {
  const AddUserPage(
      {super.key,
      this.isAdmin = false,
      this.userId = false,
      this.userRole = false});

  final bool isAdmin;
  final bool userId;
  final bool userRole;

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();
  final String apiUrl = "http://192.168.0.127/api/users/add_user.php";

  String? selectedRole;
  String? selectedStage;
  String? selectedSpecialization;

  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController groupController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final Map<String, dynamic> formData = {
        'user_id': userIdController.text,
        'password': passwordController.text,
        'role': selectedRole!,
      };

      try {
        if (selectedRole == 'Teacher') {
          formData['subject'] = subjectController.text;
        } else if (selectedRole == 'Student') {
          formData['stage'] = selectedStage!;
          formData['group'] = groupController.text;
          if (selectedStage == '4' || selectedStage == '5') {
            formData['specialization'] = selectedSpecialization!;
          }
        }

        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(formData),
        );

        final responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseData['message']),
            backgroundColor:
                responseData['success'] ? Colors.green : Colors.red,
          ),
        );

        if (responseData['success']) {
          _formKey.currentState!.reset();
          setState(() {
            selectedRole = null;
            selectedStage = null;
            selectedSpecialization = null;
          });
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
      appBar: AppBar(
        title: const Text("Add User"),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Select Role"),
                value: selectedRole,
                items: ["Admin", "Teacher", "Student"]
                    .map((role) => DropdownMenuItem(
                          value: role,
                          child: Text(role),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRole = value;
                    selectedStage = null;
                    selectedSpecialization = null;
                  });
                },
                validator: (value) =>
                    value == null ? "Please select a role" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: userIdController,
                decoration: const InputDecoration(labelText: "User ID"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter User ID" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter Password" : null,
              ),
              const SizedBox(height: 16),
              if (selectedRole == "Teacher") ...[
                TextFormField(
                  controller: subjectController,
                  decoration: const InputDecoration(labelText: "Subject"),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Enter Subject" : null,
                ),
                const SizedBox(height: 16),
              ],
              if (selectedRole == "Student") ...[
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: "Select Stage"),
                  value: selectedStage,
                  items: ["1", "2", "3", "4", "5"]
                      .map((stage) => DropdownMenuItem(
                            value: stage,
                            child: Text("Stage $stage"),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() {
                    selectedStage = value;
                    selectedSpecialization = null;
                  }),
                  validator: (value) =>
                      value == null ? "Please select a stage" : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: groupController,
                  decoration: const InputDecoration(labelText: "Group"),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Enter Group" : null,
                ),
                const SizedBox(height: 16),
                if (selectedStage == "4" || selectedStage == "5")
                  DropdownButtonFormField<String>(
                    decoration:
                        const InputDecoration(labelText: "Specialization"),
                    value: selectedSpecialization,
                    items: ["Net", "Web", "Pro"]
                        .map((spec) => DropdownMenuItem(
                              value: spec,
                              child: Text(spec),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() {
                      selectedSpecialization = value;
                    }),
                    validator: (value) =>
                        value == null ? "Please select specialization" : null,
                  ),
              ],
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  "Add User",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
