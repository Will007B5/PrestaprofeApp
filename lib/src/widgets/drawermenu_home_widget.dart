import 'package:flutter/material.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:provider/provider.dart';

import 'package:prestaprofe/src/services/services.dart';

class DrawermenuHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: Color.fromRGBO(51, 114, 134, 1),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DrawerHeader(),
            _DrawerItems()
          ],
        ),
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _authService = Provider.of<AuthService>(context);

    final _mediaQuerySize = MediaQuery.of(context).size; //MediaQuery con los detalles de medida de pantalla
    final _width = _mediaQuerySize.width;
    final _height = _mediaQuerySize.height;
    final _mediaquerySizedObjects = (_width * _height);
    final _avatarMediaQuery = _mediaquerySizedObjects * 0.000185;

                    //     padding: EdgeInsets.only(
                    //   top: MediaQuery.of(context).padding.top + 9,
                    //   bottom: 13,
                    //   right: 9,
                    //   left: 9
                    // ),

    return Material(
      color: Color.fromRGBO(51, 114, 134, 1),
      child: InkWell( //Es como el gesture, pero se aplica para un area rectangular que está dentro de un widget Material
        onTap: () {
          Navigator.pop(context); //Cierra este menu (ya que tambien acceder a este menu forma parte del stack de rutas)
        },
        child: Container(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image(
                  image: AssetImage('assets/homewallpaper.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 9,
                      bottom: 13,
                      right: 9,
                      left: 9
                    ),
                    child: Column(
                      children: [
                        OutlineGradientButton(
                          gradient: SweepGradient(
                            colors: [
                              Color.fromARGB(255, 107, 91, 43),
                              Color.fromARGB(255, 255, 225, 136),
                              Color.fromARGB(255, 238, 195, 67), 
                              Color.fromARGB(255, 107, 91, 43),
                              Color.fromARGB(255, 238, 195, 67), 
                              Color.fromARGB(255, 107, 91, 43),
                              Color.fromARGB(255, 255, 225, 136),
                              Color.fromARGB(255, 107, 91, 43),
                              Color.fromARGB(255, 238, 195, 67),  
                              Color.fromARGB(255, 107, 91, 43),
                              Color.fromARGB(255, 238, 195, 67), 
                              Color.fromARGB(255, 255, 225, 136),
                              Color.fromARGB(255, 107, 91, 43),
                              Color.fromARGB(255, 238, 195, 67),  
                              Color.fromARGB(255, 107, 91, 43),  
                            ],
                            center: Alignment(0.1, 0.0),
                            //focal: Alignment(0.6, -0.2),
                          ),
                          strokeWidth: 6.3,
                          radius: Radius.circular(130),
                          backgroundColor: Colors.black87,
                          child: CircleAvatar(
                            radius: (_height * _width) * 0.0002,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(130),
                              child: Image(
                                image: AssetImage('assets/logouser.jpg'),
                                fit: BoxFit.fill,
                              ),
                            )
                          ),
                        ),
                        SizedBox(height: 12),
                        Text('${_authService.currentClient.name.toUpperCase()} ${_authService.currentClient.lastName.toUpperCase()}', style: TextStyle(fontSize: _width * 0.059, color: Color.fromARGB(255, 238, 195, 67), fontWeight: FontWeight.bold), textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, maxLines: 2,),
                        SizedBox(height: 5),
                        Text('${_authService.currentClient.email}', style: TextStyle(fontSize: _width * 0.0388, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, maxLines: 2,),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerItems extends StatelessWidget {
  const _DrawerItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _authService = Provider.of<AuthService>(context);

    final _mediaQuerySize = MediaQuery.of(context).size; //MediaQuery con los detalles de medida de pantalla
    final _width = _mediaQuerySize.width;
    final _height = _mediaQuerySize.height;
    final _mediaquerySizedObjects = (_width * _height);
    final _iconMediaQuery = _mediaquerySizedObjects * 0.000097;

    return Container(
      child: Wrap(
        runSpacing: -5.0, //espaciado vertical
        children: [
          ListTile(
            leading: Icon(Icons.person, color: Color.fromRGBO(51, 114, 134, 1), size: _iconMediaQuery),
            title: Text('Mi perfil', style: TextStyle(color: Colors.black87, fontSize: _width * 0.041), textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, maxLines: 2,),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.credit_card_rounded, color: Color.fromRGBO(51, 114, 134, 1), size: _iconMediaQuery),
            title: Text('Administrar tarjetas', style: TextStyle(color: Colors.black87, fontSize: _width * 0.041), textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, maxLines: 2,),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.lock_rounded, color: Color.fromRGBO(51, 114, 134, 1), size: _iconMediaQuery),
            title: Text('Límites', style: TextStyle(color: Colors.black87, fontSize: _width * 0.041), textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, maxLines: 2,),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.groups_rounded, color: Color.fromRGBO(51, 114, 134, 1), size: _iconMediaQuery),
            title: Text('Sobre nosotros', style: TextStyle(color: Colors.black87, fontSize: _width * 0.041), textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, maxLines: 2,),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.local_post_office_rounded, color: Color.fromRGBO(51, 114, 134, 1), size: _iconMediaQuery),
            title: Text('Quejas del usuario', style: TextStyle(color: Colors.black87, fontSize: _width * 0.041), textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, maxLines: 2,),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.assignment_rounded, color: Color.fromRGBO(51, 114, 134, 1), size: _iconMediaQuery),
            title: Text('Términos', style: TextStyle(color: Colors.black87, fontSize: _width * 0.041), textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, maxLines: 2,),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.info, color: Color.fromRGBO(51, 114, 134, 1), size: _iconMediaQuery),
            title: Text('Información de la app', style: TextStyle(color: Colors.black87, fontSize: _width * 0.041), textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, maxLines: 2,),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.logout_rounded, color: Color.fromRGBO(51, 114, 134, 1), size: _iconMediaQuery),
            title: Text('Cerrar sesión', style: TextStyle(color: Colors.black87, fontSize: _width * 0.041), textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, maxLines: 2,),
            onTap: () {
              _authService.logout();
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
        ],
      ),
    );
  }
}