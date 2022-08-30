import 'package:auth_buttons/auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_test/googlePage.dart';



class SingInPage extends StatefulWidget {
  SingInPage({Key? key}) : super(key: key);
  final String title = "Registration";
  @override
  State<SingInPage> createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

final GoogleSignIn _googleSingIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Builder(builder: ((context) {
            return ElevatedButton(
                onPressed: () async {
                  var user = await _auth.currentUser!;

                  if (user == null) {
                    Scaffold.of(context).showBottomSheet(
                        (context) => Text("No esta logueado "));
                    return;
                  }
                  _singOut();
                  final String id = user.uid;
                  Scaffold.of(context).showBottomSheet(
                      (context) => Text("Deslogueo existoso " + id));
                },
                child: Text("Sing out"));
          }))
        ],
      ),
      body: Builder(builder: (context) {
        return ListView(
          scrollDirection: Axis.vertical,
          children: [_GoogleSingInSection()],
        );
      }),
    );
  }

  void _singOut() async {
    await _auth.signOut();
  }
}

class _GoogleSingInSection extends StatefulWidget {
  _GoogleSingInSection({Key? key}) : super(key: key);

  @override
  State<_GoogleSingInSection> createState() => __GoogleSingInSectionState();
}

class __GoogleSingInSectionState extends State<_GoogleSingInSection> {
  late bool _success;
  late String _userID;
  final FirebaseAuth _auth = FirebaseAuth.instance;

final GoogleSignIn _googleSingIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text("Test sing with google"),
          padding: EdgeInsets.all(15),
          alignment: Alignment.center,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical:15.0),
          alignment: Alignment.center,
          child:Column(
            children: [
              GoogleAuthButton(
                onPressed: ()=> singInwithGoogle(),
                darkMode: true,
              )
            ],
          )

        )
      ],
    );
  }
  
  singInwithGoogle()async {
    final googleuser = await _googleSingIn.signIn();
    print(googleuser);
    final googleauth = await googleuser!.authentication;
    final credential = GoogleAuthProvider.credential(accessToken: googleauth.accessToken,idToken: googleauth.idToken);
    final user = await _auth.signInWithCredential(credential);
    assert(user.user!.displayName != null);
    assert(await user.user!.getIdToken() !=null);

    print(user.user);
    final currentUser = await _auth.currentUser;
    assert(user.user!.uid == currentUser!.uid);
    setState(() {
      if(user != null) {
        _success  = true;
        _userID = user.user!.uid;
        Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context)=> GoogleScreen()));
      }
    });
    assert(user.user!.uid == currentUser!.uid);

  }
}
