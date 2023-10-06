import 'package:cloud_firestore/cloud_firestore.dart';

class FbUsuario{

  final String nombre;
  final int edad;
  final double altura;
  final String colorPelo;

  FbUsuario({
    required this.nombre,
    required this.edad,
    required this.altura,
    required this.colorPelo
  });

  factory FbUsuario.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FbUsuario(
      nombre: data?['Nombre'],
      edad: data?['Edad'],
      altura: data?['Altura'],
      colorPelo: data?['colorPelo']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nombre != null) "Nombre": nombre,
      if (edad != null) "Edad": edad,
      if (altura != null) "Altura": altura,
      if (colorPelo != null) "colorPelo" : colorPelo,
    };
  }

}