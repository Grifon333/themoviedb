import 'package:flutter/material.dart';

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TMDB'
        ),
      ),
      body: const Text(
        'This is main screen'
      ),
    );
  }
}
