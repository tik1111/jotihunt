import 'package:flutter/material.dart';

class SettingsAddHintScreen extends StatefulWidget {
  const SettingsAddHintScreen({super.key});

  @override
  State<SettingsAddHintScreen> createState() => _SettingsAddHintScreenState();
}

class _SettingsAddHintScreenState extends State<SettingsAddHintScreen> {
  final Color backgroundColor = const Color.fromARGB(255, 33, 34, 45);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      backgroundColor: backgroundColor,
      body: const Text("Add hint view"),
    );
  }
}
