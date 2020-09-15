import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailPage extends StatelessWidget {
  final data;
  const DetailPage({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(data["name"])),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
            Center(
              child: Container(
                width: 100,
                height: 100,
                child: CircleAvatar(
                  child: SvgPicture.network(
                    data["logo_url"],
                    placeholderBuilder: (BuildContext context) =>
                        Container(child: const CircularProgressIndicator()),
                  ),
                ),
              ),
            ),
            Divider(),
            Center(child: Container(child: Text(data["name"],
            style: TextStyle(fontSize: 20.0),
            )))
          ]),
        ),
      ),
    );
  }
}
