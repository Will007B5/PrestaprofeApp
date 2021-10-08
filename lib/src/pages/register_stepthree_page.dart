import 'package:flutter/material.dart';

class StepThree extends StatefulWidget {

  @override
  _StepThreeState createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: _createWidgets(size),
      ),
    );
  }

  List<Widget> _createWidgets(size){
    final List<Widget> widgets = [
      Container(
        width: double.infinity,
        height: size.height * 0.19,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
            ),
            Text(
              'REGISTRO', 
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold
              )
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 3.0),
            ),
            Text(
              'Verifica tu identidad',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold

              )
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 3.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(Icons.looks_one, size: 45.0, color: Colors.green),
                Icon(Icons.looks_two, size: 45.0, color: Colors.green),
                Icon(Icons.looks_3, size: 45.0, color: Colors.green),
              ],
            )
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
            Text('Ahora, es importante verificar tu teléfono',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold
              )
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: TextField(
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0)
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: Text(
                    'Enviar código', 
                    style: TextStyle(
                      color: Colors.white
                    )
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: (){
                    
                  },
                ),
              ],
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 15.0)),
            Text('Te hemos enviado un SMS con el codigo de verificación que tendrás que ingresar a continuación',
              style: TextStyle(
                  fontSize: 15.0,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
            Container(
              width: double.infinity,
              height: size.height * 0.13,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Card(
                    elevation: 0,
                    shape:  RoundedRectangleBorder(			//Card with stadium border
                      side: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 9.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('9',
                            style: TextStyle(
                                fontSize: 40.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    shape:  RoundedRectangleBorder(			//Card with stadium border
                      side: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 9.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('9',
                            style: TextStyle(
                                fontSize: 40.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    shape:  RoundedRectangleBorder(			//Card with stadium border
                      side: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 9.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('9',
                            style: TextStyle(
                                fontSize: 40.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    shape:  RoundedRectangleBorder(			//Card with stadium border
                      side: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 9.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('9',
                            style: TextStyle(
                                fontSize: 40.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    shape:  RoundedRectangleBorder(			//Card with stadium border
                      side: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 9.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('9',
                            style: TextStyle(
                                fontSize: 40.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    shape:  RoundedRectangleBorder(			//Card with stadium border
                      side: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 9.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('9',
                            style: TextStyle(
                                fontSize: 40.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 37.0),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          ElevatedButton(
            child: Text(
              'Finalizar', 
              style: TextStyle(
                color: Colors.white
              )
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
            ),
            onPressed: (){
              Navigator.pushNamed(context, '/');
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
          ),
        ],
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
      ),
    ];
    return widgets;
  }
}