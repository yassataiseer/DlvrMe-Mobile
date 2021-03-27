import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

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
                        labelText: 'Address to pick up(format:123 fake st city province/state)'),
                  ))),
              Center(child:Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child:TextField(
                    controller: Item,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'What is the Item?'),
                  ))),
              Center(child:Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child:TextField(
                    controller: Price,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'What is the Price?'),
                    keyboardType: TextInputType.number,
                  ))),
              Center(child:Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child:TextField(
                    controller: Description,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Informating regarding product'),
                  ))),
              Center(child:Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child:
                  RaisedButton(
                    onPressed: () async{
                      double Price2 = 0;
                      Address1 = Address.text;
                      Item1 = Item.text;
                      Price1 = Price.text ;
                      Price2 = double.parse(Price1);
                      Description1 = Description.text;
                      var url = 'http://10.0.0.63:5000/mk_order/'+Usrnme+"/"+Address1+"/"+Item1+"/"+Price2.toString()+"/"+Description1;
                      print(url);
                      var response = await http.get(url);
                      var x = json.decode((response.body));
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage(Usrnme: Usrnme)));
                    },
                    child: Text('Submit Order',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    color:Colors.blueAccent,
                  )))
            ],
          ),
        ),
      );

  }

}