import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:prestaprofe/src/providers/providers.dart';

class CustomHomeBottomNavigation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
      onTap: (int i) => uiProvider.selectedMenuOpt = i,
      currentIndex: currentIndex,
      elevation: 0,
      type: BottomNavigationBarType.fixed, //Para que se distribuyan todos estos items a todo el ancho del dispositivo
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Color.fromARGB(255, 238, 195, 67), //Color de item seleccionado
      backgroundColor: Color.fromRGBO(51, 114, 134, 1),
      unselectedItemColor: Colors.white,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio'
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.settings),
        //   label: 'Configuración'
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_rounded),
          label: 'Notificaciones'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.help),
          label: 'Ayuda'
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.phone),
        //   label: 'WhatsApp'
        // )
      ],
    );
  }
}