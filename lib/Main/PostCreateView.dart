import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kyty/FirestoreObjects/FbPost.dart';
import 'package:kyty/KTPaddingText/PaddingClass.dart';

import '../Singletone/DataHolder.dart';

class PostCreateView extends StatelessWidget{
  FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController tecTitulo = TextEditingController();
  TextEditingController tecCuerpo = TextEditingController();

  ImagePicker _picker = ImagePicker();

  void onGalleryClicked() async{
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  }

  void onCameraClicked() async{
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(title: Text(DataHolder().sNombre)),
      body: Column(
        children: [
          PaddingClass(controlador: tecTitulo, labelText: "Escribe el título", esContrasenya: false),
          PaddingClass(controlador: tecCuerpo, labelText: "Escribe el cuerpo", esContrasenya: false),
          Image.asset("resources/logo_kyty.png", width: 100, height: 100),

          Row(
            children: [
              TextButton(onPressed: onGalleryClicked, child: Text("Galeria")),
              TextButton(onPressed: onCameraClicked, child: Text("Camara")),
            ],
          ),

          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: () {
                FbPost postNuevo = new FbPost(titulo: tecTitulo.text, cuerpo: tecCuerpo.text, imagen: "NaN");

                DataHolder().crearPostEnFB(postNuevo);

                Navigator.of(context).pushNamed('/homeview');

              }, child: Text("Postear")),

              TextButton(onPressed: () {
                Navigator.of(context).pushNamed('/homeview');

              }, child: Text("Cancelar"))
            ],
          ),
        ],
      ),
    );
  }
}