import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'landing_page.dart';
// ignore: import_of_legacy_library_into_null_safe
//import 'package:google_maps_flutter/google_maps_flutter.dart';

class SosPage extends StatefulWidget {
  Function callback;
  final String vedioLink;
  final String name;

  SosPage(
      {super.key,
      required this.callback,
      required this.vedioLink,
      required this.name});

  @override
  State<SosPage> createState() => _SosPageState();
}

class _SosPageState extends State<SosPage> {
  // final Completer<GoogleMapController> _controller = Completer();

  // static const LatLng _center = LatLng(151.209900, -33.865143);
  // void _onMapCreated(GoogleMapController controller) {
  //   _controller.complete(controller);
  // }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 150, 30, 0),
          child: RichText(
            text: const TextSpan(
              text: '',
              style: TextStyle(
                  color: Color.fromRGBO(50, 122, 184, 1), fontSize: 20),
              /*defining default style is optional */
              children: <TextSpan>[
                TextSpan(text: 'Thank you for contacting us...'),
              ],
            ),
          )),
      Padding(
          padding: const EdgeInsets.fromLTRB(40, 50, 30, 0),
          child: RichText(
            text: const TextSpan(
              text: '',
              style: TextStyle(
                  color: Color.fromRGBO(50, 122, 184, 1), fontSize: 20),
              /*defining default style is optional */
              children: <TextSpan>[
                TextSpan(text: 'Sending confernce call / text message to'),
                TextSpan(
                    text: ' Near by Global Midas Tele-Family Physician',
                    style: TextStyle(color: Colors.red)),
                TextSpan(text: '...\n'),
              ],
            ),
          )),
      Text(
          'Click the below link to join the video call with ${widget.name}:\n'),
      InkWell(
        onTap: () => launchUrl(Uri.parse(widget.vedioLink)),
        child: Text(widget.vedioLink,
            style: const TextStyle(
                decoration: TextDecoration.underline, color: Colors.blue)),
      ),

      const SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //const Text('Does not have account?'),
          TextButton(
            child: const Text(
              'Go Back',
              style: TextStyle(
                  fontSize: 20, color: Color.fromRGBO(50, 150, 184, 1)),
            ),
            onPressed: () {
              widget.callback(LandingPage(callback: widget.callback));
            },
          )
        ],
      ),
      // Padding(
      //     padding: const EdgeInsets.fromLTRB(0, 30, 30, 0),
      //     child: GoogleMap(
      //       onMapCreated: _onMapCreated,
      //       initialCameraPosition: const CameraPosition(
      //         target: _center,
      //         zoom: 11.0,
      //       ),
      //     ))
    ]);
  }
}
