import 'package:flutter/material.dart';
import 'package:midas_app/landing_page.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  Function callback;

  LoginPage({super.key, required this.callback});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10, 100, 10, 10),
                child: const Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 25, color: Color.fromRGBO(50, 122, 184, 1)),
                )),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                style: TextStyle(color: Color.fromRGBO(50, 122, 184, 1)),
                'Forgot Password',
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(50, 122, 184, 1)),
                  child: const Text('Login'),
                  onPressed: () {
                    widget.callback(HomePage(callback: widget.callback));
                  },
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Go Back',
                    style: TextStyle(
                        fontSize: 20, color: Color.fromRGBO(50, 122, 184, 1)),
                  ),
                  onPressed: () {
                    widget.callback(LandingPage(callback: widget.callback));
                  },
                )
              ],
            ),
          ],
        ));
  }
}
