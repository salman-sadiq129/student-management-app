import 'package:flutter/material.dart';
import 'package:flutter_application_1/AboutPage.dart';
import 'package:flutter_application_1/AddUserPage.dart';
import 'package:flutter_application_1/FavoritesPage.dart';
import 'package:flutter_application_1/FilesPage.dart';
import 'package:flutter_application_1/PersonInfoPage.dart';
import 'package:flutter_application_1/PostPage.dart';
import 'package:flutter_application_1/ReviewPostPage.dart';
import 'package:flutter_application_1/SettingsPage.dart';
import 'package:flutter_application_1/chat_page.dart';
import 'package:flutter_application_1/sarake.dart';
import 'package:flutter_application_1/teacher_login_page.dart';

class AppHomePage extends StatefulWidget {
  final bool isAdmin;

  const AppHomePage(
      {super.key, required this.isAdmin, required userId, required userRole});

  @override
  _AppHomePageState createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  int _currentIndex = 3; // Set default index to 3 for Home tab
  final bool _isDarkMode = false; // Flag to track dark mode

  final List<Widget> _pages = [
    const TeachersPage(
      subject: '',
    ),
    const PostPage(),
    const ChatPage(), // Use the new chatpage here
    const HomePage(), // Use the new HomePage here
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF111827),
        appBar: AppBar(
          title: const Text(
            "One Team",
            style: TextStyle(
              color: Colors.white, // Set the title color here
            ),
          ),
          backgroundColor:
              const Color.fromARGB(255, 8, 12, 19), // AppBar background color
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_active, color: Colors.white),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Notifications clicked!')),
                );
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: Container(
            color: const Color(0xFF111827), // Light background for drawer
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                // Drawer Header Section
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 8, 12, 19),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          'https://th.bing.com/th/id/OIP.UYagQDMo7CCbBLXOPB5etAHaHa?rs=1&pid=ImgDetMain',
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'John Doe', // User name placeholder
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Admin', // User role placeholder
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                // Divider for clean separation
                // Drawer Menu Items
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.blueAccent),
                  title: const Text('Person Info',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushNamed(context, '/person');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.file_copy_sharp,
                      color: Colors.blueAccent),
                  title: const Text('Files',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushNamed(context, '/files');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.bookmark, color: Colors.blueAccent),
                  title: const Text('Favorites',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushNamed(context, '/favorites');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.blueAccent),
                  title: const Text('Settings',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info, color: Colors.blueAccent),
                  title: const Text('About',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushNamed(context, '/about');
                  },
                ),
                if (widget.isAdmin) ...[
                  const Divider(),
                  ListTile(
                    leading:
                        const Icon(Icons.rate_review, color: Colors.blueAccent),
                    title: const Text('Review Post',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pushNamed(context, '/reviewPost');
                    },
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.person_add, color: Colors.blueAccent),
                    title: const Text('Add User',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pushNamed(context, '/addUser');
                    },
                  ),
                ]
              ],
            ),
          ),
        ),
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(
              255, 8, 12, 19), // Updated bottom nav bar color
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor:
              Colors.white, // Selected item color for better visibility
          unselectedItemColor: Colors.white70, // Unselected item color
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.school, color: Colors.white),
              label: '', // Removed label text
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.post_add_sharp, color: Colors.white),
              label: '', // Removed label text
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat, color: Colors.white),
              label: '', // Removed label text
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.white),
              label: '', // Removed label text
            ),
          ],
        ),
      ),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light, // Use _isDarkMode to switch theme
      routes: {
        '/person': (context) => const PersonInfoPage(
              userId: '',
              userRole: '',
              password: '',
            ),
        '/files': (context) => const FilesPage(),
        '/favorites': (context) => const FavoritesPage(),
        '/settings': (context) => const SettingsPage(),
        '/about': (context) => const AboutPage(),
        '/reviewPost': (context) => const ReviewPostPage(),
        '/addUser': (context) => const AddUserPage(
              isAdmin: true,
              userId: true,
              userRole: true,
            ),
      },
    );
  }
}
