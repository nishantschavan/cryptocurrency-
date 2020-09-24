import 'dart:async';
import 'dart:convert' as convert;
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:crytocurrency/setting.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
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
  bool isSearching = false;
  var data;
  List filterdata = [];

  StreamSubscription<DataConnectionStatus> listener;
  DataConnectionStatus status;

  fetchData() async {
    DataConnectionStatus status= await checkdata();
    if(status==DataConnectionStatus.connected){
    var api = "https://api.nomics.com/v1/currencies/ticker?key=" + key;
    var response = await http.get(api);
    data = convert.jsonDecode(response.body);
    setState(() {
      filterdata = data;
    });
    }else{
      showDialog(context: context,
      builder:(context)=>AlertDialog(
        title:Text("Not Connected"),
        content: Text("Check your internet"),
      )
      );
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  void filteredlist() {
    setState(() {
      filterdata = data.where((datas) => datas["name"] == 'Bitcoin').toList();
    });
  }

  checkdata() async {
    // Simple check to see if we have internet
    print("The statement 'this machine is connected to the Internet' is: ");
    print(await DataConnectionChecker().hasConnection);
    // returns a bool

    // We can also get an enum value instead of a bool
    print("Current status: ${await DataConnectionChecker().connectionStatus}");
    // prints either DataConnectionStatus.connected
    // or DataConnectionStatus.disconnected

    // This returns the last results from the last call
    // to either hasConnection or connectionStatus
    print("Last results: ${DataConnectionChecker().lastTryResults}");

    // actively listen for status updates
    // this will cause DataConnectionChecker to check periodically
    // with the interval specified in DataConnectionChecker().checkInterval
    // until listener.cancel() is called
    var listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          print('Data connection is available.');
          break;
        case DataConnectionStatus.disconnected:
          print('You are disconnected from the internet.');
          break;
      }
    });

    // close listener after 30 seconds, so the program doesn't run forever
    return await DataConnectionChecker().connectionStatus;
  }

  @override
  Widget build(BuildContext context) {
    final lightTheme = ThemeData.light();
    final darkTheme = ThemeData.dark();

    return ThemeSwitchingArea(child: Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: isSearching == false
                ? Text("cryptocurrency viewer")
                : TextField(decoration: InputDecoration(hintText: "Search")),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    isSearching = !isSearching;
                  });
                },
              )
            ],
          ),
          drawer: Drawer(
              child: SafeArea(
                  child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                      accountName: Text("Made by Nishant"),
                      accountEmail: Text("nishantscg@gmail.com")),
                  Align(
                    alignment: Alignment.topRight,
                    child: ThemeSwitcher(builder: (context) {
                      return IconButton(
                          icon: Icon(Icons.brightness_2),
                          onPressed: () {
                            ThemeSwitcher.of(context).changeTheme(
                              theme: ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                  ? darkTheme
                                  : lightTheme,
                            );
                          });
                    }),
                  ),
                ],
              ),
              ListTile(
                title: Text("Setting"),
                trailing: Icon(Icons.settings),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingPage())),
              )
            ],
          ))),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: data != null
                ? ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          title: Text(
                            data[index]["name"],
                            style: TextStyle(fontSize: 18.0),
                          ),
                          leading: Hero(
                            tag: data[index]["name"],
                            child: SizedBox(
                              width: 30.0,
                              height: 30.0,
                              child: SvgPicture.network(
                                data[index]["logo_url"],
                                placeholderBuilder: (BuildContext context) =>
                                    Container(
                                        child:
                                            const CircularProgressIndicator()),
                              ),
                            ),
                          ),
                          subtitle: getsubtitle(
                              data[index]["price"],
                              data[index]["rank"],
                              Theme.of(context).textSelectionColor),
                          isThreeLine: true,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPage(data: data[index]),
                                ));
                          });
                    },
                  )
                : Center(
                    child:CircularProgressIndicator(),
                  ),
          ),
        );
      },
    ));
  }
}

Widget getsubtitle(String pricetag, String pricePercent, Color iscolor) {
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
