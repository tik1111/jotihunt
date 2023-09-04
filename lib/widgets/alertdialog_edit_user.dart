import 'package:flutter/material.dart';
import 'package:jotihunt/handlers/handler_user.dart';

class AlertdialogEditUser extends StatefulWidget {
  final Map<String, String> userData;

  const AlertdialogEditUser({super.key, required this.userData});

  @override
  // ignore: library_private_types_in_public_api
  _AlertdialogEditUserState createState() => _AlertdialogEditUserState();
}

class _AlertdialogEditUserState extends State<AlertdialogEditUser> {
  final Color orangeColor = const Color.fromARGB(255, 230, 144, 35);
  final Color whiteColor = const Color.fromARGB(255, 217, 217, 219);
  final Color backgroundColor = const Color.fromARGB(255, 33, 34, 45);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.userData['name']!;
    _emailController.text = widget.userData['email']!;
    _roleController.text = widget.userData['role']!;
  }

  void _showEditDialog() {
    String userId = widget.userData['id'] ?? "";
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Gebruiker'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Naam'),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _roleController,
                decoration: const InputDecoration(labelText: 'Rol'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close dialog
              },
              child: const Text('Annuleren'),
            ),
            TextButton(
              onPressed: () {
                // Save edited data
                _saveUserData(userId);
                Navigator.of(dialogContext).pop();
                // Close dialog
              },
              child: const Text('Opslaan'),
            ),
          ],
        );
      },
    );
  }

  void _saveUserData(String userId) async {
    await HandlerUser().updateUserById(userId, _nameController.text,
        _emailController.text, _roleController.text);

    // You can implement your logic to update the user data here
  }

  void _removeUser(String userId) async {
    await HandlerUser().deleteUserById(userId);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(orangeColor),
            textStyle:
                MaterialStateProperty.all(TextStyle(color: backgroundColor))),
        onPressed: _showEditDialog,
        child: const Text('Aanpassen'),
      ),
      IconButton(
          onPressed: () {
            _removeUser(widget.userData['id']!);
          },
          icon: const Icon(
            Icons.delete_forever,
            color: Colors.red,
          ))
    ]);
  }
}
