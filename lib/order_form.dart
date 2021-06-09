import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'package:http_auth/http_auth.dart';
import 'package:flutter_config/flutter_config.dart';

class Order extends StatefulWidget{
  Order({this.Usrnme});
  final String Usrnme;// receives the value
  @override


  State<StatefulWidget> createState() {
    print(Usrnme);
    return _OrderPage(Usrnme: Usrnme);
  }


}

class _OrderPage extends State<Order>{
  _OrderPage({this.Usrnme});
  final String Usrnme;// receives the value
  TextEditingController Address = new TextEditingController();
  TextEditingController CityProv = new TextEditingController();
  TextEditingController Item = new TextEditingController();
  TextEditingController Price = new TextEditingController();
  TextEditingController Description = new TextEditingController();
  @override
  Widget build(BuildContext context) {
      String Address1 = "";
      String Item1 = "";
      String Price1 = "";
      String Description1 = "";
      return Scaffold(
        backgroundColor: Colors.amber[50],
        appBar: AppBar(title: Text("DlvrMe Order Form"),
            backgroundColor: Color(0xff002366)
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(child:Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Text("Welcome "+ Usrnme,
                      style: TextStyle(fontSize: 22)))),
              Center(child:Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child:TextField(
                    controller: Address,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.location_city),
                        labelText: 'Address to pick up'),

                  ))),
              Center(child:Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child:TextField(
                    controller: CityProv,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.add_location),
                        labelText: 'City And Province/State'),

                  ))),

              Center(child:Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child:TextField(
                    controller: Item,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.add_box),
                        labelText: 'What is the Item?'),
                  ))),
              Center(child:Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child:TextField(
                    controller: Price,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.money),
                        labelText: 'Price?'),
                    keyboardType: TextInputType.number,
                  ))),
              Center(child:Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child:TextField(
                    controller: Description,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.info),
                        labelText: 'Informating regarding product'),
                  ))),
              Center(child:Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child:
                  // ignore: deprecated_member_use
                  RaisedButton(
                    onPressed: () async{
                      var client = BasicAuthClient('Yassa Taiseer', 'yassa123');
                      Address1 = Address.text;
                      var cityprov = CityProv.text;
                      Address1 = Address1+" "+cityprov;
                      var status = await client.get("https://dlvrapi.pythonanywhere.com/Orders/validate_address/"+Address1);
                      var decodeStatus = json.decode((status.body));
                      if(decodeStatus["Status"]==true) {
                        double Price2 = 0;
                        Item1 = Item.text;
                        Price1 = Price.text;
                        Price2 = double.parse(Price1);
                        Description1 = Description.text;
                        var exist_address = await client.get(FlutterConfig.get('BACKEND_API')+"/Orders/find_address/"+Address1);
                        var decodedAnswer = json.decode((exist_address.body));
                        if(decodedAnswer["Status"]==false) {
                          var url = 'https://dlvrapi.pythonanywhere.com/Orders/mk_order/' + Usrnme +
                              "/" + Address1 + "/" + Item1 + "/" +
                              Price2.toString() + "/" + Description1;
                          print(url);
                          var response = await client.get(url);
                          var x = json.decode((response.body));
                          print(x);
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  HomePage(Usrnme: Usrnme)));
                        }
                        else{
                          showDialog(
                            context: context,
                            builder: (_){
                              return AlertDialog(title: Text("This address is take already by another user"));
                            },
                          );
                        }
                      }
                      else if(decodeStatus["Status"]==false){
                        showDialog(
                          context: context,
                          builder: (_){
                            return AlertDialog(title: Text("This address does not exist please try another...."));
                          },
                        );
                      }
                    },
                    child: Text('Submit Order',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    color: Color(0xff002366),
                  )))
            ],
          ),
        ),
      );

  }

}