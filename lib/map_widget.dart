import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'home_widget.dart';
import 'main.dart';
import 'package:latlong/latlong.dart';

class Maps extends StatefulWidget {
  Maps({this.Usrnme});
  final String Usrnme; // receives the value
  @override
  State<StatefulWidget> createState() {

    return _MapState(Usrnme:Usrnme);

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
class _MapState extends State<Maps> {
  _MapState({this.Usrnme});
  final String Usrnme;
  Future<List<Welcome>> grab_stuff() async{
    String data = 'http://10.0.0.53:5000/all_order';
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
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Map View of orders'),
      ),
     body:

     FutureBuilder<List<Welcome>>(
       future: grab_stuff(),
       builder: (context,snapshot){
         print('snapshot: $snapshot');
         if (!snapshot.hasData){
           return Center(
               child: CircularProgressIndicator()
           );
         }

         return new FlutterMap(

           options: MapOptions(
             zoom: 30.0,
           ),
           children: snapshot.data
               .map((user) =>
                FlutterMap(
        options: MapOptions(
          zoom: 13.0,
        ),

        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']

          ),
          MarkerLayerOptions(

            markers: [
               Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(user.latitude,user.longitude),
                builder: (context) =>
                      IconButton(
                        icon: Icon(Icons.location_on),
                        color: Colors.redAccent,
                        iconSize: 45,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_){
                              return AlertDialog(title: Text
                                ("Address is:"+user.address+"\n"+"The item is: "+user.item+"\n"+"Price: \$"+user.price.toString()+"\n"+"Product info: "+user.description,),);
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ],
         )
           ).toList(),
      );
  },

     ),


      bottomNavigationBar: BottomAppBar(
        child:  Row(
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
      ),
    );
  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}