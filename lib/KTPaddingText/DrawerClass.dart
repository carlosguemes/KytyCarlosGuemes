import 'package:flutter/material.dart';

class DrawerClass extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Text(
                style: TextStyle(color: Colors.white),
                'Header'
            ),
          ),
          ListTile(
            selectedColor: Colors.blue,
            selected: true,
            title: const Text('Apartado 1'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Apartado 2'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

}