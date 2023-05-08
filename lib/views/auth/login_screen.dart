// ignore: file_names
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jotihunt/auth/auth.dart';
import 'package:jotihunt/cubit/login_cubit.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Color orangeCollor = const Color.fromARGB(255, 230, 144, 35);

  final Color backgroundCollor = const Color.fromARGB(255, 33, 34, 45);

  final Color whiteColor = const Color.fromARGB(255, 217, 217, 219);

  final double bannerHeight = 200;

  final _loginFormKey = GlobalKey<FormState>();

  final loginEmailFormController = TextEditingController();
  final loginPasswordFormController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Scaffold(
      backgroundColor: backgroundCollor,
      body: ListView(children: [
        Form(
          key: _loginFormKey,
          child: Column(children: [
            Row(
              children: [
                Stack(children: [
                  ClipPath(
                    clipper: CustomClipPath(),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: bannerHeight,
                      color: orangeCollor,
                    ),
                  ),
                  Column(children: [
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                    ),
                    SizedBox(
                      //color: Colors.red,
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: CircleAvatar(
                        radius: 2,
                        backgroundColor: whiteColor,
                        child: ClipOval(
                            child: Image.network(
                                'https://i.imgur.com/8qcWcvM.png')),
                      ),
                    )
                  ])
                ]),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 0, 30),
              child: Row(
                children: [
                  Text(
                    "Jotihunt login",
                    style: TextStyle(color: whiteColor, fontSize: 40),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vul iets in ...';
                        }
                        return null;
                      },
                      controller: loginEmailFormController,
                      cursorColor: const Color.fromARGB(255, 255, 179, 0),
                      style: TextStyle(color: orangeCollor),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: orangeCollor)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: orangeCollor)),
                        hintStyle: TextStyle(color: orangeCollor),
                        labelStyle: TextStyle(color: orangeCollor),
                        labelText: "Email",
                        suffixIcon: Icon(
                          Icons.email,
                          color: orangeCollor,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vul iets in ...';
                        }
                        return null;
                      },
                      controller: loginPasswordFormController,
                      cursorColor: orangeCollor,
                      style: TextStyle(color: whiteColor),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: whiteColor)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: whiteColor)),
                        hintStyle: TextStyle(color: whiteColor),
                        labelStyle: TextStyle(color: whiteColor),
                        labelText: "Wachtwoord",
                        suffixIcon: Icon(
                          Icons.key_sharp,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text("FORGOT PASSWORD?",
                        style: TextStyle(color: orangeCollor)),
                  ),
                )
              ],
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    context.go('/register');
                  },
                  child: Text("Register", style: TextStyle(color: whiteColor)),
                ),
                TextButton(
                  onPressed: () async {
                    if (_loginFormKey.currentState!.validate()) {
                      Future<bool> loginState = Auth()
                          .loginUserWithEmailAndPassword(
                              loginEmailFormController.text,
                              loginPasswordFormController.text);
                      if (await loginState) {
                        // ignore: use_build_context_synchronously
                        context.read<LoginCubit>().login();
                      }
                    }
                  },
                  child: Text("Log in", style: TextStyle(color: orangeCollor)),
                )
              ],
            ),
          ]),
        ),
      ]),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 5.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
