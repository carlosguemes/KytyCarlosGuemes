import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kyty/KTPaddingText/BottomMenu.dart';
import 'package:kyty/KTPaddingText/DrawerClass.dart';
import 'package:kyty/KTPaddingText/GridBuilderCell.dart';
import 'package:kyty/KTPaddingText/PostCellView.dart';
import 'package:kyty/Singletone/DataHolder.dart';

import '../FirestoreObjects/FbPost.dart';
import '../OnBoarding/LoginView.dart';

class HomeView2 extends StatefulWidget{

  @override
  State<HomeView2> createState() => _HomeViewState2();
}

class _HomeViewState2 extends State<HomeView2>{
  FirebaseFirestore db = FirebaseFirestore.instance;
  final List<FbPost> post = [];
  bool bIsList = false;
  Map<String, FbPost> mapPosts = Map();

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

  void eventoDrawerClass(int indice){
    if (indice == 0){
      FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil (
        MaterialPageRoute (builder: (BuildContext context) => LoginView()),
        ModalRoute.withName('/loginview'),
      );
    }
  }


  @override
  void initState() {
    super.initState();
    descargarPosts();
    loadGeoLocator();
    DataHolder().subscribeACambiosGPSUsuario();
    determinarTemperaturaLocal();
  }

  void determinarTemperaturaLocal() async{
    Position position = await DataHolder().geolocAdmin.determinePosition();
    double valor = await DataHolder().httpAdmin.pedirTemperaturasEn(position.latitude, position.longitude);
    print("La temperatura en el sitio donde estás es de: " + valor.toString());
  }

  void loadGeoLocator() async {
    Position pos = await DataHolder().geolocAdmin.determinePosition();
    print("-----------> Coordenadas: " + pos.toString());
  }

  void descargarPostsOld() async{
    post.clear();
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
  }

  void descargarPosts() async{
    CollectionReference<FbPost> reference = db
        .collection("Posts")
        .withConverter(fromFirestore: FbPost.fromFirestore,
        toFirestore: (FbPost post, _) => post.toFirestore());

    reference.snapshots().listen(datosDescargados, onError: datosDescargaPostError);
    }

  void datosDescargados(QuerySnapshot<FbPost> posts) {
    for (int i = 0; i < posts.docChanges.length; i++) {
        FbPost temp = posts.docChanges[i].doc.data()!;
        mapPosts[posts.docChanges[i].doc.id] = temp;

      setState(() {
        post.clear();
        post.addAll(mapPosts.values);
      });
    }
/*
    post.clear();
    for (int i = 0; i < posts.docs.length; i++) {
      setState(() {
        post.add(posts.docs[i].data());
      });
    }
    */
  }

  void datosDescargaPostError(error){
    print("Listen failed: $error");
  }

  void onItemListaClicked(int index){
    DataHolder().selectedPost = post[index];
    DataHolder().saveSelectedPostInCache();
    Navigator.of(context).pushNamed('/postview');
    //print("El elemento de la lista que acaba de tocarse es el " + index.toString());
  }

  Widget? creadorDeItemLista(BuildContext context, int index){
    return PostCellView(sText: post[index].titulo,
      dFontSize: DataHolder().platformAdmin.getScreenWidth()*0.05,
      mcColores: Colors.blueGrey,
      iPosicion: index,
      onItemListaClickedFunction: onItemListaClicked,
    );
  }

  Widget creadorDeSeparadorLista(BuildContext context, int index){
    return Divider(color: Colors.purpleAccent);
  }

  Widget creadorCeldas(BuildContext context, int index){
    return GridBuilderCell(
      post: post,
      iPosicion: index,
      onItemListaClickedFunction: onItemListaClicked,
    );
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
      appBar: AppBar(title: Text("Kyty Móvil"),),
      body: Center(
        child: celdasOLista(bIsList),
      ),
      bottomNavigationBar: BottomMenu(events: onBottomMenuPressed),

      drawer: DrawerClass(onItemTap: eventoDrawerClass),

      floatingActionButton:FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/postcreateview");
        },
        child: Icon(Icons.add),
      ),

      /*ListView.separated(
        padding: EdgeInsets.all(80),
        itemCount: post.length,
        itemBuilder: creadorDeItemLista,
        separatorBuilder: creadorDeSeparadorLista,*/
    );
  }


}