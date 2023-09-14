import 'package:flutter/material.dart';
import 'package:jotihunt/handlers/handler_secure_storage.dart';

class SettingsPersonalScreen extends StatefulWidget {
  const SettingsPersonalScreen({super.key});

  @override
  State<SettingsPersonalScreen> createState() => _SettingsPersonalScreenState();
}

class _SettingsPersonalScreenState extends State<SettingsPersonalScreen> {
  final Color backgroundColor = const Color.fromARGB(255, 33, 34, 45);
  bool _isCheckedPIO = false;
  bool _isCheckedCircles = true;
  String _selectedDistance = '100';

  Future<bool> getCircleCheckboxValue() async {
    String? value = await SecureStorage().getUserPrefCircle();
    if (value == null || value == "true") {
      _isCheckedCircles = true;
    }
    if (value == "false") {
      _isCheckedCircles = false;
    }
    return _isCheckedCircles;
  }

  @override
  void initState() {
    // TODO: implement initState
    getCircleCheckboxValue().then((value) {
      if (mounted) {
        setState(() {
          _isCheckedCircles = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      backgroundColor: backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Checkbox voor POI
          ListTile(
            title: const Text('POI', style: TextStyle(color: Colors.white)),
            leading: Checkbox(
              value: _isCheckedPIO,
              onChanged: (bool? value) {
                setState(() {
                  _isCheckedPIO = value ?? false;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('500 M circles',
                style: TextStyle(color: Colors.white)),
            leading: Checkbox(
              value: _isCheckedCircles,
              onChanged: (bool? value) async {
                print(value);
                await SecureStorage().writeUserPrefCircle(value.toString());
                setState(() {
                  _isCheckedCircles = value ?? false;
                });
              },
            ),
          ),
          // Dropdown menu voor locatie frequentie
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Om de hoe veel meter mogen wij jouw locatie opvragen?',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButton<String>(
              value: _selectedDistance,
              items: <String>['100', '250', '500']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text('$value Meter'),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDistance = newValue ?? '100';
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
