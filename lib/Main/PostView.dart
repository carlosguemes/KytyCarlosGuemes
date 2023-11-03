import 'package:flutter/material.dart';
import 'package:kyty/FirestoreObjects/FbPost.dart';
import '../Singletone/DataHolder.dart';

class PostView extends StatefulWidget{

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  FbPost _datosPost = FbPost(titulo: "titulo", cuerpo: "cuerpo", imagen: "imagen");

  @override
  void initState(){
    super.initState();
    cargarPostGuardadoEnCache();
  }

  void cargarPostGuardadoEnCache() async{
    var temp1 = await DataHolder().initCachedFbPost();

    setState(() {
      _datosPost = temp1!;
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(title: Text(DataHolder().sNombre)),
      body: Column(
        children: [
          Text(_datosPost.titulo),
          Text(_datosPost.cuerpo),
          Image.asset(_datosPost.imagen, width: 100, height: 100),
          TextButton(onPressed: null, child: Text("Like"))
        ],

      ),
    );

  }
}