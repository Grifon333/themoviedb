import 'package:flutter/material.dart';

class SearchQueryField extends StatelessWidget {
  final void Function(String) onChanged;
  const SearchQueryField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: 'Search',
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        suffixIcon: const Icon(Icons.search),
        border: const OutlineInputBorder(),
      ),
    );
  }
}