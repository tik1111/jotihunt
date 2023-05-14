import 'package:flutter/material.dart';

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
            icon: const Icon(Icons.map_outlined),
            onPressed: () {},
          ),
          IconButton(
            color: Colors.grey,
            icon: const Icon(Icons.person_2_outlined),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
