import '../FirestoreObjects/FbPost.dart';

class DataHolder{
  static final DataHolder _dataHolder = new DataHolder._internal();

  String sNombre = "Kyty";
  late String sNombrePost;
  late FbPost selectedPost;

  DataHolder._internal(){
    sNombrePost = "Titulo de post";
  }

  factory DataHolder(){
    return _dataHolder;
  }

}
