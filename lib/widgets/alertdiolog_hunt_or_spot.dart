import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jotihunt/handlers/handler_locations.dart';
import 'package:latlong2/latlong.dart';

class HuntOrSpotAlertDialog extends StatefulWidget {
  final LatLng point;
  final GlobalKey<FormState> _formKeyHuntOrSpot;

  const HuntOrSpotAlertDialog(
      {required this.point, super.key, required GlobalKey<FormState> formKey})
      : _formKeyHuntOrSpot = formKey;

  @override
  // ignore: library_private_types_in_public_api
  _HuntOrSpotAlertDialogState createState() => _HuntOrSpotAlertDialogState();
}

class _HuntOrSpotAlertDialogState extends State<HuntOrSpotAlertDialog> {
  bool showTextField = false;
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Form(
            key: widget._formKeyHuntOrSpot,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text("Hunt"),
                    onPressed: () {
                      if (widget._formKeyHuntOrSpot.currentState!.validate()) {
                        Navigator.of(context).pop();
                        LocationHandler().addHuntOrSpot(widget.point, "hunt");
                      }
                    },
                  ),
                ),
                if (showTextField)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: textController,
                      decoration:
                          const InputDecoration(labelText: 'Voer huntcode in'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a hunt code';
                        }
                        return null;
                      },
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text("Spot"),
                    onPressed: () {
                      LocationHandler().addHuntOrSpot(widget.point, "spot");
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                if (showTextField)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: const Text("Submit"),
                      onPressed: () {
                        // Voer actie uit met de tekst uit het tekstveld
                        Navigator.of(context).pop();
                        LocationHandler().addHuntOrSpot(widget.point, "hunt");
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
