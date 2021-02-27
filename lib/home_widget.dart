import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_app/map_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'main.dart';
import 'order_form.dart';


class Home extends StatefulWidget {
  Home({this.Usrnme});
  final String Usrnme;// receives the value
  @override

  State<StatefulWidget> createState() {
    return _HomeState(Usrnme:Usrnme);
  }
}
class Welcome {
  String address;
  String description;
  String item;
  double latitude;
  double longitude;
  String name;
  double price;
  Welcome({
    this.address,
    this.description,
    this.item,
    this.latitude,
    this.longitude,
    this.name,
    this.price,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) {
    print(json["Address"]);
    return Welcome(address: json["Address"],
        description: json["Description"],
        item: json["Item"],
        latitude: json["Latitude"].toDouble(),
        longitude: json["Longitude"].toDouble(),
        name: json["Name"],
        price: json["Price"]);
  }


}

class _HomeState extends State<Home> {
  _HomeState({this.Usrnme});
  final String Usrnme;// receives the value
  Future<List<Welcome>> grab_stuff() async{
    String data = 'http://10.0.0.53:5000/spec_order/'+widget.Usrnme;
    var response = await http.get(data);
    if (response.statusCode == 200) {
      List FinalData = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Welcome> usersList = FinalData.map<Welcome>((json) {
        return Welcome.fromJson(json);
      }).toList();
      //return Post.fromJson(FinalData);
      print(usersList);
      return usersList;
    }else {
      throw Exception('Failed to load data from internet');
    }
  }
  @override
  int _currentIndex = 0;

  final List<Widget> _children = [];
  final List<String> HeaderList = ["Name","Address","Item","Price","Info"];


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Usrnme+"'s Orders"),
      ),

      body: FutureBuilder<List<Welcome>>(
        future: grab_stuff(),
        builder: (context,snapshot){
          print('snapshot: $snapshot');
          if (!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator()
            );
          }
          return ListView(
              children: snapshot.data
              .map((user) => Card( color: Colors.purple[50],
                      child: ListTile(
            title: Text(user.name),
            onTap: (){ print(user.name); },

            subtitle:  Column(
              children: <Widget>[
                Text(
                  "Address is:"+user.address+"\n"+"The item is: "+user.item+"\n"+"Price: \$"+user.price.toString()+"\n"+"Product info: "+user.description,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 10,
                ),
                FlatButton(color:Colors.redAccent,child: Text("Delete"), onPressed: () async{
                  var url = 'http://10.0.0.53:5000/del_order/'+user.name+"/"+user.address+"/"+user.item+"/"+user.price.toString()+"/"+user.description;
                  var response = await http.get(url);
                  var x = json.decode((response.body));
                  setState(() {});

                })
              ],
            ),
              )),
          )
          .toList(),


          );
        }
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Order(Usrnme: Usrnme)));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),

          bottomNavigationBar: BottomAppBar(
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton( onPressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home(Usrnme:Usrnme)));},
                  color: Colors.yellowAccent,
                  child: Row(
                    children:<Widget> [
                      Icon(Icons.home),Text("Home Page")],
                  )
              ),
              FlatButton( onPressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Maps(Usrnme:Usrnme)));},
                  color: Colors.yellowAccent,
                  child: Row(
                    children:<Widget> [
                      Icon(Icons.map),Text("View Map Worldwide")],
                  )
              ),
            ],
          ),
        )

      );
  }
}



