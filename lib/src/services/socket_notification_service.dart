import 'dart:async';

import 'package:pusher_client/pusher_client.dart';
import 'package:laravel_echo/laravel_echo.dart';

class SocketNotificationService {

  static late PusherClient _pusherClient;
  static late Echo _echo;

  static final StreamController<String> _messageStreamController = StreamController.broadcast(); //Con este stream escuchamos cambios en los widgets que queramos
  static Stream<String> get messagesStream => _messageStreamController.stream; //Con este get el usuario se va a poder suscribir al stream y solo va a ver el flujo de informacion de la notificacion

  static const String _appKey = 'prestaprofeweb';
  static const int _wsPort = 6001;
  static const String _host = '192.168.1.73';
  static const String _authEndpoint = 'http://$_host:8000/broadcasting/auth';
  static final Map<String, String>? _headers = {
    'Content-Type'  : 'application/json',
    'Authorization' : 'Bearer 3|uaOBhIZKW1C1mYyHUG0epSKAycW7JrS43iy3nxvX',
    'Accept'        : '*/*'
  };

  static final Map<String, dynamic>? _echoOptions = {
    'enabledTransports': ['ws', 'wss']
  };

  //Escuchando
  static Future _onListening (message) async {
    // print('Mensaje capturado ${message.data}');
    _messageStreamController.add(message.data ?? 'No data');
  }

  static Future<void> initNotificationService(int idUser) async {
    PusherOptions options = PusherOptions(
      //El cluster para app flutter no se pone
      //Crear network_secutiry_config xml android
        wsPort: _wsPort,
        host: _host,
        encrypted: false,
        auth: PusherAuth(
          _authEndpoint,
          headers: _headers,
        ),
    );

    try {

      _pusherClient = await PusherClient(_appKey, options, enableLogging: true, autoConnect: false);

      _echo = await Echo(broadcaster: EchoBroadcasterType.Pusher, client: _pusherClient, options: _echoOptions);

      _echo.connect();

      _echo.private('DailyLoanChannel.${idUser.toString()}').listen('NotificationNextPay', _onListening);

    } catch (e) {

      print("socket exception zaid");
      print(e.toString());
      
    }
  }

  static Future<void> disposeNotificationService() async {
    _echo.disconnect();
  }

  void closeMessageStreams(){
    _messageStreamController.close();
  }

}