import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';
import 'package:jotihunt/handlers/handler_locations.dart';

class HuntOrSpotAlertDialog extends StatefulWidget {
  final LatLng point;
  final GlobalKey<FormState> _formKeyHuntOrSpot;

  const HuntOrSpotAlertDialog(
      {required this.point, super.key, required GlobalKey<FormState> formKey})
      : _formKeyHuntOrSpot = formKey;

  @override
  _HuntOrSpotAlertDialogState createState() => _HuntOrSpotAlertDialogState();
}

class _HuntOrSpotAlertDialogState extends State<HuntOrSpotAlertDialog> {
  bool showTextField = false;
  TextEditingController textController = TextEditingController();
  String? validationMessage;

  void validateAndSubmit() {
    if (textController.text.isEmpty) {
      setState(() {
        validationMessage = 'Vul de hunt code in';
      });
    } else {
      Navigator.of(context).pop();
      LocationHandler().addHuntOrSpot(widget.point, "hunt");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: Form(
        key: widget._formKeyHuntOrSpot,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CupertinoButton(
              child: const Text("Spot"),
              onPressed: () {
                LocationHandler().addHuntOrSpot(widget.point, "spot");
                Navigator.of(context).pop();
              },
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 20.0),
              height: 1,
              color: CupertinoColors.systemGrey,
            ),
            Container(
              height: 20,
            ),
            CupertinoTextField(
              controller: textController,
              placeholder: 'Voer huntcode in',
            ),
            if (validationMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  validationMessage!,
                  style: const TextStyle(color: CupertinoColors.destructiveRed),
                ),
              ),
            CupertinoButton(
              onPressed: validateAndSubmit,
              child: const Text("Hunt"),
            ),
          ],
        ),
      ),
    );
  }
}
