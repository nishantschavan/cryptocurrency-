import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailPage extends StatelessWidget {
  final data;
  const DetailPage({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(data["name"]),
        ),
        body: Container(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: <Widget>[
            Center(
              child: Container(
                width: 100,
                height: 100,
                child: Hero(
                  tag: data["name"],
                  child: CircleAvatar(
                    child: SvgPicture.network(
                      data["logo_url"],
                      placeholderBuilder: (BuildContext context) =>
                          Container(child: const CircularProgressIndicator()),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              child: Center(
                child: Text(
                  data["name"],
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            Card(
                elevation: 10.0,
                child: Column(children: 
                <Widget>[
                  Row(children: [
                    detail("Price", "price"),
                    detail("Rank", "rank"),
                  ]),
                  Row(children: [
                    detail("Price date", "price_date"),
                    detail("Max supply", "max_supply"),
                  ]),
                  Row(children: [
                    detail("Num Exchanges", "num_exchanges"),
                    detail("Num pairs", "num_pairs"),
                  ])
                ]))
          ]),
        )));
  }

  Widget detail(String title, String rdata) {
    return Expanded(
      child: ListTile(
        title: Text(title),
        subtitle: Text(data[rdata]),
      ),
    );
  }
}
