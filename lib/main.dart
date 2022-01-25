import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';


import 'package:prestaprofe/src/pages/pages.dart';
import 'package:prestaprofe/src/providers/db_provider.dart';
import 'package:prestaprofe/src/providers/providers.dart';
import 'package:prestaprofe/src/routes/routes.dart';
import 'package:prestaprofe/src/services/services.dart';


void main() => runApp(AppState());

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => UiProvider()),
      ],
      child: MyApp()
    );
  }
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    DBProvider.db.getTodosLosScans().then(print);
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
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          color: Color.fromRGBO(51, 114, 134, 1)
        ),
        colorScheme: ColorScheme.light(
          primary: Color.fromRGBO(51, 114, 134, 1)
        ),
        fontFamily: 'Montserrat'
      ),
    );
  }
}