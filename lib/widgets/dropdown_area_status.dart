import 'package:flutter/material.dart';
import 'package:jotihunt/cubit/area_status_update_cubit.dart';
import 'package:jotihunt/handlers/handler_area_status.dart';

/// Flutter code sample for [DropdownMenu].

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
    return const DropdownMenuAreaStatus();
  }
}

class DropdownMenuAreaStatus extends StatefulWidget {
  const DropdownMenuAreaStatus({super.key});

  @override
  State<DropdownMenuAreaStatus> createState() => _DropdownMenuAreaStatusState();
}

class _DropdownMenuAreaStatusState extends State<DropdownMenuAreaStatus>
    implements AreaStatusUpdateObserver {
  String dropdownValue = list.first;
  List<DropdownMenuEntry<String>> dropdownitems = [];
  String initialarea = "Aplha";
  Color currentIconColor = Colors.red;
  Future<List<DropdownMenuEntry<String>>> loadGroupMarkers() async {
    return AreaStatusHandler().getAllAreaStatus();
  }

  @override
  void initState() {
    super.initState();
    loadGroupMarkers().then((value) {
      dropdownitems = [];

      setState(() {
        switch (value.first.value) {
          case 'red':
            currentIconColor = Colors.red;
            break;
          case 'orange':
            currentIconColor = Colors.orange;
            break;
          case 'green':
            currentIconColor = Colors.green;
            break;
          default:
            currentIconColor = Colors.red;
            break;
        }
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
          Icons.circle,
          color: currentIconColor,
        ),
        onSelected: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            switch (value) {
              case 'red':
                currentIconColor = Colors.red;
                break;
              case 'orange':
                currentIconColor = Colors.orange;
                break;
              case 'green':
                currentIconColor = Colors.green;
                break;
              default:
            }
            dropdownValue = value!;
          });
        },
        dropdownMenuEntries: dropdownitems,
      ),
    );
  }

  @override
  void updateState(bool shouldUpdate) {}
}
