import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../KTPaddingText/PaddingClass.dart';

class PhoneLoginView extends StatefulWidget{
  @override
  State<PhoneLoginView> createState() => _PhoneLoginViewState();
}

class _PhoneLoginViewState extends State<PhoneLoginView> {
  TextEditingController tecPhone = TextEditingController();
  TextEditingController tecVerify = TextEditingController();

  void enviarTelefonoPressed(){
    String sTelefono = tecPhone.text;
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+44 7123 123 456',
      verificationCompleted: verificacionCompletada,
      verificationFailed: verificacionFallida,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void enviarVerifyPressed(){

  }

  void verificacionCompletada(PhoneAuthCredential credencial){

  }

  void verificacionFallida(FirebaseAuthException credencial){

  }

  void codeSent(String sCadena, int? iNumero){

  }

  void codeAutoRetrievalTimeout(String sCadena){

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          PaddingClass(controlador: tecPhone, esContrasenya: false, labelText: "Número de teléfono"),
          TextButton(onPressed: enviarTelefonoPressed, child: Text("Enviar Teléfono")),
          PaddingClass(controlador: tecVerify, esContrasenya: false, labelText: "Número Verificación"),
          TextButton(onPressed: enviarVerifyPressed, child: Text("Enviar Verificación")),
        ],
      )
    );
  }
}