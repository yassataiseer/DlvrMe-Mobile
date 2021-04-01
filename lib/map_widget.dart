import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home_widget.dart';
import 'main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'package:location/location.dart';
import 'dart:math';

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
    String data = 'https://dlvrapi.pythonanywhere.com/all_order';
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
  GoogleMapController mapController;
  Location _location = Location();

  final LatLng _center = const LatLng(45.521563, -122.677433);
  final Map<String, Marker> _markers = {};
  List Data = [];
  Future<void>  _onMapCreated(GoogleMapController controller) async{
    //mapController = controller;
    String data = 'https://dlvrapi.pythonanywhere.com/all_order';
    var response = await http.get(data);
    if (response.statusCode == 200) {
      List FinalData = json.decode(response.body).cast<Map<String, dynamic>>();
      final List<Welcome> usersList = FinalData.map<Welcome>((json) {
        return Welcome.fromJson(json);
      }).toList();
      //return Post.fromJson(FinalData);
      Data = usersList;
    }else {
      throw Exception('Failed to load data from internet');
    }


    _location.onLocationChanged.listen((l) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 15),
        ),
      );
    });
    setState(() {
      //_markers.clear();
      for (final data in Data ){
        print("JLNVAdfAFNSVlADNSVlADNSVlADNSV");
        print(data.address);
        final marker =  Marker(
          markerId: MarkerId(data.address+data.name),
          position: LatLng(data.latitude, data.longitude),
          onTap: (){
            showDialog(
              context: context,
              builder: (_){
                return AlertDialog(title: Text
                  ("The person's name is:"+data.name+"Address is:"+data.address+"\n"+"The item is: "+data.item+"\n"+"Price: \$"+data.price.toString()+"\n"+"Product info: "+data.description,),);
              },
            );
          },
        );
        _markers[data.address] = marker;
      }
    });
  }
  @override
  int _currentIndex = 0;
  final List<Widget> _children = [];
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: Text('Map View of orders around the world'),
          backgroundColor: Color(0xff002366)

      ),
     body: GoogleMap(

       onMapCreated: _onMapCreated,
       initialCameraPosition: CameraPosition(
         target: _center,
         zoom: 11.0,
       ),
       markers: _markers.values.toSet(),
     ),



      bottomNavigationBar: BottomAppBar(
        child:  Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton( onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home(Usrnme:Usrnme)));},
                color:  Color(0xff002366),

                child: Row(
                  children:<Widget> [
                    Icon(Icons.home,color: Colors.white,),Text("Home Page",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )],
                )
            ),
            FlatButton( onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Maps(Usrnme:Usrnme)));},
                color:  Color(0xff002366),
                child: Row(
                  children:<Widget> [
                    Icon(Icons.map,color: Colors.white,),Text("View Map Worldwide",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )],
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