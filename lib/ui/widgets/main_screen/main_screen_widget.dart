import 'package:flutter/material.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/domain/factories/screen_factory.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;
  final _screenFactory = ScreenFactory();

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
        actions: [
          IconButton(
            onPressed: () => SessionDataProvider().deleteSessionId(),
            icon: const Icon(Icons.search),
          ),
          const Padding(padding: EdgeInsets.only(right: 10))
        ],
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          const Text('News'),
          _screenFactory.makeMovieListScreen(),
          const Text('Serials'),
        ],
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
