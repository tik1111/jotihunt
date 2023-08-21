import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jotihunt/handlers/handler_locations.dart';
import 'package:jotihunt/widgets/alertdialog_hunt_code.dart';
import 'package:latlong2/latlong.dart';

class HuntOrSpotAlertDialog extends StatelessWidget {
  final LatLng point;
  const HuntOrSpotAlertDialog(
      {required this.point, super.key, required GlobalKey<FormState> formKey})
      : _formKeyHuntOrSpot = formKey;

  final GlobalKey<FormState> _formKeyHuntOrSpot;
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Form(
            key: _formKeyHuntOrSpot,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text("Hunt"),
                    onPressed: () {
                      Navigator.of(context).pop();

                      HuntCodeAlertDialogWidget(
                        point: point,
                        formKey: _formKeyHuntOrSpot,
                        context: context,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text("Spot"),
                    onPressed: () {
                      LocationHandler().addHuntOrSpot(point, "spot");
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
