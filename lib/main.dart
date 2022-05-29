import 'dart:async';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:prestaprofe/src/models/models.dart';
import 'package:prestaprofe/src/pages/pages.dart';
import 'package:prestaprofe/src/providers/providers.dart';
import 'package:prestaprofe/src/routes/routes.dart';
import 'package:prestaprofe/src/services/services.dart';
import 'package:prestaprofe/src/ui/prestaprofe_theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Metodo que asegura que despues de lo que se ejecuta en esta linea ya hay un context listo para usar
  await DeviceInfoService.initializeDeviceInfo(); //Inicializa la información del dispositivo para estar globalmente consumible
  // await PushNotificationService.initializeApp();
  //await SocketNotificationService.initNotificationService(2);
  runApp(AppState());
}

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => DBProvider(StateModel.cleanState(), MunicipalityModel.cleanMunicipality(), CityModel.cleanMunicipality())),
        ChangeNotifierProvider(create: (_) => CardFormProvider(new CardModel(userId: 0)), lazy: false), //lazy false para que pueda correr al momento de ejecutar la app
        ChangeNotifierProvider(create: (_) => NewCreditFormProvider(LoanModel.cleanLoan())),
        ChangeNotifierProvider(create: (_) => RegisterFormProvider(ClientModel.cleanClient())),
        ChangeNotifierProvider(create: (_) => ClientsService(), lazy: false), //lazy false para que pueda correr al momento de ejecutar la app
        ChangeNotifierProvider(create: (_) => JobsService(), lazy: false), //lazy false para que pueda correr al momento de ejecutar la app
        ChangeNotifierProvider(create: (_) => SalariesService() , lazy: false), //lazy false para que pueda correr al momento de ejecutar la app
        ChangeNotifierProvider(create: (_) => CardsService() , lazy: false), //lazy false para que pueda correr al momento de ejecutar la app
        ChangeNotifierProvider(create: (_) => LoansService() , lazy: false), //lazy false para que pueda correr al momento de ejecutar la app
        ChangeNotifierProvider(create: (_) => InternetService() , lazy: false), //lazy false para que pueda correr al momento de ejecutar la app
      ],
      child: MyApp()
    );
  }
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Aqui ya hay accesso al context
    //Getter messagesStream
    // PushNotificationService.messagesStream.listen((message) { 
    //   print('PrestaprofeApp ${message}');
    // });

    // SocketNotificationService.messagesStream.listen((message) { 
    //   print('PrestaprofeApp ${message}');
    // });

    final _internetService = Provider.of<InternetService>(context, listen: false);

    //Clase custom InternetService que hace uso de clase InternetChecker
    _internetService.onStatusChange();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    final _internetService = Provider.of<InternetService>(context, listen: false);
    _internetService.closeInternetStream(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print(ReferenceGenerator.makeReference(freePositions: '9', limitDateNumber: 40322, amountNumber: 130160));
    return MaterialApp(
      title: 'Prestaprofe',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', 'US'), // English, no country code
        Locale('es', 'ES'), // Spanish, no country code
      ],
      //Configuración de rutas
      initialRoute: 'checking',
      routes: getAppRoutes(),
      scaffoldMessengerKey: NotificationsService.messengerKey,
      //Regresa una ruta dinamica por defecto (de cualquier tipo)
      onGenerateRoute: (RouteSettings settings){
        return MaterialPageRoute(
          builder: (BuildContext context) => ErrorPage()
        );
      },
      //Agrega un tema general para la aplicación
      theme: PrestaprofeTheme.prestaprofeTheme(), //Este es un customTheme en ui/prestaprofeTheme.dart
    );
  }
}