import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:prestaprofe/src/services/services.dart';

// SHA1: 28:50:63:D6:0B:DA:91:F8:03:C2:A3:7F:91:AD:48:A0:D0:2F:D3:36
//Se instala paquete de FCM y Firebase Core
//Foreground: Cuando la app esta en primer plano
//Background: Cuando la app esta en segundo plano
//Cuando la app está cerrada

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance; //Obtiene la instancia de FCM Remoto
  static String? _token;
  static StreamController<String> _messageStreamController = new StreamController.broadcast(); //Con este stream escuchamos cambios en los widgets que queramos
  static Stream<String> get messagesStream => _messageStreamController.stream; //Con este get el usuario se va a poder suscribir al stream y solo va a ver el flujo de informacion de la notificacion
  static String? get token => _token;
  //App en segundo plano
  static Future _onBackgroundHandler (RemoteMessage message) async {
    // print('onBackground handler ${message.messageId}');
    // _messageStreamController.add(message.notification?.title ?? 'Sin titulo');
    _messageStreamController.add(message.data['data'] ?? 'No data');
  }

  //App en primer plano
  static Future _onMessageHandler (RemoteMessage message) async {
    // print('onMessageHandler handler ${message.messageId}');
    // _messageStreamController.add(message.notification?.title ?? 'Sin titulo');
    _messageStreamController.add(message.data['data'] ?? 'No data');
  }

  //App terminada
  static Future _onMessageOpenApp (RemoteMessage message) async {
    // print('onMessageOpenApp handler ${message.messageId}');
    // _messageStreamController.add(message.notification?.title ?? 'Sin titulo');
    _messageStreamController.add(message.data['data'] ?? 'No data');
  }

  //Verifica si el token no es nulo, entonces lo guarda en la bd
  static Future<void> saveTokenToDatabase(String? token) async{
    if(token != null){
      await AuthService.passFCMTokenToAuthService(token);
    }
  }

  static Future initializeApp() async {
    // Push Notifications
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
    _token = await FirebaseMessaging.instance.getToken();
    
    print(_token); //En este punto mediante una peticion HTTP se puede grabar en el backend en la bd de Prestaprofe
    
    // Cada vez que el token se refresca, se guarda en la base de datos
    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);

    // It is important to remember a user can have many tokens (from multiple devices, or token refreshes), 
    // therefore we use FieldValue.arrayUnion to store new tokens. When a message is sent via an admin SDK, 
    // invalid/expired tokens will throw an error allowing you to then remove them from the database.

    //Handlers
    FirebaseMessaging.onBackgroundMessage(_onBackgroundHandler); //App en segundo plano
    FirebaseMessaging.onMessage.listen(_onMessageHandler); //App en primer plano
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp); //App terminada


    //Local Notifications
  }

  static closeStreams(){
    _messageStreamController.close();
  }

}