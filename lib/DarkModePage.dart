import 'package:flutter/material.dart';

class DarkModePage extends StatefulWidget {
  const DarkModePage({super.key});

  @override
  _DarkModePageState createState() => _DarkModePageState();
}

class _DarkModePageState extends State<DarkModePage> {
  bool _isDarkMode = false; // Dark mode toggle state

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dark Mode Settings"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: IconButton(
          icon: Icon(
            _isDarkMode ? Icons.dark_mode : Icons.light_mode,
            size: 100,
            color: Colors.blue,
          ),
          onPressed: _toggleDarkMode,
        ),
      ),
    );
  }
}
