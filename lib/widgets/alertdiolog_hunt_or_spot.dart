import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:jotihunt/handlers/handler_locations.dart';

class HuntOrSpotAlertDialog extends StatefulWidget {
  final LatLng point;
  final GlobalKey<FormState> _formKeyHuntOrSpot;

  const HuntOrSpotAlertDialog({
    required this.point,
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKeyHuntOrSpot = formKey,
        super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HuntOrSpotAlertDialogState createState() => _HuntOrSpotAlertDialogState();
}

class _HuntOrSpotAlertDialogState extends State<HuntOrSpotAlertDialog> {
  TextEditingController textController = TextEditingController();
  String? validationMessage;
  Duration selectedDuration = const Duration(hours: 0, minutes: 0);

  void validateAndSubmit() {
    if (textController.text.isEmpty) {
      setState(() {
        validationMessage = 'Vul de hunt code in';
      });
    } else {
      Navigator.of(context).pop();
      LocationHandler().addHuntOrSpot(widget.point, "hunt", DateTime.now(), "");
    }
  }

  void _showTimerPicker(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
    ).then((pickedTime) {
      if (pickedTime != null) {
        setState(() {
          selectedDuration =
              Duration(hours: pickedTime.hour, minutes: pickedTime.minute);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: widget._formKeyHuntOrSpot,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: const Text("Spot"),
              onPressed: () {
                LocationHandler()
                    .addHuntOrSpot(widget.point, "spot", DateTime.now(), "");
                Navigator.of(context).pop();
              },
            ),
            const Padding(padding: EdgeInsets.only(top: 8.0)),
            const Divider(
              height: 20,
              thickness: 1,
              color: Colors.black,
            ),
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                hintText: 'Voer huntcode in',
              ),
            ),
            if (validationMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  validationMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _showTimerPicker(context),
                    child: Text(
                        "Tijd: ${selectedDuration.inHours}:${selectedDuration.inMinutes % 60}"),
                  ),
                  ElevatedButton(
                    onPressed: validateAndSubmit,
                    child: const Text("Hunt"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
