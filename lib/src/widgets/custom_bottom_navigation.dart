import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:prestaprofe/src/providers/providers.dart';

class CustomBottomNavigation extends StatelessWidget {

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
      selectedItemColor: Color.fromRGBO(191, 155, 48, 1), //Color de item seleccionado
      backgroundColor: Color.fromRGBO(51, 114, 134, 1),
      unselectedItemColor: Color.fromRGBO(255, 255, 255, 1),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Configuración'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.email),
          label: 'Email'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_rounded),
          label: 'Chat'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.web_asset),
          label: 'WhatsApp'
        )
      ],
    );
  }
}