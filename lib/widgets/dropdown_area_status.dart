// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jotihunt/Cubit/fox_timer_cubit.dart';
import 'package:jotihunt/Cubit/stream_provider.dart';
import 'package:jotihunt/handlers/handler_area_status.dart';
import 'package:jotihunt/handlers/handler_locations.dart';
import 'package:jotihunt/handlers/handler_secure_storage.dart';

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
  List<DropdownMenuEntry<String>> dropdownitems = [];

  String initialarea = "";
  Color currentIconColor = Colors.red;

  Future<List<DropdownMenuEntry<String>>> loadAreaStatus() async {
    Future<List<DropdownMenuEntry<String>>> allAreaStatus =
        AreaStatusHandler().getAllAreaStatusDropDownMenuEntry();
    return allAreaStatus;
  }

  Future<String> getLastKnownSelectedArea() async {
    String getCurrentSelectedArea =
        await SecureStorage().getCurrentSelectedArea() ?? "Alpha";

    if (getCurrentSelectedArea != "Alpha") {
      initialarea = getCurrentSelectedArea;
    } else {
      await SecureStorage().writeCurrentArea("Alpha");
    }
    return getCurrentSelectedArea.toString();
  }

  void updateIconBasedOnAreaStatus(String area) async {
    var areaStatus = await AreaStatusHandler().getAllAreaStatusString();
    for (var element in areaStatus) {
      if (element['name'] == area) {
        setState(() {
          switch (element['status']) {
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
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadAreaStatus().then((value) {
      setState(() {
        dropdownitems = value;
      });
    });

    getLastKnownSelectedArea().then((value) {
      setState(() {
        initialarea = value;
      });

      updateIconBasedOnAreaStatus(value);
    });

    areaStatusUpdateStream.getResponse.listen((event) {
      if (mounted) {
        loadAreaStatus().then((value) {
          setState(() {
            dropdownitems = value;
            updateIconBasedOnAreaStatus(event);
          });
        });

        getLastKnownSelectedArea().then((value) {
          setState(() {
            initialarea = value;
          });

          updateIconBasedOnAreaStatus(value);
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
        initialSelection: dropdownitems.isNotEmpty ? initialarea : null,
        trailingIcon: Icon(
          Icons.circle,
          color: currentIconColor,
        ),
        onSelected: (String? value) async {
          await SecureStorage().writeCurrentArea(value.toString());

          DateTime currentAreaHuntTime = await LocationHandler()
              .getLastLocationByAreaToCreatedAt(
                  await SecureStorage().getCurrentSelectedArea() ?? "Alpha");
          if (currentAreaHuntTime == DateTime.now()) {
            context.read<HuntTimeCubit>().updateHuntTime(
                DateTime.parse("2023-09-04T12:14:07.649+00:00"));
          } else {
            context.read<HuntTimeCubit>().updateHuntTime(currentAreaHuntTime);
          }

          updateIconBasedOnAreaStatus(value.toString());
        },
        dropdownMenuEntries: dropdownitems,
      ),
    );
  }
}
