import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jotihunt/handlers/handler_game.dart';
import 'package:jotihunt/handlers/handler_secure_storage.dart';
import 'package:jotihunt/widgets/bottomappbar_hunter_interface.dart';

import 'package:jotihunt/widgets/dropdown_game.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<SettingsPage> {
  final Color backgroundColor = const Color.fromARGB(255, 33, 34, 45);
  final Color orangeColor = const Color.fromARGB(255, 230, 144, 35);
  final Color whiteColor = const Color.fromARGB(255, 217, 217, 219);

  List dropdownMenuEntries = [];

  String gameID = "";
  bool isGameAvailable = false;

  Future<List<DropdownMenuEntry<String>>> getAllDropDownMenu() async {
    List<DropdownMenuEntry<String>> allGames =
        await GameHandler().getAllActiveGameInDropdownMenuEntry();

    if (allGames != []) {
      isGameAvailable == true;
    }
    return allGames;
  }

  Future<String?> getSecureStorage() async {
    return await SecureStorage().getCurrentSelectedGame();
  }

  @override
  void initState() {
    super.initState();

    getAllDropDownMenu().then((value) {
      if (isGameAvailable) {
        dropdownMenuEntries = value;
        getSecureStorage().then((value) {
          setState(() {
            gameID = value!;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<ListTile> menuItems = [
      ListTile(
          enabled: true,
          leading: const Icon(Icons.person),
          title: const Text('Hunters'),
          onTap: () {
            context.push('/hunters');
          }),
      ListTile(
          enabled: false,
          leading: const Icon(Icons.people),
          title: const Text('Teams'),
          onTap: () {
            context.push('/teams');
          }),
      ListTile(
          enabled: false,
          leading: const Icon(Icons.format_list_numbered),
          title: const Text('Huntcodes'),
          onTap: () {
            context.push('/huntcode');
          }),
      ListTile(
          enabled: false,
          leading: const Icon(Icons.question_mark_outlined),
          title: const Text('Hint toevoegen'),
          onTap: () {
            context.push('/addhint');
          }),
    ];

    return Scaffold(
      //bottomNavigationBar: const Navigator(),
      backgroundColor: backgroundColor,
      bottomNavigationBar: const DefaultBottomAppBar(),
      body: ListView(children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              decoration: BoxDecoration(
                  color: orangeColor,
                  border: Border.all(color: orangeColor),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              height: 100,
              width: MediaQuery.of(context).size.width - 40,
              child: Row(
                children: [
                  const Text("Kies actieve Game "),
                  const DropdownMenuCurrentGame(),
                  Text(gameID)
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              decoration: BoxDecoration(
                  color: orangeColor,
                  border: Border.all(color: orangeColor),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width - 40,
              child: ListView.builder(
                  itemCount: menuItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return menuItems[index];
                  }),
            ),
          ],
        ),
      ]),
    );
  }
}
