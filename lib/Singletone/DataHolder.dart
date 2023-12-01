import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kyty/Singletone/HttpAdmin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../FirestoreObjects/FbPost.dart';
import '../FirestoreObjects/FbUsuario.dart';
import 'FirebaseAdmin.dart';
import 'GeolocAdmin.dart';
import 'PlatformAdmin.dart';

class DataHolder{
  static final DataHolder _dataHolder = new DataHolder._internal();

  String sNombre = "Kyty";
  late String sNombrePost;
  FbPost? selectedPost;
  FirebaseAdmin fbadmin = FirebaseAdmin();
  FirebaseFirestore db = FirebaseFirestore.instance;
  GeolocAdmin geolocAdmin = GeolocAdmin();
  late PlatformAdmin platformAdmin;
  HttpAdmin httpAdmin = HttpAdmin();
  FbUsuario? usuario;

  DataHolder._internal(){
    initCachedFbPost();
  }

  void initDataHolder(){
    sNombrePost = "Titulo de post";
  }

  void initPlatformAdmin(BuildContext context){
    platformAdmin = PlatformAdmin(context: context);
  }

  factory DataHolder(){
    return _dataHolder;
  }

  void crearPostEnFB(FbPost post){
    CollectionReference<FbPost> reference = db
        .collection("Posts")
        .withConverter(fromFirestore: FbPost.fromFirestore,
        toFirestore: (FbPost post, _) => post.toFirestore());

    reference.add(post);
  }

  void saveSelectedPostInCache() async{
    if (selectedPost!=null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('titulo', selectedPost!.titulo);
      prefs.setString('cuerpo', selectedPost!.cuerpo);
      prefs.setString('imagen', selectedPost!.imagen);

    }
  }

  Future<FbPost?> initCachedFbPost() async{
    if (selectedPost!=null) return selectedPost;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? titulo = prefs.getString('titulo');
    titulo??="";

    String? cuerpo = prefs.getString('cuerpo');
    cuerpo??="";

    String? imagen = prefs.getString('imagen');
    imagen??="";

    //print("SHARED PREFERENCES ---> "+ titulo);
    selectedPost=FbPost(titulo: titulo, cuerpo: cuerpo, imagen: imagen);

    return selectedPost;
  }

  Future <FbUsuario> loadFbUsuario() async {
    String uidUsuario = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<FbUsuario> reference = db
        .collection("Usuarios")
        .doc(uidUsuario)
        .withConverter(fromFirestore: FbUsuario.fromFirestore,
        toFirestore: (FbUsuario usuario, _) => usuario.toFirestore());

    DocumentSnapshot<FbUsuario> docSnap = await reference.get();
    usuario = docSnap.data()!;
    return usuario!;
  }

  void subscribeACambiosGPSUsuario(){
    geolocAdmin.registrarCambiosLoc(posicionDelMovilCambio);
  }

  void posicionDelMovilCambio(Position? posicion){
    usuario!.geoloc=GeoPoint(posicion!.latitude, posicion!.longitude);
    fbadmin.actualizarPerfilusuario(usuario!);
  }

}
