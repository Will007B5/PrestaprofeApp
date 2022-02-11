import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:prestaprofe/src/providers/providers.dart';

import 'package:prestaprofe/src/services/services.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class NewCreditStepOne extends StatelessWidget {

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
    final _newCreditFormProvider = Provider.of<NewCreditFormProvider>(context);
    final _authService = Provider.of<AuthService>(context);
    final _loansService = Provider.of<LoansService>(context);
    _newCreditFormProvider.loan.userId = _authService.currentClient.id!;
    final _width = _mediaQuerySize.width - 30;
    final _height = _mediaQuerySize.height - 30;
    final _textWidth = _width;
    final _objectSize = _height * _width;

    final double sliderMin = 500.0;
    final double sliderMax = 2000.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(Icons.payments_rounded, size: _objectSize * 0.00024, color: Color.fromRGBO(51, 114, 134, 1)),
                  Text('SOLICITAR PRÉSTAMO', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.05, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: _width * 0.4,
                    child: Text('¿CUANTO DINERO NECESITA?', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.04, fontWeight: FontWeight.bold))
                  ),
                  Container(
                    width: _width * 0.6,
                    child: Text('\$${_newCreditFormProvider.amountSliderRange}', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.063, fontWeight: FontWeight.bold), textAlign: TextAlign.end)
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
                  value: _newCreditFormProvider.amountSliderRange,
                  min: sliderMin,
                  max: sliderMax,
                  divisions: (sliderMax - 500.0) ~/ 500.0,
                  onChanged: (value){
                    _newCreditFormProvider.amountSliderRange = value;
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
                Text('ELIJA LA FORMA DE PAGO', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.04, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                SizedBox(height: 10),
                Table(
                  children: [
                    TableRow(
                      children: [
                        Text('PAGO QUINCENAL', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.04, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        Text('PAGO MENSUAL', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.04, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
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
                  onSelected: (index, isSelected) {
                    //0 = 15 dias; biweekly
                    //1 = 30 días; monthly
                    //2 = 45 días; biweekly
                    //3 = 60 días; monthly
                    print('$index button is selected');
                    if(index == 0){
                      _newCreditFormProvider.loan.paymentSchema = 'biweekly';
                      _newCreditFormProvider.changeAmount('15 dias', 'biweekly');
                    }
                    else if(index == 1){
                      _newCreditFormProvider.loan.paymentSchema = 'monthly';
                      _newCreditFormProvider.changeAmount('30 dias', 'monthly');
                    }
                    else if(index == 2){
                      _newCreditFormProvider.loan.paymentSchema = 'biweekly';
                      _newCreditFormProvider.changeAmount('45 dias', 'biweekly');
                    }
                    else if(index == 3){
                      _newCreditFormProvider.loan.paymentSchema = 'monthly';
                      _newCreditFormProvider.changeAmount('60 dias', 'monthly');
                    }
                  },
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
                            //child: Text('TASA DE INTERÉS QUINCENAL DEL 6.5% (+ IVA) (\$145.75 x 3 QUINCENAS)', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.027))
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 8),
                            //child: Text('\$431.25', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.027), textAlign: TextAlign.end)
                          ),
                        ]
                      ),
                      TableRow(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 8),
                            //child: Text('3 PAGOS QUINCENALES DE', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.027))
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 8),
                            //child: Text('\$1,000.08', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.027), textAlign: TextAlign.end)
                          ),
                        ]
                      ),
                      TableRow(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 8),
                            child: Text('TOTAL A PAGAR', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.045, fontWeight: FontWeight.bold))
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 8),
                            child: Text('\$${_newCreditFormProvider.totalAmountPrestamo}', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.045, fontWeight: FontWeight.bold), textAlign: TextAlign.end)
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
                  onPressed: () async{
                    await _loansService.createLoans(_newCreditFormProvider.loan);
                    Navigator.pushNamed(context, 'home');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}