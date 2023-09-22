import 'package:flutter/material.dart';
import 'package:kyty/Splash/SplashView.dart';
import 'Main/HomeView.dart';
import 'OnBoarding/LoginView.dart';
import 'OnBoarding/RegisterView.dart';

class KytyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    MaterialApp materialApp = MaterialApp(title: "KyTy Miau!",
      routes: {
        '/loginview':(context) => LoginView(),
        '/registerview':(context) => RegisterView(),
        '/homeview':(context) => HomeView(),
        '/splashview':(context) => SplashView(),
      },
      initialRoute: '/splashview',
    );

    return materialApp;
  }

}