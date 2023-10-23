import 'package:flutter/material.dart';

import '../Singletone/DataHolder.dart';

class PostView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(title: Text(DataHolder().sNombre)),
      body: Column(
        children: [
          Text(DataHolder().selectedPost.titulo),
          Text(DataHolder().selectedPost.cuerpo),
          Image.network("img"),
          TextButton(onPressed: null, child: Text("Like"))
        ],

      ),
    );

  }


}