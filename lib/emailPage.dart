import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmailScreen extends StatefulWidget {
  EmailScreen({Key? key}) : super(key: key);

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Email Auth'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(5.0),
            width: 400.0,
            height: 400.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage("assets/images/castillo.jpg"),

              )
            ),
          )
        ],
      ),
    );
  }
}