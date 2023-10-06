import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyty/KTPaddingText/PostCellView.dart';

import '../FirestoreObjects/FbPost.dart';

class HomeView extends StatefulWidget{

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late BuildContext _context;

  FirebaseFirestore db = FirebaseFirestore.instance;
  final List<FbPost> post = [];

  @override
  void initState() {
    descargarPosts();
    super.initState();
  }

  void descargarPosts() async{
    CollectionReference<FbPost> reference = db
        .collection("Posts")
        .withConverter(fromFirestore: FbPost.fromFirestore,
        toFirestore: (FbPost post, _) => post.toFirestore());

    QuerySnapshot<FbPost> querySnap = await reference.get();
    for (int i = 0; i < querySnap.docs.length; i++){
      setState(() {
        post.add(querySnap.docs[i].data());
      });

    }

    //FbPost post = docSnap.data()!;
  }

  final List<String> posts = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 200];
  final List<double> fontSize = <double>[30, 15, 70];
  final List<MaterialColor> colores = <MaterialColor>[Colors.green, Colors.amber, Colors.red];

  Widget? creadorDeItemLista(BuildContext context, int index){
    return PostCellView(sText: post[index].titulo,
        dFontSize: 20,
        mcColores: Colors.red);
  }

  Widget creadorDeSeparadorLista(BuildContext context, int index){
    return Divider(color: Colors.purpleAccent,);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Kyty"),),
      body: ListView.separated(
        padding: EdgeInsets.all(80),
        itemCount: post.length,
        itemBuilder: creadorDeItemLista,
        separatorBuilder: creadorDeSeparadorLista,
      ),
    );
  }
}