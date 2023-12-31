import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyty/KTPaddingText/PaddingClass.dart';

class RegisterView extends StatelessWidget{

  late BuildContext _context;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();

  SnackBar snackBar = SnackBar(
    content: Text('Las contraseñas han de ser iguales'),
  );

  void onClickAceptarRegistrar() async {
    //print("DEBUG -> " + usernameController.text);
    if (passwordController.text == repasswordController.text) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: usernameController.text,
          password: passwordController.text,
        );
        Navigator.of(_context).popAndPushNamed('/homeview');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
    else{
      ScaffoldMessenger.of(_context).showSnackBar(snackBar);
    }
  }

  void onClickCancelarRegistrar(){
    Navigator.of(_context).popAndPushNamed('/loginview');
  }


  @override
  Widget build(BuildContext context) {
    _context = context;
    // TODO: implement build
    Text texto = Text("Cómo 33");
    //return texto;

    Column columna = Column(children: [
      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
      Text('Bienvenido a Kyty Register', style: TextStyle(fontSize: 25)),
      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
      PaddingClass(controlador: usernameController,
          labelText: 'Input User',
          esContrasenya: false
      ),

      PaddingClass(controlador: passwordController,
          labelText: 'Input Password',
          esContrasenya: true
      ),

      Padding(
        padding:EdgeInsets.symmetric(horizontal: Checkbox.width, vertical: 5),
        child: Flexible(
          child: SizedBox(width: 400,
            child: TextFormField(
              controller: repasswordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Repite Password',
                fillColor: Colors.white,
                filled: true,
              ),
              obscureText: true,
            ),
          ),
        ),
      ),

      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 10),
          child: TextButton(onPressed: onClickAceptarRegistrar, child: Text("Aceptar")),),

        Padding(padding: EdgeInsets.symmetric(vertical: 10),
          child: TextButton(onPressed: onClickCancelarRegistrar, child: Text("Cancelar")),)
      ],)

    ],); //Columna

    AppBar appBar = AppBar(
      title: const Text('Register'),
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