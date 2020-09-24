import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Setting")
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title:Text("Version"),
            subtitle:Text("1.0.0")
          )
        ],
      ),
    );
  }
}