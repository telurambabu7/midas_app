import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:midas_app/landing_page.dart';
import 'package:midas_app/sos_page.dart';

class HomePage extends StatefulWidget {
  Function callback;

  HomePage({super.key, required this.callback});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 150, 30, 0),
          child: RichText(
            text: const TextSpan(
              text: '',
              style:
                  TextStyle(color: Color.fromRGBO(96, 94, 94, 1), fontSize: 30),
              /*defining default style is optional */
              children: <TextSpan>[
                TextSpan(text: 'Welcome to'),
                TextSpan(
                    text: ' William',
                    style: TextStyle(color: Color.fromRGBO(50, 122, 184, 1)))
              ],
            ),
          )),
      Padding(
          padding: const EdgeInsets.fromLTRB(40, 30, 30, 0),
          child: RichText(
            text: const TextSpan(
              text: '',
              style:
                  TextStyle(color: Color.fromRGBO(96, 94, 94, 1), fontSize: 20),
              /*defining default style is optional */
              children: <TextSpan>[
                TextSpan(
                    text: 'Midas Tele-Family Physician offers appropriate'),
                TextSpan(
                    text:
                        ' health checks, health prevention, diagnosis, management',
                    style: TextStyle(color: Colors.red)),
                TextSpan(text: ' and rehabilitative services.'),
              ],
            ),
          )),
      Padding(
          padding: const EdgeInsets.fromLTRB(40, 60, 30, 0),
          child: ElevatedButton(
            onPressed: () {
              //widget.callback(SosPage(callback: widget.callback));
            },
            child: Text('SOS', style: TextStyle(fontSize: 20)),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              shape: CircleBorder(),
              padding: EdgeInsets.all(70),
            ),
          )),
      SizedBox(height: 80),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //const Text('Does not have account?'),
          TextButton(
            child: const Text(
              'Logout',
              style: TextStyle(
                  fontSize: 20, color: Color.fromRGBO(50, 122, 184, 1)),
            ),
            onPressed: () {
              Fluttertoast.showToast(
                  msg: 'You have been logged out!',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 10,
                  backgroundColor: Colors.green,
                  textColor: Colors.white);
              widget.callback(LandingPage(callback: widget.callback));
            },
          )
        ],
      ),
    ]);
  }
}
