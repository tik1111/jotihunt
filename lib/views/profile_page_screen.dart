import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jotihunt/handlers/auth/handler_auth.dart';
import 'package:jotihunt/cubitAndStream/login_cubit.dart';
import 'package:jotihunt/widgets/bottomappbar_hunter_interface.dart';

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
      bottomNavigationBar: const DefaultBottomAppBar(),
      body: ListView(children: [
        Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                  decoration: BoxDecoration(
                      color: orangeColor,
                      border: Border.all(color: orangeColor),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
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
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Naam:'),
                            Text('Hunter code:'),
                            Text('Team:'),
                          ],
                        ),
                      ),
                      const Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                              style: TextStyle(
                                  fontSize: 40, color: backgroundColor),
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
                              style: TextStyle(
                                  fontSize: 40, color: backgroundColor),
                            )
                          ],
                        ),
                      ],
                    ))
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              decoration: BoxDecoration(
                  color: orangeColor,
                  border: Border.all(color: orangeColor),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              height: 100,
              width: MediaQuery.of(context).size.width - 40,
              child: TextButton(
                  onPressed: () async {
                    Future<bool> loginState = Auth().logout();
                    if (await loginState) {
                      // ignore: use_build_context_synchronously
                      context.read<LoginCubit>().logout();
                    }
                  },
                  child: const Icon(Icons.logout)),
            ),
            Row(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: orangeColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(40))),
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width - 40,
                    child: Container()),
              ),
            ]),
          ],
        ),
      ]),
    );
  }
}
