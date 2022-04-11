import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:prestaprofe/src/pages/pages.dart';
import 'package:prestaprofe/src/providers/providers.dart';
import 'package:prestaprofe/src/services/services.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mediaQuerySize = MediaQuery.of(context).size; //MediaQuery con los detalles de medida de pantalla
    final _height = _mediaQuerySize.height;
    final _width = _mediaQuerySize.width;
    final _textInfoWidth = _width * 0.055; //Medida de la fuente a utilizar en la barra de estado

    String _textStep = '';

    final _uiProvider = Provider.of<UiProvider>(context);
    final _authService = Provider.of<AuthService>(context, listen: false);
    final _currentIndex = _uiProvider.selectedMenuOpt;

    final _internetService = Provider.of<InternetService>(context);

    double _toolbarHeight = _internetService.hasInternet ? kToolbarHeight : (kToolbarHeight + 19);

    switch (_currentIndex) {
      case 0:
        _textStep = '';
        break;
      case 1:
        _textStep = '';
        break;
      case 2:
        _textStep = 'AYUDA';
        break;
    }

    return WillPopScope(
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBarHome(
            textStep: _textStep,
            textWidth: _textInfoWidth,
            toolbarHeight: _toolbarHeight
          ), //Widget en carpeta Widgets
          endDrawer: DrawermenuHome(),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            child: _constructHomeBody(context),
          ),
          bottomNavigationBar: CustomHomeBottomNavigation(), //Widget en carpeta Widgets
          // persistentFooterButtons: [
          //   Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Container(
          //         //color: Colors.red,
          //         width: double.infinity,
          //         child: Text('No hay Internet', textAlign: TextAlign.center),
          //       )
          //     ],
          //   )
          // ],
          // persistentFooterButtons: [
          //   Container( //Para tener el banner fixed al bottom
          //     width: double.infinity,
          //     height: _height / 11,
          //     padding: const EdgeInsets.all(0), //<-- this
          //     color: Colors.white,
          //     child: Image(
          //       image: AssetImage('assets/banner.jpg'),
          //       fit: BoxFit.fill
          //     ),
          //   )
          // ]
        ),
      ),
      onWillPop: () async {
        if (Navigator.canPop(context)) {
          //Verifica si hay rutas por sacar de la pila; esto es principalmente si se tiene abierto el menu drawer
          Navigator.of(context).popUntil(ModalRoute.withName('home'));
          return false;
        }
        final bool _logoutAndReturnLogin = await _showLogoutAndReturnLogin(context);
        if (_logoutAndReturnLogin) {
          _authService.logout();
          Navigator.pushReplacementNamed(context, 'login');
        }
        return _logoutAndReturnLogin;
      },
    );
  }

  //Widget que muestra la paginas seleccionables del bottom navigation
  Widget _constructHomeBody(BuildContext context) {
    final _uiProvider = Provider.of<UiProvider>(context);
    final _currentIndex = _uiProvider.selectedMenuOpt;

    switch (_currentIndex) {
      case 0:
        return DashboardPage();
      case 2:
        return HelpPage();
      default:
        return DashboardPage();
    }
  }

  Future<bool> _showLogoutAndReturnLogin(BuildContext context) async {
    bool _isTueOrFalse = false;
    await showDialog(
      context: context,
      builder: (context) => WillPopScope(
        child: AlertDialog(
          title: Text('¿Desea cerrar sesión?'),
          actions: [
            TextButton(
              child: Text('No'),
              onPressed: () {
                _isTueOrFalse = false;
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Si'),
              onPressed: () {
                _isTueOrFalse = true;
                Navigator.pop(context);
              },
            ),
          ],
        ),
        onWillPop: () async {
          return false;
        },
      ),
      barrierDismissible: false
    );
    print(_isTueOrFalse);
    return _isTueOrFalse;
  }
}
