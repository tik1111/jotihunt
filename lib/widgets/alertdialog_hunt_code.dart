import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jotihunt/handlers/handler_locations.dart';
import 'package:latlong2/latlong.dart';

class HuntCodeAlertDialogWidget extends StatelessWidget {
  final LatLng point;
  BuildContext context;
  HuntCodeAlertDialogWidget({
    required this.point,
    required this.context,
    super.key,
    required GlobalKey<FormState> formKeyAlertDialog,
  }) : _formKeyAlertDialog = formKeyAlertDialog;

  final GlobalKey<FormState> _formKeyAlertDialog;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: StatefulBuilder(
        builder: ((context, setState) {
          return Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Form(
                key: _formKeyAlertDialog,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(hintText: "Huntcode"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: const Text("Submit"),
                        onPressed: () {
                          LocationHandler().addHuntOrSpot(point, "hunt");
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
