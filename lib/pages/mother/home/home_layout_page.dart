import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:smartguide_app/pages/mother/home/chat_view.dart';
import 'package:smartguide_app/pages/mother/home/home_view.dart';
import 'package:smartguide_app/pages/mother/profile/profile_view.dart';
import 'package:smartguide_app/pages/mother/settings/settings_view.dart';

class HomeLayoutPage extends StatefulWidget {
  const HomeLayoutPage({super.key});

  @override
  State<HomeLayoutPage> createState() => _HomeLayoutPageState();
}

class _HomeLayoutPageState extends State<HomeLayoutPage> {
  bool extendBehindAppbar = false;
  int selectedView = 0;
  final PageController _pageController = PageController();
  List<int> navigationStack = [0];

  final List<Widget> views = [
    HomeView(),
    ChatView(),
    ProfileView(),
    SettingsView(),
  ];

  final List<String> titles = ["CareNest", "Chat", "", "Settings"];

  void _onItemTapped(int index) {
    if (index == selectedView) return;

    if (index == 2) {
      setState(() {
        extendBehindAppbar = true;
      });
    } else {
      extendBehindAppbar = false;
    }

    if (index == 0) {
      navigationStack = [0];
    } else {
      navigationStack.add(index);
    }

    setState(() {
      selectedView = index;
    });

    _pageController.jumpToPage(index);
  }

  void _handlePop(bool didPop) {
    if (!didPop && navigationStack.length > 1) {
      navigationStack.removeLast();
      int previousView = navigationStack.last;

      setState(() {
        selectedView = previousView;
        extendBehindAppbar = (previousView == 2);
      });

      _pageController.jumpToPage(previousView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: navigationStack.length <= 1,
      onPopInvoked: _handlePop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:
              extendBehindAppbar ? Colors.transparent : Theme.of(context).colorScheme.primary,
          automaticallyImplyLeading: false,
          title: Text(
            titles[selectedView],
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 8 * 3),
          ),
        ),
        extendBodyBehindAppBar: extendBehindAppbar,
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(), // Disable swipe to change page
          children: views,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedView,
          onTap: _onItemTapped,
          selectedItemColor: Color(0xffe0f0de),
          backgroundColor: Theme.of(context).colorScheme.primary,
          iconSize: 8 * 4,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Ionicons.home_outline),
              activeIcon: Icon(Ionicons.home),
              label: "Home",
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.chatbubble_outline),
              activeIcon: Icon(Ionicons.chatbubble),
              label: "Chats",
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.person_outline),
              activeIcon: Icon(Ionicons.person),
              label: "Profile",
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.settings_outline),
              activeIcon: Icon(Ionicons.settings),
              label: "Settings",
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
