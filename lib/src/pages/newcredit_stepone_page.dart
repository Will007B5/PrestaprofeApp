import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:group_button/group_button.dart';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:prestaprofe/src/services/services.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';

class NewCreditStepOne extends StatelessWidget {

  int _selectedIndex = 0;

  int _indexSliderLabel = 0;

  List<String> _creditOptions = ['Dos quincenas de 2750', 'Cuatro quincenas de 1500'];
  String _optSelectedCreditDate = 'Dos quincenas de 2750';

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBarHome(), //Widget en carpeta Widgets 
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: _constructNewCreditBody(context),
            )
          ]
        )
      ),
      bottomNavigationBar: CustomBottomNavigation(), //Widget en carpeta Widgets 
    );
  }

  Widget _constructNewCreditBody(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size;
    final _width = _mediaQuerySize.width - 30;

    final sliderLabels = ['3000', '5000', '7000'];
    final double sliderMin = 0;
    final double sliderMax = sliderLabels.length - 1.0;
    final sliderDivisions = sliderLabels.length - 1;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(Icons.payments_rounded, size: 60, color: Color.fromRGBO(51, 114, 134, 1)),
                  Text('SOLICITAR PRÉSTAMO', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: 16.0, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: _width * 0.4,
                    child: Text('¿CUANTO DINERO NECESITA?', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: 14.0, fontWeight: FontWeight.bold))
                  ),
                  Container(
                    width: _width * 0.6,
                    child: Text('\$2,000.00', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1),fontSize: 20.0, fontWeight: FontWeight.bold), textAlign: TextAlign.end)
                  ),
                ],
              ),
              SizedBox(height: 15),
              SliderTheme(
                data: SliderThemeData(
                  thumbColor: Colors.green[300],
                  activeTrackColor: Colors.green[300],
                  inactiveTrackColor: Colors.green[300],
                  //thumbShape: RoundSliderThumbShape(enabledThumbRadius: 20),
                  //tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 7),
                  activeTickMarkColor: Colors.green[300],
                  inactiveTickMarkColor: Colors.green[300]
                ),
                child: Slider(
                  value: _indexSliderLabel.toDouble(),
                  min: sliderMin,
                  max: sliderMax,
                  divisions: sliderDivisions,
                  onChanged: (value){
                    // setState(() {
                    //   _indexSliderLabel = value.toInt();
                    //   print(_indexSliderLabel);
                    // });
                  },
                ),
              ),
            ]
          ),
          SizedBox(height: 20),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ELIJA LA FORMA DE PAGO', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: 16.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                SizedBox(height: 10),
                Table(
                  children: [
                    TableRow(
                      children: [
                        Text('PAGO QUINCENAL', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: 13.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        Text('PAGO MENSUAL', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: 13.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                      ]
                    )
                  ],
                ),
                SizedBox(height: 5),
                GroupButton(
                  isRadio: true,
                  elevation: 2,
                  spacing: _width / 4,
                  borderRadius: BorderRadius.circular(10),
                  unselectedShadow: [
                    BoxShadow(color: Colors.transparent)
                  ],
                  selectedShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 15,
                      spreadRadius: 0.1
                    )
                  ],
                  onSelected: (index, isSelected) => print('$index button is selected'),
                  buttons: ['15 DÍAS', '30 DÍAS', '45 DÍAS', '60 DÍAS'],
                ),
                SizedBox(height: 30),
                Container(
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 8),
                            child: Text('TASA DE INTERÉS QUINCENAL DEL 6.5% (+ IVA) (\$145.75 x 3 QUINCENAS)', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1),fontSize: 10.0))
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 8),
                            child: Text('\$431.25', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1),fontSize: 10.0), textAlign: TextAlign.end)
                          ),
                        ]
                      ),
                      TableRow(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 8),
                            child: Text('3 PAGOS QUINCENALES DE', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1),fontSize: 10.0))
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 8),
                            child: Text('\$1,000.08', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1),fontSize: 10.0), textAlign: TextAlign.end)
                          ),
                        ]
                      ),
                      TableRow(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 8),
                            child: Text('TOTAL A PAGAR', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: 16.0, fontWeight: FontWeight.bold))
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 8),
                            child: Text('\$3,000.25', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: 16.0, fontWeight: FontWeight.bold), textAlign: TextAlign.end)
                          ),
                        ]
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          Column(
            children: [
              Container(
                width: double.infinity,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.grey,
                  color: Color.fromRGBO(51, 114, 134, 1),
                  elevation: 0,
                  child: Text(
                    'Continuar', 
                    style: TextStyle(
                      color: Colors.white
                    )
                  ),
                  onPressed: (){
                    //Navigator.pushNamed(context, 'registerStepTwo');
                  },
                ),
              ),
            ],
          ),
        ],
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