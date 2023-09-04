import 'package:flutter/material.dart';
import 'package:jotihunt/handlers/handler_game.dart';
import 'package:jotihunt/handlers/handler_secure_storage.dart';

const List<String> list = <String>[
  'Alpha',
  'Bravo',
  'Charlie',
  'Delta',
  'Echo',
  'Foxtrot'
];

class DropdownMenuApp extends StatelessWidget {
  const DropdownMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const DropdownMenuCurrentGame();
  }
}

class DropdownMenuCurrentGame extends StatefulWidget {
  const DropdownMenuCurrentGame({super.key});

  @override
  State<DropdownMenuCurrentGame> createState() =>
      _DropdownMenuCurrentGameState();
}

class _DropdownMenuCurrentGameState extends State<DropdownMenuCurrentGame> {
  String dropdownValue = list.first;
  List<DropdownMenuEntry<String>> dropdownitems = [];
  String initialarea = "Aplha";
  Color currentIconColor = Colors.red;

  Future<List<DropdownMenuEntry<String>>> loadGames() async {
    return GameHandler().getAllActiveGameInDropdownMenuEntry();
  }

  @override
  void initState() {
    super.initState();
    loadGames().then((value) {
      dropdownitems = [];

      setState(() {
        dropdownitems = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white70),
      child: DropdownMenu<String>(
        menuStyle: const MenuStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.white)),
        initialSelection:
            dropdownitems.isNotEmpty ? dropdownitems.first.value : null,
        trailingIcon: Icon(
          Icons.games,
          color: currentIconColor,
        ),
        onSelected: (String? value) async {
          // This is called when the user selects an item.
          await SecureStorage().writeCurrentGame(value!);
          setState(() {
            dropdownValue = value;
          });
        },
        dropdownMenuEntries: dropdownitems,
      ),
    );
  }
}
