import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
// import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';


import 'package:prestaprofe/src/pages/pages.dart';
import 'package:prestaprofe/src/models/models.dart';
import 'package:prestaprofe/src/providers/providers.dart';
import 'package:prestaprofe/src/routes/routes.dart';
import 'package:prestaprofe/src/services/services.dart';


void main() => runApp(AppState());

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CustomCameraProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => NewCreditFormProvider(
          new LoanModel(
            amount: 0.0, 
            paymentSchema: 'monthly',
            cardId: 1, 
            userId: 1
          )
        )),
        ChangeNotifierProvider(create: (_) => DBProvider(
          new StateModel(id: 1, name: 'Aguascalientes', code: '01'),
          new MunicipalityModel(id: 1, name: 'Aguascalientes', code: '001', stateId: 1),
          new CityModel(id: 1, name: 'Zona Centro', zipCode: '20000', municipalityId: 1)
        )),
        ChangeNotifierProvider(create: (_) => RegisterFormProvider(
          new ClientModel(
            name: '', 
            lastName: '', 
            birthDate: DateTime.now(), 
            gender: 'Hombre', 
            civilStatus: 'Soltero/a', 
            curp: '', 
            address: '', 
            salaryId: 1, 
            phone: '', 
            email: '',
            password: '', 
            rfc: '', 
            firstReferencePersonName: '', 
            firstReferencePersonPhone: '', 
            secondReferencePersonName: '', 
            secondReferencePersonPhone: '', 
            cityId: 1,
            jobId: 1, 
            ine: '', 
            ineBack: '', 
            payStub: '', 
            selfie: '', 
            proofAddress: ''
          )
        )),
        ChangeNotifierProvider(create: (_) => ClientsService(), lazy: false), //lazy false para que pueda correr al momento de ejecutar la app
        ChangeNotifierProvider(create: (_) => JobsService(), lazy: false),
        ChangeNotifierProvider(create: (_) => SalariesService() , lazy: false),
        ChangeNotifierProvider(create: (_) => CardsService() , lazy: false),
        ChangeNotifierProvider(create: (_) => LoansService() , lazy: false),
      ],
      child: MyApp()
    );
  }
}

class MyApp extends StatelessWidget {

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