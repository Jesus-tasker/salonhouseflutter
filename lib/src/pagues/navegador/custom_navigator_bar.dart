import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:salonhouse/src/providers/navegationbar/ui_provider.dart';

class CustomNavigatorBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiprovider = Provider.of<Ui_provider>(context);
    //Provider.of<Ui_provider>(context); //seleccion en UIprovider

    final currentidex = uiprovider.selectedMneuopt; //posicion en las paginas

    return BottomNavigationBar(
      selectedItemColor: Colors.orangeAccent[200],
      unselectedItemColor: Colors.white,
      backgroundColor: Colors.black87,
      onTap: (int i) {
        uiprovider.selectedMneuopt = i;
        //print(i); //muestra 0 o 1 de pla pantalla.
      },

      /// => uiprovider.selectedMneuopt = i,
      currentIndex: currentidex,
      elevation: 0,
      items: [
        BottomNavigationBarItem(
          // icon: Icon(Icons.shopping_cart, color: Colors.orange[200]),
          //
          icon: Icon(
            Icons.shopping_cart,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.delivery_dining),
          label: 'Pedidos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.video_collection),
          label: 'Tendencia',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bike_scooter),
          label: 'bike',
        ),
      ],
    );
  }
}

class CustomNavigatorBar_clinete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiprovider = Provider.of<Ui_provider>(context);
    //Provider.of<Ui_provider>(context); //seleccion en UIprovider

    final currentidex = uiprovider.selectedMneuopt; //posicion en las paginas

    return BottomNavigationBar(
      selectedItemColor: Colors.orangeAccent[200],
      unselectedItemColor: Colors.white,
      backgroundColor: Colors.black87,
      onTap: (int i) {
        uiprovider.selectedMneuopt = i;
        //print(i); //muestra 0 o 1 de pla pantalla.
      },

      /// => uiprovider.selectedMneuopt = i,
      currentIndex: currentidex,
      elevation: 0,
      items: [
        BottomNavigationBarItem(
          // icon: Icon(Icons.shopping_cart, color: Colors.orange[200]),
          //
          icon: Icon(
            Icons.shopping_cart,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.delivery_dining),
          label: 'Pedidos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.video_collection),
          label: 'Tendencia',
        ),
      ],
    );
  }
}
