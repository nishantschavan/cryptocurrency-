import 'dart:convert' as convert;
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'detail_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'key.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var data;
  fetchData() async {
    var api ="https://api.nomics.com/v1/currencies/ticker?key="+key;
    var response = await http.get(api);
    data = convert.jsonDecode(response.body);
    setState(() {});
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final lightTheme =ThemeData.light();
    final darkTheme =ThemeData.dark();

    return ThemeSwitchingArea(
          child:Builder(builder: (context){
          return Scaffold(
        appBar: AppBar(
          title: Text("cryptocurrency viewer "),
        ),
        drawer: Drawer(
    child:SafeArea(
      child:Stack(
        children: <Widget>[
          Align(
            alignment:Alignment.topRight,
            child: ThemeSwitcher(
              builder:(context){
                return IconButton(
                  icon: Icon(Icons.brightness_2), 
                  onPressed: () {
                          ThemeSwitcher.of(context).changeTheme(
                            theme: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? darkTheme
                                : lightTheme,
                          );
                  }
                );
              } 
            ),
          ) ,
        ],
      )
    )
  ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
                child: data != null
                ?ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          title: Text(data[index]["name"]),
                          leading: SizedBox(
                            width: 30.0,
                            height: 30.0,
                            child: SvgPicture.network(
                              data[index]["logo_url"],
                              placeholderBuilder: (BuildContext context) =>
                                  Container(
                                      child: const CircularProgressIndicator()),
                            ),
                          ),
                          subtitle: getsubtitle(
                              data[index]["price"], data[index]["rank"],Theme.of(context).textSelectionColor),
                          isThreeLine: true,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPage(data:data[index]),
                                ));
                          });
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
      );},
    ));
  }
}

Widget getsubtitle(String pricetag, String pricePercent,Color iscolor) {
  TextSpan getpricetag =
      TextSpan(text: ("$pricetag"), style: TextStyle(color: iscolor));
  String percenttext = "$pricePercent %";
  TextSpan getpricePercent;
  if (double.parse(pricePercent) > 0) {
    getpricePercent =
        TextSpan(text: percenttext, style: TextStyle(color: Colors.green));
  } else {
    getpricePercent =
        TextSpan(text: percenttext, style: TextStyle(color: Colors.red));
  }
  return RichText(text: TextSpan(children: [getpricetag, getpricePercent]));
}
