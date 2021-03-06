import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_app/map_widget.dart';
import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart';
import 'dart:convert';
import 'dart:async';
import 'main.dart';
import 'order_form.dart';
import 'dart:math' as math;
import 'package:flutter_config/flutter_config.dart';


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
    var client = BasicAuthClient('Yassa Taiseer', 'yassa123');
    String data = 'https://dlvrapi.pythonanywhere.com/Orders/spec_order/'+widget.Usrnme;
    var response = await client.get(data);
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

        backgroundColor: Colors.amber[50],

        appBar: AppBar(


        title: Text(Usrnme+"'s Orders"),
            backgroundColor: Color(0xff002366),


        ),
      drawer: new Drawer(

        child: new ListView(
          children: <Widget>[
            new DrawerHeader(

              decoration: BoxDecoration(

                color: Color(0xff002366),
              ),

              child: Text(
                  'Settings',
                  style: TextStyle(color:Colors.amber[50],fontSize: 25)
              ),
            ),

            new ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Color(0xff002366),),
              title: Text('Logout'),
              onTap: (){
                Navigator.push(

                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()));},
            ),
          ],
        ),
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
              .map((user) => Card( color: Colors.amber[50],


                  child: ListTile(
            title: Text(user.name,
            style: TextStyle(
              color: Color(0xff002366),
            ),
            ),
            onTap: null,

            subtitle:  Column(

              children: <Widget>[
                Text(
                  "Address is:"+user.address+"\n"+"The item is: "+user.item+"\n"+"Price: \$"+user.price.toString()+"\n"+"Product info: "+user.description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(

                    color: Color(0xff002366),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 10,
                ),


                FlatButton(color:Colors.redAccent,child: Text("Delete"), onPressed: () async{
                  var client = BasicAuthClient('Yassa Taiseer', 'yassa123');
                  var url =  FlutterConfig.get('BACKEND_API')+'/Orders/del_order/'+user.name+"/"+user.address+"/"+user.item+"/"+user.price.toString()+"/"+user.description;
                  var response = await client.get(url);
                  var x = json.decode((response.body));
                  print(x);
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


          bottomNavigationBar: BottomAppBar(
            color:Color(0xff002366),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton( onPressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home(Usrnme:Usrnme)));},
                  color:Color(0xff002366),

        child: Row(
                    children:<Widget> [
                      Icon(Icons.home,color: Colors.white,),Text("Home",
                        style: TextStyle(
                          color: Colors.white,
                        ),)],
                  )
              ),

              FlatButton( onPressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Maps(Usrnme:Usrnme)));},
                  color: Color(0xff002366),
                  child: Row(

                    children:<Widget> [

                      Icon(Icons.map,
                        color: Colors.white,
                      ),Text("View Map",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),

                    ],
                  )
              ),
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Order(Usrnme: Usrnme)));
          },
          tooltip: 'Make a new order',
          child: Icon(Icons.add),
          backgroundColor: Color(0xff002366)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );

  }
}



