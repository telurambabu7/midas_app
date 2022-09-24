import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:midas_app/location_page.dart';
import 'package:midas_app/registration_page.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:midas_app/sos_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:collection/src/iterable_extensions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler/permission_handler.dart';

import 'location_page.dart';
import 'location_page.dart';
import 'login_page.dart';

Codec<String, String> stringToBase64 = utf8.fuse(base64);

class LandingPage extends StatefulWidget {
  Function callback;

  LandingPage({super.key, required this.callback});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class Student {
  String name;
  final String status;
  final int likes;
  String ph;
  bool selected;

  Student({
    required this.name,
    required this.status,
    required this.likes,
    required this.ph,
    this.selected = false,
  });
}

class _LandingPageState extends State<LandingPage> {
  final List<Student> entries = <Student>[
    // ignore: unnecessary_new
    Student(
        name: 'Physician1',
        status: 'Live',
        likes: 500,
        ph: '8179868671',
        selected: false),
    Student(
        name: 'Physician2',
        status: 'Live',
        likes: 435,
        ph: '7993969318',
        selected: true),
    Student(
        name: 'Physician3',
        status: 'offline',
        likes: 60,
        ph: '08179868671',
        selected: false),
  ];
  String? currentNumber;
  String? currentName;
  @override
  void initState() {
    super.initState();
    currentNumber = entries.firstWhereOrNull((element) => element.selected)?.ph;
    currentName = entries.firstWhereOrNull((element) => element.selected)?.name;
  }

  String? _currentAddress;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      //debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      //debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    _getCurrentPosition();
    return Column(children: [
      Padding(
          padding: const EdgeInsets.fromLTRB(10, 100, 10, 0),
          child: RichText(
            text: const TextSpan(
              text: 'Our Physicians\n',
              style: TextStyle(color: Colors.blue, fontSize: 20),
              /*defining default style is optional */
              children: <TextSpan>[
                TextSpan(
                  text:
                      'Providing you with the best doctors for the best care.',
                  style: TextStyle(
                      color: Color.fromRGBO(226, 28, 33, 1), fontSize: 16),
                ),
              ],
            ),
          )),
      ListView.builder(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: entries.length,
        itemBuilder: (context, position) {
          return Card(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                Column(children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 10, 10),
                      child: Text('\u{1F464} ${entries[position].name}')),
                  Row(children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 5, 5),
                        child: Text(entries[position].ph)),
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              var phNumberCtrl = TextEditingController();
                              return AlertDialog(
                                scrollable: true,
                                title: const Text('Edit Phone Number'),
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Form(
                                    child: Column(
                                      children: <Widget>[
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          maxLength: 11,
                                          controller: phNumberCtrl,
                                          decoration: const InputDecoration(
                                            labelText: 'Phone Number',
                                            icon: Icon(Icons.phone),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                      child: Text("Submit"),
                                      onPressed: () {
                                        entries[position].ph =
                                            phNumberCtrl.text;
                                        Navigator.pop(context);
                                      })
                                ],
                              );
                            });
                      },
                      color: Colors.greenAccent, //<-- SEE HERE
                      iconSize: 20,
                      icon: const Icon(
                        Icons.edit,
                      ),
                    )
                  ])
                ]),
                Column(children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                      child: Text("${entries[position].likes} Votes")),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: (!entries[position].selected)
                          ? ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromRGBO(50, 122, 184, 1))),
                              onPressed: () {
                                setState(() {
                                  for (var item in entries) {
                                    item.selected = false;
                                  }

                                  entries[position].selected = true;
                                  currentNumber = entries[position].ph;
                                  currentName = entries[position].name;
                                });
                              },
                              child: const Text('Choose As Primary'),
                            )
                          : const Text(
                              "Primary",
                              style: TextStyle(
                                  color: Color.fromRGBO(50, 122, 184, 1),
                                  fontWeight: FontWeight.bold),
                            ))
                ]),
              ]));
        },
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: ElevatedButton(
            onPressed: () async {
              Permission.sms.request();
              var messageStr =
                  "XXXXXX needs help at Address: $_currentAddress.\nClick the below link to see the location:\n http://maps.google.com/?q=${_currentPosition?.latitude ?? ""},${_currentPosition?.longitude ?? ""}\nClick the below link to join the video call with xxxxxx:\n https://meet.jit.si/${stringToBase64.encode(currentNumber!)}";
              String sendResult = await sendSMS(
                      message: messageStr,
                      recipients: ["$currentNumber"],
                      sendDirect: true)
                  .catchError((err) {
                //print(err);
              });

              //print(messageStr);
              widget.callback(SosPage(
                  callback: widget.callback,
                  vedioLink:
                      "https://meet.jit.si/${stringToBase64.encode(currentNumber!)}",
                  name: currentName!));
              Fluttertoast.showToast(
                  msg: '$sendResult Message sent to:$currentNumber',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 20,
                  backgroundColor: Colors.green,
                  textColor: Colors.white);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(60),
            ),
            child: const Text('SOS'),
          ))
    ]);
  }
}
