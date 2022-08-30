import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoogleScreen extends StatefulWidget {
  GoogleScreen({Key? key}) : super(key: key);

  @override
  State<GoogleScreen> createState() => _GoogleScreenState();
}

class _GoogleScreenState extends State<GoogleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Google Auth'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(5.0),
            width: 400.0,
            height: 400.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage("assets/images/curved.jpg"),

              )
            ),
          )
        ],
      ),
    );
  }
}