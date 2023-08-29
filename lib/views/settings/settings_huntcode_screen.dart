import 'package:flutter/material.dart';

class SettingsHuntcodeScreen extends StatefulWidget {
  const SettingsHuntcodeScreen({super.key});

  @override
  State<SettingsHuntcodeScreen> createState() => _SettingsHuntcodeScreenState();
}

class _SettingsHuntcodeScreenState extends State<SettingsHuntcodeScreen> {
  final Color backgroundColor = const Color.fromARGB(255, 33, 34, 45);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      backgroundColor: backgroundColor,
      body: const Text("Huntcode view"),
    );
  }
}
