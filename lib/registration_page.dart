import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:midas_app/landing_page.dart';

class RegistrationPage extends StatefulWidget {
  Function callback;

  RegistrationPage({super.key, required this.callback});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
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
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: const Text(
                  'New Patient Enrolment',
                  style: TextStyle(
                      fontSize: 25, color: Color.fromRGBO(50, 122, 184, 1)),
                )),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Date of Birth',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Sex',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contact Number',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Address',
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(50, 122, 184, 1)),
                  child: const Text('Enroll'),
                  onPressed: () {
                    Fluttertoast.showToast(
                        msg: 'Enrolled Successfully, Please login!',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 10,
                        backgroundColor: Colors.green,
                        textColor: Colors.white);
                    widget.callback(LandingPage(callback: widget.callback));
                  },
                )),
            SizedBox(height: 10.0),
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
    ;
  }
}
