import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'KytyApp.dart';
import 'Singletone/DataHolder.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DataHolder().initDataHolder();
  runApp(KytyApp());
}

