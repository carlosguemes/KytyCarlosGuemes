import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../FirestoreObjects/FbPost.dart';

class DataHolder{
  static final DataHolder _dataHolder = new DataHolder._internal();
  FirebaseFirestore db = FirebaseFirestore.instance;

  String sNombre = "Kyty";
  late String sNombrePost;
  late FbPost selectedPost;

  DataHolder._internal(){
    sNombrePost = "Titulo de post";
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

  void initCachedFbPost() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? titulo = prefs.getString('titulo');
    titulo??="";

    String? cuerpo = prefs.getString('cuerpo');
    cuerpo??="";

    selectedPost = FbPost(titulo: titulo, cuerpo: cuerpo);
  }

}
