import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_test/googlePage.dart';
import 'package:login_test/register_page.dart';
import 'package:login_test/singin_page.dart';
import 'package:firebase_core/firebase_core.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth',
      home: LoginPage(title:"Firebase Auth"),
    );
  }
}

class LoginPage extends StatefulWidget {
  final String title;
  LoginPage({Key? key, required this.title}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
      appBar: AppBar(title: Text("Login Page")),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                icon: Icon(Icons.email)
              ),
            ),
            SizedBox(height: 15.0,),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                icon: Icon(Icons.vpn_key)
              ),
            ),
            SizedBox(height: 15.0,),
            ElevatedButton(
              onPressed: () {
                
                FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: _emailController.text, 
                  password: _passwordController.text
                  ).then((value){
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => GoogleScreen()));
                  }).catchError((e)=> print(e) ) ;

              },
              child: Text("Login")),
            ElevatedButton(
              onPressed: () => _pushPage(context,RegisterPage()), 
              child: Text("Register")),
              VerticalDivider(),
              ElevatedButton(
              onPressed: () => _pushPage(context,SingInPage()), 
              child: Text("Register")),
          ],
        ),
      ), 
    );
    
  }
  
  _pushPage(BuildContext context, page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }
}