import 'package:flutter/material.dart';

class NewCreditStepTwo extends StatefulWidget {
  NewCreditStepTwo({Key? key}) : super(key: key);

  @override
  _NewCreditStepTwoState createState() => _NewCreditStepTwoState();
}

class _NewCreditStepTwoState extends State<NewCreditStepTwo> {

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
    const TextStyle styleHeaderColum = TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.bold,
      color: Colors.black
    );
    const TextStyle styleTextTableRow = TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.green
    );
    const TextStyle styleHeaderColum2 = TextStyle(
      fontSize: 17,
      color: Colors.black
    );

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
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            Text('Juan',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.info, size: 60, color: Colors.orange),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: size.width - 100),
                  child: Text('Revisa los detalles de tu préstamo',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 19.0,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Table(
              children: [
                TableRow(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Prestamo', style: styleHeaderColum),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Interés', style: styleHeaderColum),
                      ],
                    )
                  ]
                ),
                TableRow(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('\$5000', style: styleTextTableRow),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('\$500', style: styleTextTableRow),
                      ],
                    )
                  ]
                ),
                TableRow(
                  children: [
                    SizedBox(height: 10),
                    SizedBox(height: 10),
                  ]
                ),
                TableRow(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Total a pagar', style: styleHeaderColum),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Tasa mensual', style: styleHeaderColum),
                      ],
                    )
                  ]
                ),
                TableRow(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('\$5500', style: styleTextTableRow),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('10%', style: styleTextTableRow),
                      ],
                    )
                  ]
                ),
              ],
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 15), child: Text('Fechas de pago', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 21))),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Table(
                children: [
                  TableRow(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Pago', style: styleHeaderColum2),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Fecha', style: styleHeaderColum2),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Cantidad a pagar', style: styleHeaderColum2),
                        ],
                      )
                    ]
                  ),
                  TableRow(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('1/2', style: styleHeaderColum2),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('22/09/2021', style: styleHeaderColum2),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('\$2750', style: styleHeaderColum2),
                        ],
                      )
                    ]
                  ),
                  TableRow(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('2/2', style: styleHeaderColum2),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('07/10/2021', style: styleHeaderColum2),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('\$2750', style: styleHeaderColum2),
                        ],
                      )
                    ]
                  )
                ],
              ),
            ),
            Expanded(child: Container()),
            ElevatedButton(
              child: Text(
                'Solicitar préstamo', 
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