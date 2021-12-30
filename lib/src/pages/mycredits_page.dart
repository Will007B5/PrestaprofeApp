import 'package:flutter/material.dart';

class MyCredits extends StatefulWidget {
  MyCredits({Key? key}) : super(key: key);

  @override
  _MyCreditsState createState() => _MyCreditsState();
}

class _MyCreditsState extends State<MyCredits> {

  int _selectedIndex = 0;

  double _sliderValue = 0;  

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
      body: SafeArea(
        bottom: false,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 13),
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Text('Juan',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                )
              ),
              SizedBox(height: 5),
              Icon(Icons.info, size: 60, color: Colors.green),
              SizedBox(height: 5),
              Text('Actualmente cuentas con el siguiente préstamo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                )
              ),
              SizedBox(height: 50),
              Text('\$5,000.00',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                )
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Debes liquidar antes de: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    )
                  ),
                  Text('27/10/2021',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    )
                  ),
                ],
              ),
              Expanded(child: Container()),
              ElevatedButton(
                child: Text(
                  'Continuar', 
                  style: TextStyle(
                    color: Colors.white
                  )
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                onPressed: (){
                  Navigator.pushNamed(context, 'home');
                },
              ),
            ],
          ),
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