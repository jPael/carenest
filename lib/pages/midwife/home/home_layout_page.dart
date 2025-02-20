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
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: Row(),
      ),
      body: Container(
        child: views.elementAt(selectedView),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedView,
          onTap: _onItemTapped,
          selectedItemColor: Colors.white,
          backgroundColor: Theme.of(context).colorScheme.primary,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: "Home",
                backgroundColor: Theme.of(context).colorScheme.primary),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_outlined),
                activeIcon: Icon(Icons.chat),
                label: "Chats",
                backgroundColor: Theme.of(context).colorScheme.primary),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined),
                activeIcon: Icon(Icons.person),
                label: "Profile",
                backgroundColor: Theme.of(context).colorScheme.primary),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
                label: "Settings",
                backgroundColor: Theme.of(context).colorScheme.primary),
          ]),
    );
  }
}
