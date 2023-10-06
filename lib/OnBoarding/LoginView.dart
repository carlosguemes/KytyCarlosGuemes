import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../FirestoreObjects/FbUsuario.dart';
import '../KTPaddingText/PaddingClass.dart';

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

      DocumentReference<FbUsuario> reference = db
          .collection("Usuarios")
          .doc(uidUsuario)
          .withConverter(fromFirestore: FbUsuario.fromFirestore,
          toFirestore: (FbUsuario usuario, _) => usuario.toFirestore());

      DocumentSnapshot<FbUsuario> docSnap = await reference.get();
      FbUsuario usuario = docSnap.data()!;

      if (usuario!=null) {
        print("Nombre del usuario: " + usuario.nombre);
        print("Edad del usuario: " + usuario.edad.toString());
        print("Altura del usuario: " + usuario.altura.toString());
        print("Color de pelo del usuario: " + usuario.colorPelo);
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
      PaddingClass(controlador: tecUsername,
          labelText: 'Input User',
          esContrasenya: false
      ),

      PaddingClass(controlador: tecPassword,
          labelText: 'Input Password',
          esContrasenya: true
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