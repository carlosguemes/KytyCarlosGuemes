import 'package:flutter/material.dart';

import '../FirestoreObjects/FbPost.dart';
import '../Singletone/DataHolder.dart';

class PostView extends StatefulWidget{
  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {

  late FbPost selectedPost;

  @override
  void initState() async {
    // TODO: implement initState
    super.initState();

    selectedPost = await DataHolder().initCachedFbPost();
  }

  void loadData() async{
    setState(() async {
      selectedPost = await DataHolder().initCachedFbPost();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(title: Text(DataHolder().sNombre)),
      body: Column(
        children: [
          Text(DataHolder().selectedPost.titulo),
          Text(DataHolder().selectedPost.cuerpo),
          Image.asset("resources/logo_kyty.png", width: 100, height: 100),
          TextButton(onPressed: null, child: Text("Like"))
        ],

      ),
    );

  }
}