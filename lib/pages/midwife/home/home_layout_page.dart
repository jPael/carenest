import 'package:flutter/material.dart';
import 'package:smartguide_app/pages/midwife/home/home_view.dart';

class HomeLayoutPage extends StatefulWidget {
  const HomeLayoutPage({super.key});

  @override
  State<HomeLayoutPage> createState() => _HomeLayoutPageState();
}

class _HomeLayoutPageState extends State<HomeLayoutPage> {
  final List<Widget> views = [
    HomeView(),
    Text("Chat"),
    Text("Profile"),
    Text("Settings"),
  ];

  int selectedView = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedView = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(),
      ),
      body: Container(
        child: views.elementAt(selectedView),
      ),
      bottomNavigationBar: NavigationBar(
          selectedIndex: selectedView,
          onDestinationSelected: _onItemTapped,
          destinations: [
            NavigationDestination(icon: Icon(Icons.home_outlined), label: "Home"),
            NavigationDestination(icon: Icon(Icons.chat_outlined), label: "Chats"),
            NavigationDestination(icon: Icon(Icons.person_outlined), label: "Profile"),
            NavigationDestination(icon: Icon(Icons.settings_outlined), label: "Settings"),
          ]),
    );
  }
}
