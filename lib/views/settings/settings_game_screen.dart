import 'package:flutter/material.dart';
import 'package:jotihunt/handlers/handler_game.dart';

class SettingsGameScreen extends StatefulWidget {
  const SettingsGameScreen({super.key});

  @override
  State<SettingsGameScreen> createState() => _SettingsGameScreenState();
}

class _SettingsGameScreenState extends State<SettingsGameScreen> {
  final Color backgroundColor = const Color.fromARGB(255, 33, 34, 45);
  String? selectedGame;
  final TextEditingController gameNameController = TextEditingController();
  final List<String> availableGames = ['Game 1', 'Game 2', 'Game 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              "Nieuw spel:",
              style: TextStyle(color: Colors.white),
            ),
            TextField(
              controller: gameNameController,
              decoration: const InputDecoration(
                hintText: 'Spel naam ',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: () {
                GameHandler().createNewGame('gameName');
              },
              child: const Text("Aanmaken"),
            ),
            const SizedBox(height: 32),
            const Text(
              "Beschikbare spellen:",
              style: TextStyle(color: Colors.white),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: availableGames.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      availableGames[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}