import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:prestaprofe/src/providers/json_menuoptions_provider.dart';
import 'package:prestaprofe/src/routes/routes.dart';
import 'package:prestaprofe/src/pages/error_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    jsonMenuOptionsProvider.loadOptions(); //Carga las rutas del options.json
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
      initialRoute: '/',
      routes: getAppRoutes(),
      //Regresa una ruta dinamica por defecto (de cualquier tipo)
      onGenerateRoute: (RouteSettings settings){
        return MaterialPageRoute(
          builder: (BuildContext context) => ErrorPage()
        );
      },
      //Agrega un tema general para la aplicación
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          color: Color.fromRGBO(51, 114, 134, 1)
        )
      ),
    );
  }
}