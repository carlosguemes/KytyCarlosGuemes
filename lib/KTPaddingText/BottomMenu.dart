import 'package:flutter/material.dart';
import 'package:kyty/Interfaces/BottomMenuEvents.dart';

class BottomMenu extends StatelessWidget {
  Function (int indice)? events;
  BottomMenu({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(onPressed: () => events!(0), child: Icon(Icons.list,color: Colors.pink,)),
          TextButton(onPressed: () => events!(1), child: Icon(Icons.grid_view,color: Colors.pink,)),
          IconButton(onPressed: () => events!(2), icon: Image.asset("resources/logo_kyty.png"))
        ]
    );
  }
}