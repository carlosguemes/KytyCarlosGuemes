import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget{

  late BuildContext _context;

  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  void onClickAceptarLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: tecUsername.text,
          password: tecPassword.text,
      );
      Navigator.of(_context).popAndPushNamed('/homeview');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void onClickRegistrar(){
    Navigator.of(_context).popAndPushNamed('/registerview');
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    // TODO: implement build

    Column columna = Column(children: [
      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
      Text("Bienvenido a Kyty Login", style: TextStyle(fontSize: 25)),
      Padding(
        padding:EdgeInsets.symmetric(horizontal: 500, vertical: 16),
          child: TextField(
            controller: tecUsername,
            decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input User',
          ),
        ),
      ),

      Padding(
        padding:EdgeInsets.symmetric(horizontal: 500, vertical: 0),
        child: TextFormField(
          controller: tecPassword,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input Password',
          ),
          obscureText: true,
        ),
      ),

      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 10),
            child: TextButton(onPressed: onClickAceptarLogin, child: Text("Aceptar")),),

        Padding(padding: EdgeInsets.symmetric(vertical: 10),
          child: TextButton(onPressed: onClickRegistrar,
              child: Text("Registro")),)
      ],)

    ],); //Columna

    AppBar appBar = AppBar(
      title: const Text('Login'),
      centerTitle: true,
      shadowColor: Colors.blue,
      backgroundColor: Colors.black,
    );

    Scaffold scaf = Scaffold(
      body: columna,
      backgroundColor: Colors.orange,
      appBar: appBar,
    );

    return scaf;

  }
}