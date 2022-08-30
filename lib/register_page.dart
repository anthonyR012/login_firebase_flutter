
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);
  final String title = "Registration";
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _passswordController =TextEditingController();


  late bool _success = false;
  String _userEmail = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formState,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if(value!.isEmpty) {
                  return 'Please enter some text';
                }
              },
            ),
            TextFormField(
              controller: _passswordController,
              decoration: InputDecoration(labelText: 'Password'),
              validator: (value) {
                if(value!.isEmpty) {
                  return 'Please enter some text';
                }
              },
            ),
            FlatButton(
              child: Text('Register'),
              color: Colors.deepPurple,
              textColor: Colors.white,
              onPressed: () {
               _register();
              }
            ),
            Container(
              alignment: Alignment.center,
              child: Text(_success == null
                ? ''
                : (_success
                  ? 'Successfully registered' + _userEmail
                  : 'Registration failed'
                )
              ),
            )
          ],
        ),
      ),
    );
  }


  void dispose() {
    _emailController.dispose();
    _passswordController.dispose();
    super.dispose();
  }

  void _register() async {
    final user = await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passswordController.text,
    );
    if (user != null) {
      setState(() {
        _success = true;
       //_userEmail = user.user?.email; 
      });
    } else {
      _success = false;
    }
  }

}