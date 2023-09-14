import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jotihunt/Cubit/login_cubit.dart';
import 'package:jotihunt/handlers/auth/handler_auth.dart';
import 'package:jotihunt/handlers/handler_game.dart';
import 'package:jotihunt/handlers/handler_secure_storage.dart';
import 'package:jotihunt/widgets/bottomappbar_hunter_interface.dart';

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
          if (mounted) {
            setState(() {
              gameID = value!;
            });
          }
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
          leading: const Icon(Icons.question_mark),
          title: const Text('Hint toevoegen'),
          onTap: () {
            context.push('/addhint');
          }),
      ListTile(
        enabled: true,
        leading: const Icon(Icons.settings),
        title: const Text('Mijn instellingen'),
        onTap: () {
          context.push('/userSettings');
        },
      ),
      ListTile(
        enabled: true,
        leading: const Icon(Icons.playlist_add),
        title: const Text('Game editor'),
        onTap: () {
          context.push('/gameEditor');
        },
      ),
      ListTile(
        enabled: true,
        leading: const Icon(Icons.logout),
        title: const Text('Uitloggen'),
        onTap: () async {
          if (mounted) {
            Future<bool> loginState = Auth().logout();
            if (await loginState) {
              // ignore: use_build_context_synchronously
              context.read<LoginCubit>().logout();
            }
          }
        },
      ),
    ];

    return Scaffold(
      //bottomNavigationBar: const Navigator(),
      backgroundColor: backgroundColor,
      bottomNavigationBar: const DefaultBottomAppBar(),
      body: ListView(children: [
        Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                  decoration: BoxDecoration(
                      color: orangeColor,
                      border: Border.all(color: orangeColor),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  height: 100,
                  width: MediaQuery.of(context).size.width - 40,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 35,
                              child: ClipOval(
                                  child: Image.network(
                                      'https://i.imgur.com/8qcWcvM.png')),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Naam:'),
                            Text('Hunter code:'),
                            Text('Team:'),
                          ],
                        ),
                      ),
                      const Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('{name}'),
                          Text('{hunt_code}'),
                          Text("{team_name}"),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              decoration: BoxDecoration(
                  color: orangeColor,
                  border: Border.all(color: orangeColor),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              height: MediaQuery.of(context).size.height / 2,
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
