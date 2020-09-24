import 'dart:async';

import 'package:crytocurrency/homePage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(decoration: BoxDecoration(color: Colors.redAccent)),
        Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              CircleAvatar(
                  radius: 50.0,
                  child: Icon(
                    Icons.monetization_on,
                    size: 50.0,
                  ),
                  backgroundColor: Colors.white),
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Crypto",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ))
            ]))
      ],
    ));
  }
}
