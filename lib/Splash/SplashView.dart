import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyty/FirestoreObjects/FbUsuario.dart';

class SplashView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashViewState();
  }
}

class _SplashViewState extends State<SplashView>{

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkSession();
  }

  void checkSession() async{
    await Future.delayed(Duration(seconds: 2));

    if (FirebaseAuth.instance.currentUser != null) {
      String uidUsuario = FirebaseAuth.instance.currentUser!.uid;
      //DocumentSnapshot<Map<String, dynamic>> datos = await db.collection("Usuarios").doc(uidUsuario).get();

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
        Navigator.of(context).popAndPushNamed("/homeview");
      }

      else{
        Navigator.of(context).popAndPushNamed('/perfilview');
      }
    }

    else{
      Navigator.of(context).popAndPushNamed("/loginview");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Column column = Column(
        children: [
          Image.asset("resources/logo_kyty.png", width: 300, height: 300, fit: BoxFit.fill,),
          Padding(padding: EdgeInsets.symmetric(vertical: 30)),
          CircularProgressIndicator(),
        ]
    );
    return column;
  }
}