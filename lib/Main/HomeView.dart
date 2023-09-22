import 'package:flutter/material.dart';

class HomeView extends StatelessWidget{

  late BuildContext _context;

  void onClickVolver(){
    Navigator.of(_context).popAndPushNamed('/loginview');
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    Column columna = Column(children: [
      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
      Text("Bienvenido a Kyty", style: TextStyle(fontSize: 25)),
    Padding(
      padding:EdgeInsets.symmetric(horizontal: 700, vertical: 10),),

      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      TextButton(onPressed: onClickVolver, child: Text("Volver")),
      ],),
    ],);//Columna


    AppBar appBar = AppBar(
      title: const Text('Home'),
      centerTitle: true,
      shadowColor: Colors.blue,
      backgroundColor: Colors.black,
    );

    Scaffold scaf = Scaffold(
      body: columna,
      backgroundColor: Colors.amberAccent,
      appBar: appBar,
    );

    return scaf;
    // TODO: implement build
    throw UnimplementedError();
  }
  
}