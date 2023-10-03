import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget{
  
  late BuildContext _context;

  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;

  void onClickAceptarLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: tecUsername.text,
        password: tecPassword.text,
      );

      String uidUsuario = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> datos = await db.collection("Usuarios").doc(uidUsuario).get();

      if (datos.exists) {
        print(datos.data()?["Nombre"] + " ya está conectado manines");
        print(datos.data()?["Edad"] + " años tiene este manín");
        Navigator.of(_context).popAndPushNamed("/homeview");
      }

      else{
        Navigator.of(_context).popAndPushNamed('/perfilview');
      }

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
        padding:EdgeInsets.symmetric(horizontal: Checkbox.width, vertical: 16),
        child: Flexible (child: SizedBox(width: 400, child: TextField(
          controller: tecUsername,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            //hintText: 'Input User',
            labelText: 'Input User',
            fillColor: Colors.white,
            filled: true,
          ),
        ),
        ),
        ),
      ),

      Padding(
        padding:EdgeInsets.symmetric(horizontal: Checkbox.width, vertical: 0),
        child: Flexible(
          child: SizedBox (child: SizedBox(width: 400,
            child: TextFormField(
              controller: tecPassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                //hintText: 'Input Password',
                labelText: 'Input Password',
                fillColor: Colors.white,
                filled: true,
              ),
              obscureText: true,
            ),
          )
          ),
        ),
      ),

      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 10),
          child: TextButton(onPressed: onClickAceptarLogin, style: TextButton.styleFrom(foregroundColor: Colors.black),
              child: Text("Aceptar")),),

        Padding(padding: EdgeInsets.symmetric(vertical: 10),
          child: TextButton(onPressed: onClickRegistrar, style: TextButton.styleFrom(foregroundColor: Colors.black),
              child: Text("Registro")),)
      ],)

    ],); //Columna

    AppBar appBar = AppBar(
      title: const Text('Login'),
      centerTitle: true,
      shadowColor: Colors.blue,
      backgroundColor: Colors.black,
      foregroundColor: Colors.cyanAccent,
    );

    Scaffold scaf = Scaffold(
      body: columna,
      backgroundColor: Colors.orange,
      appBar: appBar,
    );

    return scaf;

  }
}