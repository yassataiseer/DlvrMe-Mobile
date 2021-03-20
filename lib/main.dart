import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home_widget.dart';

void main() {
  runApp(MyApp());
  TextEditingController etUsername = new TextEditingController();
  TextEditingController etPassword = new TextEditingController();
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget{
  String Usrnme;
  @override
  TextEditingController etUsername = new TextEditingController();
  TextEditingController etPassword = new TextEditingController();
  var nUsername = "";
  var nPassword = "";
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.amber[50],
      appBar: AppBar(title: Text("DlvrMe-Login"),
      ),
      body: Center(


    child: Column(
      children: [

        Center(child:Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Text('Login',
                style: TextStyle(fontSize: 22)))),
        Center(child:Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child:TextField(
              controller: etUsername,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    // width: 0.0 produces a thin "hairline" border
                      borderRadius: BorderRadius.all(Radius.circular(90.0)),
                      borderSide: BorderSide(color: Colors.white24)
                    //borderSide: const BorderSide(),
                  ),
                  prefixIcon: Icon(Icons.account_box),
                  labelText: 'Username'

              ),



            ))),

        Center(child:Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child:
            TextField(
              obscureText: true,
              controller: etPassword,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide(color: Colors.white24)
                //borderSide: const BorderSide(),
              ),
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Password'),
            ))),
        Center(child:Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),

            child:
            RaisedButton(
              onPressed: () async {
                nUsername = etUsername.text;
                nPassword = etPassword.text;
                var url = 'http://10.0.0.54:5000/validate_user/'+nUsername+"/"+nPassword;
                var response = await http.get(url);
                var x = json.decode((response.body));

                if (x["Status"]==true) {
                  Usrnme = nUsername;
                  var data = 'http://10.0.0.54:5000/spec_order/'+nUsername;
                  var response = await http.get(data);
                  var y = json.decode(response.body);
                  print(y);
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage(Usrnme:Usrnme)));
                }
                else{
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ErrorPage()));
                }
              },
             child: Text('Login',
            style: TextStyle(color: Colors.black, fontSize: 14),
            ),
                color:Colors.greenAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
        ))),
        Center(child:Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child:
            RaisedButton(
              onPressed: (){Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()));},
              child: Text('New User Sign Up Here!',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              color:Colors.blueAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ))),
      ],
      ),
      ),
    );
  }
}

class SignUpPage extends StatelessWidget{
  String Usrnme;
  @override
  TextEditingController etUsername = new TextEditingController();
  TextEditingController etPassword = new TextEditingController();
  String nUsername = "";
  String nPassword = "";
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.amber[50],
        appBar: AppBar(title: Text("DlvrMe-SignUp"),),
      body: Center(
        child: Column(
          children: [

            Center(child:Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text('Sign Up',
                    style: TextStyle(fontSize: 22)))),


            Center(child:Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child:TextField(
                  controller: etUsername,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.all(Radius.circular(90.0)),
                          borderSide: BorderSide(color: Colors.white24)
                        //borderSide: const BorderSide(),
                      ),                      prefixIcon: Icon(Icons.account_box),
                      labelText: 'Make a Username'),
                ))),

            Center(child:Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child:
                TextField(
                  controller: etPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.all(Radius.circular(90.0)),
                          borderSide: BorderSide(color: Colors.white24)
                        //borderSide: const BorderSide(),
                      ),                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Make a Password'),
                ))),
            Center(child:Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child:
                RaisedButton(
                  onPressed: ()
                  async {nUsername = etUsername.text;
                  nPassword = etPassword.text;
                  var url = 'http://10.0.0.54:5000/mk_user/'+nUsername+"/"+nPassword;
                  print(url);
                  var response = await http.get(url);
                  var x = json.decode((response.body));
                  if (x["Status"]==true) {
                    Usrnme = nUsername;
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage(Usrnme: Usrnme)));
                  }
                  else{
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ErrorPage()));
                  }},
                  child: Text('Sign-Up',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  color:Colors.greenAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ))),
            Center(child:Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child:
                RaisedButton(
                  onPressed: (){Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()));},
                  child: Text('Already a user? Click here!',
                    style: TextStyle(color: Colors.black, fontSize: 14),

                  ),
                  color:Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ))),
          ],
        ),
      )
    );
  }
}


class ErrorPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("DlvrMe-Login"),
      ),
      body: Center(
        child: Column(
          children: [
            Center(child:Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text('Invalid creds or The username you want to be signed up with is take',
                    style: TextStyle(fontSize: 22)))),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget{
  HomePage({this.Usrnme});
  final String Usrnme;
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
    title: 'My Flutter App',
      home: Home(Usrnme:Usrnme),

    );
  }
}
