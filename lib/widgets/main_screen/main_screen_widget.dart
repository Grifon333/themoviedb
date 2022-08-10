import 'package:flutter/material.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;
  static const List<Widget> _widgetOptions = [
    Text('News'),
    Text('Movies'),
    Text('Serials'),
  ];

  void onSelectedTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDB'),
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions[_selectedTab],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: 'News',
            icon: Icon(Icons.newspaper),
          ),
          BottomNavigationBarItem(
            label: 'Movies',
            icon: Icon(Icons.local_movies),
          ),
          BottomNavigationBarItem(
            label: 'Serials',
            icon: Icon(Icons.tv),
          ),
        ],
        onTap: onSelectedTab,
        currentIndex: _selectedTab,
      ),
    );
  }
}
