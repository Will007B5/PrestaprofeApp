import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:prestaprofe/src/providers/providers.dart';
import 'package:prestaprofe/src/services/services.dart';

class AppBarHome extends StatefulWidget with PreferredSizeWidget {

  @override
  Size get preferredSize => Size.fromHeight(_toolbarHeight);

  final String _textStep;
  final double _textWidth;
  final double _toolbarHeight;

  const AppBarHome({
    Key? key, 
    required textStep, 
    required textWidth,
    required toolbarHeight
  }) : _textStep = textStep, _textWidth = textWidth, _toolbarHeight = toolbarHeight, super(key: key);

  @override
  State<AppBarHome> createState() => _AppBarHomeState();
}

class _AppBarHomeState extends State<AppBarHome> {

  @override
  Widget build(BuildContext context) {

    final _authService = Provider.of<AuthService>(context, listen: false);
    final _internetService = Provider.of<InternetService>(context);

    final _mediaQuery = MediaQuery.of(context).size;
    final _height = _mediaQuery.height;
    final _widht = _mediaQuery.width;
    final _prestalogoSize = (_height * _widht) * 0.000076;

    final _uiProvider = Provider.of<UiProvider>(context);
    final _currentIndex = _uiProvider.selectedMenuOpt;


    bool _isDiferent = _currentIndex >= 2 ? true : false ;

    return Column(
      children: [
        Visibility(
          visible: !_internetService.hasInternet,
          child: Container(
            width: double.infinity,
            color: _internetService.hasInternet ? Colors.green[300] : Colors.red, //Colors.green[300]
            child: Text(_internetService.hasInternet ? 'Conectado' : 'Sin conexión', textAlign: TextAlign.center, style: TextStyle(color: Colors.black87, fontSize: widget._textWidth * 0.75)),
          ),
        ),
        AppBar(
          automaticallyImplyLeading: true, //Quita del appbar la flecha para regresar a pagina anterior
          elevation: 0,
          // title: Container(
          //   width: 270,
          //   child: Image(
          //     image: AssetImage('assets/prestaprofehomelogowh.png'),
          //     fit: BoxFit.contain
          //   ),
          // ),
          // title: _isDiferent ? Container(
          //   width: double.infinity,
          //   child: Column(
          //     children: [
          //       widget._textStep != '' ? FittedBox(
          //         fit: BoxFit.fitWidth,
          //         child: Text(
          //           widget._textStep,
          //           style: TextStyle(
          //             fontSize: widget._textWidth,
          //             fontWeight: FontWeight.bold
          //           )
          //         ),
          //       ) : Container(),
          //     ],
          //   ),
          // )
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  width: double.infinity,
                  height: _prestalogoSize,
                  child: Image(
                    image: AssetImage('assets/prestaprofehomelogowh.png'),
                    fit: BoxFit.contain
                  ),
                ),
              ),
            ],
          ),
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.login_outlined),
          //     onPressed: () {
          //       _authService.logout();
          //       Navigator.pushReplacementNamed(context, 'login');
          //     },
          //   )
          // ],
        ),
      ],
    );
  }
}