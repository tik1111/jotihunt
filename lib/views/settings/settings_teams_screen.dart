import 'package:flutter/material.dart';

class SettingsTeamScreen extends StatefulWidget {
  const SettingsTeamScreen({super.key});

  @override
  State<SettingsTeamScreen> createState() => _SettingsTeamScreenState();
}

class _SettingsTeamScreenState extends State<SettingsTeamScreen> {
  final Color backgroundColor = const Color.fromARGB(255, 33, 34, 45);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      backgroundColor: backgroundColor,
      body: const Text("Teams view"),
    );
  }
}
