import 'package:flutter/material.dart';
import 'package:prestaprofe/src/pages/pages.dart';
import 'package:prestaprofe/src/services/services.dart';
import 'package:provider/provider.dart';

class CheckAuthPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false); //Listen en false por que este widget no se necesita redibujar
    final clientService = Provider.of<ClientsService>(context);
    
    return Scaffold(
      body: Center(
        //Un future builder para construir los widgtes dependiendo de la respuesta de los futures
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot){
            //snapshot es la respuesta
            if(!snapshot.hasData){
              return Text('');
            }

            if( snapshot.data == '' ){
              //Este future microtask ejecuta codigo tan pronto la construccion de este widget termine
              Future.microtask((){
                //Navigator.of(context).pushReplacementNamed('home');
                Navigator.pushReplacement(context, PageRouteBuilder(//Para crear animacion al redirigir a la pagina (transicion)
                  pageBuilder: ( _ , __ , ___ ) => LoginPage(),
                  transitionDuration: Duration(seconds: 0)
                ));
              });
            }
            else{
              //Este future microtask ejecuta codigo tan pronto la construccion de este widget termine
              Future.microtask(() async {
                final response = await authService.assignCurrentClient();
                if(response == 200){
                  //Navigator.of(context).pushReplacementNamed('home');
                  Navigator.pushReplacement(context, PageRouteBuilder(//Para crear animacion al redirigir a la pagina (transicion)
                    pageBuilder: ( _ , __ , ___ ) => HomePage(),
                    transitionDuration: Duration(seconds: 0)
                  ));
                }
              });
            }

            return Container();
          },
        ),
      ),
    );
  }
}