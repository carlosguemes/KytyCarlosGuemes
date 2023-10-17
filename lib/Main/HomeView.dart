import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyty/Interfaces/BottomMenuEvents.dart';
import 'package:kyty/KTPaddingText/BottomMenu.dart';
import 'package:kyty/KTPaddingText/DrawerClass.dart';
import 'package:kyty/KTPaddingText/GridBuilderCell.dart';
import 'package:kyty/KTPaddingText/PostCellView.dart';

import '../FirestoreObjects/FbPost.dart';

class HomeView extends StatefulWidget{

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>{
  bool bIsList = false;
  void onBottomMenuPressed(int indice) {
    setState(() {
      if (indice == 0){
        bIsList = true;
      }
      else if (indice == 1){
        bIsList = false;
      }
    });
  }

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

  /*final List<String> posts = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 200];
  final List<double> fontSize = <double>[30, 15, 70];
  final List<MaterialColor> colores = <MaterialColor>[Colors.green, Colors.amber, Colors.red];*/

  Widget? creadorDeItemLista(BuildContext context, int index){
    return PostCellView(sText: post[index].titulo,
        dFontSize: 20,
        mcColores: Colors.red);
  }

  Widget creadorDeSeparadorLista(BuildContext context, int index){
    return Divider(color: Colors.purpleAccent);
  }

  Widget creadorCeldas(BuildContext context, int index){
    return GridBuilderCell(post: post);
  }

  
  Widget celdasOLista(bool isList) {
    if (isList) {
      return ListView.separated(
          padding: EdgeInsets.all(8),
          itemCount: post.length,
          itemBuilder: creadorDeItemLista,
          separatorBuilder: creadorDeSeparadorLista,
        );
    } else {
      return /*GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            itemCount: post.length,
            itemBuilder: creadorCeldas*/
      creadorCeldas(context, post.length);
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Kyty"),),
      body: Center(
        child: celdasOLista(bIsList),
      ),
      bottomNavigationBar: BottomMenu(events: onBottomMenuPressed),

      drawer: DrawerClass()

      /*ListView.separated(
        padding: EdgeInsets.all(80),
        itemCount: post.length,
        itemBuilder: creadorDeItemLista,
        separatorBuilder: creadorDeSeparadorLista,*/
      );
  }


}