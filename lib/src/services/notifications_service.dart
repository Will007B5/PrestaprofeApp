import 'package:flutter/material.dart';

class NotificationsService {

  static GlobalKey<ScaffoldMessengerState> messengerKey = new GlobalKey<ScaffoldMessengerState>();

  static showSnackbar( String message ) {
    final snackbar = new SnackBar(
      backgroundColor: Colors.red,
      dismissDirection: DismissDirection.up,
      content: Text (message, style: TextStyle(color: Colors.white, fontSize: 18)),
    );

    messengerKey.currentState!.showSnackBar(snackbar); //No confundir este showSnackbar con el 'static showSnackbar' que es el nombre de este metodo
  }
}