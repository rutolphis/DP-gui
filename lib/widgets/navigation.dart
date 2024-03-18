import 'package:flutter/material.dart';
import 'package:gui_flutter/pages/home/home.dart';
import 'package:gui_flutter/pages/settings/settings.dart';

class NavigationWidget extends StatefulWidget {
  @override
  _NavigationWidgetState createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomePage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}