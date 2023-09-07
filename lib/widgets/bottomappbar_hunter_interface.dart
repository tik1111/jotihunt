import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DefaultBottomAppBar extends StatelessWidget {
  const DefaultBottomAppBar({super.key});

  final Color appBarCollor = const Color.fromARGB(255, 66, 68, 91);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: appBarCollor,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            color: Colors.grey,
            icon: const Icon(Icons.navigation),
            onPressed: () {
              context.go('/map');
            },
          ),
          //IconButton(
          // color: Colors.grey,
          //icon: const Icon(Icons.person_2_outlined),
          //onPressed: () {
          // context.go('/profile');
          //},
          //),
          IconButton(
            color: Colors.grey,
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.go('/settings');
            },
          )
        ],
      ),
    );
  }
}
