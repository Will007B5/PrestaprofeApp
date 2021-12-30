import 'package:flutter/material.dart';

class NewCreditStepOne extends StatefulWidget {

  @override
  _NewCreditStepOneState createState() => _NewCreditStepOneState();
}

class _NewCreditStepOneState extends State<NewCreditStepOne> {

  int _selectedIndex = 0;

  int _indexSliderLabel = 0;

  List<String> _creditOptions = ['Dos quincenas de 2750', 'Cuatro quincenas de 1500'];
  String _optSelectedCreditDate = 'Dos quincenas de 2750';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    final sliderLabels = ['3000', '5000', '7000'];
    final double sliderMin = 0;
    final double sliderMax = sliderLabels.length - 1.0;
    final sliderDivisions = sliderLabels.length - 1;

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
                  child: Icon(Icons.check, size: 60, color: Colors.green),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: size.width - 100),
                  child: Text('Escoge la cantidad y fechas de pago de tu préstamo',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 19.0,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("\$3000",
                    style: TextStyle(
                      color: (_indexSliderLabel == 0) ? Colors.green : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: (_indexSliderLabel == 0) ? 30.0 : 25.0,
                    ),
                  ),
                  Text("\$5000",
                    style: TextStyle(
                      color: (_indexSliderLabel == 1) ? Colors.green : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: (_indexSliderLabel == 1) ? 30.0 : 25.0,
                    ),
                  ),
                  Text("\$7000",
                    style: TextStyle(
                      color: (_indexSliderLabel == 2) ? Colors.green : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: (_indexSliderLabel == 2) ? 30.0 : 25.0,
                    ),
                  ),
                ],
              ),
            ),
            SliderTheme(
              data: SliderThemeData(
                thumbColor: Colors.green,
                activeTrackColor: Colors.grey.shade300,
                inactiveTrackColor: Colors.grey.shade300,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 20),
                tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 7),
                activeTickMarkColor: Colors.grey.shade400,
                inactiveTickMarkColor: Colors.grey.shade400
              ),
              child: Slider(
                value: _indexSliderLabel.toDouble(),
                min: sliderMin,
                max: sliderMax,
                divisions: sliderDivisions,
                onChanged: (value){
                  setState(() {
                    _indexSliderLabel = value.toInt();
                    print(_indexSliderLabel);
                  });
                },
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Fechas de pago',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 19.0,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: InputDecorator(
                          decoration: InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2.0)
                            ),
                            labelText: 'Fechas de pago'
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: _optSelectedCreditDate,
                              items: getCreditDateOptionsDropdown(),
                              onChanged: (opt){
                                setState(() {
                                  _optSelectedCreditDate = opt.toString();
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Interés 10%',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 19.0,
                        ),
                      ),
                      Text('\$500',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 19.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Total a pagar',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 19.0,
                        ),
                      ),
                      Text('\$5500',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 19.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: size.height - 577,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
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
                                Navigator.pushNamed(context, 'newCreditStepTwo');
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
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

  List<DropdownMenuItem<String>> getCreditDateOptionsDropdown(){
    List<DropdownMenuItem<String>> list = [];
    _creditOptions.forEach((gender) {
      list.add(DropdownMenuItem(
        child: Text(gender),
        value: gender,
      ));
    });
    return list;
  }

}