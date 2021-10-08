import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, //Quita del appbar la flecha para regresar a pagina anterior
        title: Container(
          width: 270,
          child: Image(
            image: AssetImage('assets/prestaprofehomelogowh.png'),
            fit: BoxFit.contain
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              color: Color.fromRGBO(191, 155, 48, 1),
              width: double.infinity,
              height: size.height,
            ),
            Container(
              color: Color.fromRGBO(51, 114, 134, 1),
              width: double.infinity,
              height: size.height * 0.37,
            ),
            Positioned(
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.symmetric(vertical: 7)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: Image(
                      image: AssetImage('assets/logouser.jpg'),
                      fit: BoxFit.fill,
                      height: size.height * 0.2,
                      width: size.width * 0.35,
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  Text('Hola, Juan',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Card(
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 27),
                            child: Text(
                              "¿Qué quieres hacer?",
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Color.fromRGBO(51, 114, 134, 1)
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 1),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              GestureDetector(
                                onTap: (){
                                  Navigator.pushNamed(context, 'newCredit');
                                },
                                child: Container(
                                  width: size.height * 0.22,
                                  child: Column(
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(150),
                                        child: Image(
                                          image: AssetImage('assets/logouser.jpg'),
                                          fit: BoxFit.fill,
                                          height: size.height * 0.16,
                                          width: size.width * 0.29,
                                          color: Color.fromRGBO(51, 114, 134, 0.9)
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                                      Text('Solicitar nuevo préstamo',
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Color.fromRGBO(51, 114, 134, 1),
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: size.height * 0.22,
                                child: Column(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(150),
                                      child: Image(
                                        image: AssetImage('assets/logouser.jpg'),
                                        fit: BoxFit.fill,
                                        height: size.height * 0.16,
                                        width: size.width * 0.29,
                                        color: Color.fromRGBO(51, 114, 134, 0.9)
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                                    Text('Mis préstamos',
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Color.fromRGBO(51, 114, 134, 1),
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 13.5)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: size.height * 0.22,
                                child: Column(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(150),
                                      child: Image(
                                        image: AssetImage('assets/logouser.jpg'),
                                        fit: BoxFit.fill,
                                        height: size.height * 0.16,
                                        width: size.width * 0.29,
                                        color: Color.fromRGBO(51, 114, 134, 0.9)
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                                    Text('Estadísticas generales',
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Color.fromRGBO(51, 114, 134, 1),
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.symmetric(vertical: 19)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ]
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 35),
            label: 'Inicio',
            backgroundColor: Color.fromRGBO(51, 114, 134, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 35),
            label: 'Configuración',
            backgroundColor: Color.fromRGBO(51, 114, 134, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.email, size: 35),
            label: 'Email',
            backgroundColor: Color.fromRGBO(51, 114, 134, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_rounded, size: 35),
            label: 'Chat',
            backgroundColor: Color.fromRGBO(51, 114, 134, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.web_asset, size: 35),
            label: 'WhatsApp',
            backgroundColor: Color.fromRGBO(51, 114, 134, 1),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(191, 155, 48, 1),
        onTap: _onItemTapped,
      ),
    );
  }
}