import 'package:flutter/material.dart';
import 'package:jotihunt/handlers/handler_game.dart';
import 'package:jotihunt/handlers/handler_secure_storage.dart';
import 'package:jotihunt/widgets/bottomappbar_hunter_interface.dart';
import 'package:jotihunt/widgets/dropdown_area_status.dart';
import 'package:jotihunt/widgets/dropdown_game.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<SettingsPage> {
  final Color backgroundColor = const Color.fromARGB(255, 33, 34, 45);
  final Color orangeColor = const Color.fromARGB(255, 230, 144, 35);
  final Color whiteColor = const Color.fromARGB(255, 217, 217, 219);

  List dropdownMenuEntries = [];
  String GameID = "";

  Future<List<DropdownMenuEntry<String>>> getAllDropDownMenu() async {
    return GameHandler().getAllActiveGameInDropdownMenuEntry();
  }

  Future<String?> getSecureStorage() async {
    return await SecureStorage().getCurrentSelectedGame();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAllDropDownMenu().then((value) {
      dropdownMenuEntries = value;
    });

    getSecureStorage().then((value) {
      setState(() {
        GameID = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  const Text("Kies actieve Game"),
                  const DropdownMenuCurrentGame(),
                  Text(GameID)
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
