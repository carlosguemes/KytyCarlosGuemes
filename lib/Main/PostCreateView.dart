import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kyty/FirestoreObjects/FbPost.dart';
import 'package:kyty/KTPaddingText/PaddingClass.dart';

import '../Singletone/DataHolder.dart';

class PostCreateView extends StatefulWidget{
  @override
  State<PostCreateView> createState() => _PostCreateViewState();
}

class _PostCreateViewState extends State<PostCreateView> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController tecTitulo = TextEditingController();

  TextEditingController tecCuerpo = TextEditingController();

  ImagePicker _picker = ImagePicker();
  File _imagePreview = File("");

  void onGalleryClicked() async{
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  }

  void onCameraClicked() async{
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image!=null){
      setState(() {
        _imagePreview=File(image.path);
      });
    }
  }

  void subirPost() async{
    final storageRef = FirebaseStorage.instance.ref();

    String rutaEnNube="posts/" +
        FirebaseAuth.instance.currentUser!.uid+"/imgs/" +
        DateTime.now().millisecondsSinceEpoch.toString();
    final rutaAFicheroEnNube = storageRef.child(rutaEnNube);
    final metadata = SettableMetadata(contentType: "image/jpeg");

    //------------INICIO DE SUBIR IMAGEN--------------//
    try{
      await rutaAFicheroEnNube.putFile(_imagePreview, metadata);
    } on FirebaseException catch (o){
      print("ERROR AL SUBIR LA IMAGEN: " + o.toString());
    }
    print("Se ha subido la imagen");


    String imgUrl = await rutaAFicheroEnNube.getDownloadURL();

    print("Se ha subido la imagen " + imgUrl);

    //------------FIN DE SUBIR IMAGEN--------------//

    //------------INICIO DE SUBIR POST--------------//

    FbPost postNuevo = new FbPost(
        titulo: tecTitulo.text,
        cuerpo: tecCuerpo.text,
        imagen: imgUrl
    );

    DataHolder().crearPostEnFB(postNuevo);

    //------------FIN DE SUBIR POST--------------//

    Navigator.of(context).pushNamed('/homeview');

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
          if (_imagePreview.path != "")
            Image.file(_imagePreview, width: 100, height: 100),

          Row(
            children: [
              TextButton(onPressed: onGalleryClicked, child: Text("Galeria")),
              TextButton(onPressed: onCameraClicked, child: Text("Camara")),
            ],
          ),

          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: subirPost, child: Text("Postear")),
            ],
          ),
        ],
      ),
    );
  }
}