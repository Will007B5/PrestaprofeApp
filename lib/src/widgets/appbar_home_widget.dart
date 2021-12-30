import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:prestaprofe/src/services/services.dart';

class AppBarHome extends StatelessWidget with PreferredSizeWidget{

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {

    final _authService = Provider.of<AuthService>(context, listen: false);

    return AppBar(
      automaticallyImplyLeading: true, //Quita del appbar la flecha para regresar a pagina anterior
      title: Container(
        width: 270,
        child: Image(
          image: AssetImage('assets/prestaprofehomelogowh.png'),
          fit: BoxFit.contain
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.login_outlined),
          onPressed: () {
            _authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        )
      ],
    );
  }
}