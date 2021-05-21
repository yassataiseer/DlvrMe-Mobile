import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:http_auth/http_auth.dart';

import 'home_widget.dart';

void main() {
  runApp(MyApp());
  TextEditingController etUsername = new TextEditingController();
  TextEditingController etPassword = new TextEditingController();
  TextEditingController etScndPassword = new TextEditingController();
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
  TextEditingController etScndPassword = new TextEditingController();
  var nUsername = "";
  var nPassword = "";
  Widget build(BuildContext context){
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("DlvrMe-Login"),
          backgroundColor: Color(0xff002366)
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
                  filled: true,
                  fillColor:Colors.amber[50],
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
                  filled: true,
                  fillColor: Colors.amber[50],
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
                print(nUsername);
                if (nUsername==""||nPassword=="" ){
                  showDialog(
                    context: context,
                    builder: (_){
                      return AlertDialog(title: Text("Please fill out entire form"));
                    },
                  );
                } else{
                var url = 'https://dlvrapi.pythonanywhere.com/Users/validate_user/'+nUsername+"/"+nPassword;
                var client = BasicAuthClient('Yassa Taiseer', 'yassa123');
                var response = await client.get(url);
                var x = json.decode((response.body));
                if (x["Status"]==true) {
                  Usrnme = nUsername;
                  var data = 'https://dlvrapi.pythonanywhere.com/Orders/spec_order/'+nUsername;
                  var response = await client.get(data);
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
                }
              },
             child: Text('Login',
            style: TextStyle(color: Colors.white, fontSize: 14),
            ),
                color:Color(0xff002366),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
        ))),
        Center(child:Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child:
            // ignore: deprecated_member_use
            RaisedButton(
              onPressed: (){Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()));},
              child: Text('New User Sign Up Here!',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              color:Colors.amber[50],
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
  TextEditingController etScndPassword = new TextEditingController();
  String nUsername = "";
  String nPassword = "";
  String nScndPassword = "";
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.amber[50],
        appBar: AppBar(title: Text("DlvrMe-SignUp"),
            backgroundColor: Color(0xff002366)
        ),
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
                      filled: true,
                      fillColor: Colors.amber[50],
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
                      filled: true,
                      fillColor: Colors.amber[50],
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
                TextField(
                  controller: etScndPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.amber[50],
                      border: OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                          borderRadius: BorderRadius.all(Radius.circular(90.0)),
                          borderSide: BorderSide(color: Colors.white24)
                        //borderSide: const BorderSide(),
                      ),                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Confirm Password'),
                ))),


            Center(child:Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child:
                RaisedButton(
                  onPressed: ()


                  async {
                  nUsername = etUsername.text;
                  nPassword = etPassword.text;
                  nScndPassword = etScndPassword.text;
                  var client = BasicAuthClient('Yassa Taiseer', 'yassa123');
                  if(nUsername==""||nPassword==""||nScndPassword==""){
                    showDialog(
                      context: context,
                      builder: (_){
                        return AlertDialog(title: Text("Please fill out entire form"));
                      },
                    );
                  }

                  if (nScndPassword==nPassword){
                  var url = 'https://dlvrapi.pythonanywhere.com/Users/mk_user/'+nUsername+"/"+nPassword;
                  print(url);
                  var response = await client.get(url);
                  var x = json.decode((response.body));
                  if (x["Status"]==true) {
                    Usrnme = nUsername;
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage(Usrnme: Usrnme)));
                  }
                  else {
                    showDialog(
                      context: context,
                      builder: (_){
                        return AlertDialog(title: Text("This username already exists"));
                      },
                    );
                  }
                  }
                  else{
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ErrorPage()));
                  }
                  },


                  child: Text('Sign-Up',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  color:Color(0xff002366),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ))),
            Center(child:Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child:
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: (){Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()));},
                  child: Text('Already a user? Click here!',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  color:Colors.amber[50],
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
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text("Error Page"),
            backgroundColor: Color(0xff002366)
        ),
      body: RichText(
    text: new TextSpan(
      // Note: Styles for TextSpans must be explicitly defined.
      // Child text spans will inherit styles from parent
      style: new TextStyle(
      fontSize: 14.0,
      color: Colors.black,
    ),
    children: <TextSpan>[
    new TextSpan(text: 'If you are signing up:', style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
      new TextSpan(text: ' Then the username specified is not allowed OR your name is already taken \n',style: new TextStyle(fontSize: 25)),
      new TextSpan(text: ' If you are logging in:', style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
      new TextSpan(text: ' Then you are using the wrong credentials'' \n',style: new TextStyle(fontSize: 25)),

    ],),)


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
