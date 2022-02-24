import 'package:flutter/material.dart';

class NotificationsService {

  static GlobalKey<ScaffoldMessengerState> messengerKey = new GlobalKey<ScaffoldMessengerState>();

  static showSnackbar( String message, String messageType ) {
    final snackbar = new SnackBar(
      backgroundColor: messageType == 'success' ? Colors.green[300] : Colors.red,
      dismissDirection: DismissDirection.up,
      content: Text (message, style: TextStyle(color: Colors.white, fontSize: 13.5)),
    );

    messengerKey.currentState!.showSnackBar(snackbar); //No confundir este showSnackbar con el 'static showSnackbar' que es el nombre de este metodo
  }
}