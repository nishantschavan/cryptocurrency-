import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Searchbar extends SearchDelegate {
    var newdata;
    Searchbar(data){
      newdata=data;
    }

  List<String> tempList = new List<String>();
  _getNames() async {
      Response response = await Dio().get("https://api.nomics.com/v1/currencies/ticker?key=5c118d548562c7f8f44e9c1e83dcbe38");
      
      for (int i = 0; i < response.data.length; i++) {
        tempList.add(response.data[i]["name"]);
      }
  }

  int getlength(List<String> _templist){
    return _templist.length;
  }

  final recent = [
    "Bitcoin",
    "Ethereum",
    "Teather",
    "Ripple"
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon:Icon(Icons.clear)
    , onPressed: (){
      query="";
    }
    )];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      // ignore: missing_required_param
      icon: AnimatedIcon(
        icon:AnimatedIcons.menu_arrow,progress: transitionAnimation,), 
    onPressed: (){
      close(context, null);
    }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    
  }

  @override
  Widget buildSuggestions(BuildContext context){
    var suggestion =query.isEmpty?recent:recent;
    return ListView.builder(
      itemCount: newdata.length,
      itemBuilder: (context,index){
        return ListTile(
          leading:Icon(Icons.keyboard_arrow_down),
          title: Text(newdata[index]["name"]),
        );
      }
    );
  }
}