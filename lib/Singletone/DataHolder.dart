import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../FirestoreObjects/FbPost.dart';
import 'FirebaseAdmin.dart';

class DataHolder{
  static final DataHolder _dataHolder = new DataHolder._internal();
  FirebaseFirestore db = FirebaseFirestore.instance;

  String sNombre = "Kyty";
  late String sNombrePost;
  FbPost? selectedPost;
  FirebaseAdmin fbadmin = FirebaseAdmin();

  DataHolder._internal(){
    initCachedFbPost();
  }

  void initDataHolder(){
    /*print("DataHolder Constructor");
    sNombrePost = "Titulo de post";
    initCachedFbPost();*/
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
    }
  }

  Future<FbPost?> initCachedFbPost() async{
    if (selectedPost!=null) return selectedPost;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? titulo = prefs.getString('titulo');
    titulo??="";

    String? cuerpo = prefs.getString('cuerpo');
    cuerpo??="";

    print("SHARED PREFERENCES ---> "+ titulo);
    selectedPost=FbPost(titulo: titulo, cuerpo: cuerpo);

    return selectedPost;
  }

}
