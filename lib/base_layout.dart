import 'package:flutter/material.dart';
import 'package:midas_app/landing_page.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  LandingPage? landingPage;

  Widget? currentPage;

  @override
  void initState() {
    super.initState();
    landingPage = LandingPage(callback: callback);

    currentPage = landingPage;
  }

  void callback(Widget nextPage) {
    setState(() {
      currentPage = nextPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double overflowWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 15.0,
                  width: overflowWidth,
                  color: const Color.fromRGBO(226, 28, 33, 1),
                ),
                Image.asset(
                  'assets/images/midas_logo.png',
                  fit: BoxFit.contain,
                  height: 45,
                  //width: overflowWidth,
                )
              ],
            )),
        extendBodyBehindAppBar: true,
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/midas_background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: currentPage));
  }
}
