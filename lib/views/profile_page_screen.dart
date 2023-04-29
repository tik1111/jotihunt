import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Color backgroundColor = const Color.fromARGB(255, 33, 34, 45);
  final Color orangeColor = const Color.fromARGB(255, 230, 144, 35);
  final Color whiteColor = const Color.fromARGB(255, 217, 217, 219);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: const Navigator(),
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                decoration: BoxDecoration(
                    color: orangeColor,
                    border: Border.all(color: orangeColor),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                height: 100,
                width: MediaQuery.of(context).size.width - 40,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            child: ClipOval(
                                child: Image.network(
                                    'https://i.imgur.com/8qcWcvM.png')),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text('Naam:'),
                          Text('Hunter code:'),
                          Text('Team:'),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Tim'),
                        Text('Zgr23'),
                        Text("Test team"),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                  decoration: BoxDecoration(
                      color: orangeColor,
                      border: Border.all(color: orangeColor),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  height: 100,
                  width: MediaQuery.of(context).size.width / 3 - 20,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Icon(
                              Icons.album_outlined,
                              color: backgroundColor,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "5",
                            style:
                                TextStyle(fontSize: 40, color: backgroundColor),
                          )
                        ],
                      )
                    ],
                  )),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 0, 10),
                decoration: BoxDecoration(
                    color: orangeColor,
                    border: Border.all(color: orangeColor),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                height: 100,
                width: MediaQuery.of(context).size.width / 3 - 20, //50
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: Icon(
                            Icons.timer,
                            color: backgroundColor,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "20:49",
                          style:
                              TextStyle(fontSize: 30, color: backgroundColor),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(10, 20, 0, 10),
                  decoration: BoxDecoration(
                      color: orangeColor,
                      border: Border.all(color: orangeColor),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  height: 100,
                  width: MediaQuery.of(context).size.width / 3 - 20, //50
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Icon(
                              Icons.group,
                              color: backgroundColor,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "4",
                            style:
                                TextStyle(fontSize: 40, color: backgroundColor),
                          )
                        ],
                      ),
                    ],
                  ))
            ],
          ),
          Row(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: orangeColor),
                    borderRadius: const BorderRadius.all(Radius.circular(40))),
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width - 40,
                child: FlutterMap(
                  mapController: MapController(),
                  options: MapOptions(
                    zoom: 9.2,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                  ],
                ),
              ),
            ),
          ])
        ],
      ),
    );
  }
}
