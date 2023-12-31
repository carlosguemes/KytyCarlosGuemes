import 'package:flutter/material.dart';
import 'package:kyty/Singletone/DataHolder.dart';

class PostCellView extends StatelessWidget {

  final String sText;
  final double dFontSize;
  final MaterialColor mcColores;
  final int iPosicion;
  final Function (int indice)? onItemListaClickedFunction;

  const PostCellView({super.key,
    required this.sText,
    required this.dFontSize,
    required this.mcColores,
    required this.iPosicion,
    required this.onItemListaClickedFunction
  });

  /*@override
  Widget build(BuildContext context) {
    return Text(sText,
      style: TextStyle(
          color: mcColores,
          fontSize: dFontSize),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      child: Container(
          color: mcColores,
          child: Row(
            children: [
              Image.asset("resources/logo_kyty.png",
                  width: DataHolder().platformAdmin.getScreenWidth()*0.2,
                  height: DataHolder().platformAdmin.getScreenHeight()*0.1),
              Text(sText, style: TextStyle(fontSize: dFontSize)),
              TextButton(onPressed: null,
                  child: Text("+", style: TextStyle(fontSize: dFontSize)))
            ],
          )
      ),
      onTap: () {
        onItemListaClickedFunction!(iPosicion);
        //print("Callate manin " + iPosicion.toString());
      },
    );

  }
}