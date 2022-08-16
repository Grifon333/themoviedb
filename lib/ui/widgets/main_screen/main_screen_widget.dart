import 'package:flutter/material.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/ui/widgets/movie_list/movie_list_widget.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;

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
            onPressed: () => SessionDataProvider().setSessionId(null),
            icon: const Icon(Icons.search),
          ),
          const Padding(padding: EdgeInsets.only(right: 10))
        ],
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          const Text('News'),
          MovieListWidget(),
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
