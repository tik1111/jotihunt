import 'package:flutter/material.dart';
import 'package:jotihunt/handlers/handler_user.dart';

class SettingsHuntersScreen extends StatefulWidget {
  const SettingsHuntersScreen({super.key});

  @override
  State<SettingsHuntersScreen> createState() => _SettingsHuntersScreenState();
}

class _SettingsHuntersScreenState extends State<SettingsHuntersScreen> {
  final Color backgroundColor = const Color.fromARGB(255, 33, 34, 45);
  final Future allUsersFuture = HandlerUser().getAllTenantUsers();
  List menuItems = [];

  Future<List<ListTile>> getAllUsers() async {
    return await HandlerUser().getAllTenantUsers();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAllUsers().then((value) {
      setState(() {
        menuItems = value;
      });
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
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
              future: allUsersFuture,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: menuItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return menuItems[index];
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error loading data'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.orange),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
