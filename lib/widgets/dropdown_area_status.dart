import 'package:flutter/material.dart';
import 'package:jotihunt/cubitAndStream/stream_provider.dart';
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

class _DropdownMenuAreaStatusState extends State<DropdownMenuAreaStatus> {
  String dropdownValue = list.first;
  List<DropdownMenuEntry<String>> dropdownitems = [];
  String initialarea = "Aplha";
  Color currentIconColor = Colors.red;
  Future<List<DropdownMenuEntry<String>>> loadAreaStatus() async {
    return AreaStatusHandler().getAllAreaStatus();
  }

  @override
  void initState() {
    super.initState();
    loadAreaStatus().then((value) {
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
    areaStatusUpdateStream.getResponse.listen((event) {
      if (mounted) {
        setState(() {
          loadAreaStatus().then((value) {
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
        });
      }
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
                currentIconColor = Colors.red;
                break;
            }
            dropdownValue = value!;
          });
        },
        dropdownMenuEntries: dropdownitems,
      ),
    );
  }
}
