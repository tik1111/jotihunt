// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: () async {
                await GameHandler().createNewGame('gameName');
                context.pushReplacement('/gameEditor');
              },
              child: const Text("Aanmaken"),
            ),
            const SizedBox(height: 32),
            const Text(
              "Beschikbare spellen:",
              style: TextStyle(color: Colors.white),
            ),
            Expanded(
                child: FutureBuilder<List<ListTile>>(
              future: GameHandler().getAllActiveGameListTile(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                } else if (snapshot.hasError) {
                  return const Text("Er is een fout opgetreden");
                } else {
                  return ListView(
                    children: snapshot.data!,
                  );
                }
              },
            )),
          ],
        ),
      ),
    );
  }
}
