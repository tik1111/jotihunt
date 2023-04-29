import 'package:flutter/material.dart';

class Navigator extends StatelessWidget {
  const Navigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.looks_one), label: "Blue"),
        BottomNavigationBarItem(icon: Icon(Icons.looks_two), label: "Orange"),
        BottomNavigationBarItem(icon: Icon(Icons.looks_3), label: "Red"),
      ],
    );
  }
}
