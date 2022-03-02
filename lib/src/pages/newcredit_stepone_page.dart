import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:prestaprofe/src/helpers/helpers.dart';
import 'package:prestaprofe/src/pages/pages.dart';
import 'package:provider/provider.dart';

import 'package:prestaprofe/src/providers/providers.dart';
import 'package:prestaprofe/src/services/services.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';

class NewCreditStepOne extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _newCreditFormProvider = Provider.of<NewCreditFormProvider>(context, listen: false);
    final _loansService = Provider.of<LoansService>(context);
    _newCreditFormProvider.initialAmount(paymentSchema: _newCreditFormProvider.loan.paymentSchema, paymentSchemaDaysDuration: _newCreditFormProvider.paymentSchemaDaysDuration);
    return !_loansService.isLoading ? Scaffold(
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
    ) : LoadingPage();
  }

  Widget _constructNewCreditBody(BuildContext context) {

    final _newCreditFormProvider = Provider.of<NewCreditFormProvider>(context);
    final _authService = Provider.of<AuthService>(context);
    final _loansService = Provider.of<LoansService>(context);

    final _mediaQuerySize = MediaQuery.of(context).size;
    final _width = _mediaQuerySize.width - 30;
    final _height = _mediaQuerySize.height - 30;
    final _textWidth = _width;
    final _objectSize = _height * _width;

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
                    child: Text('\$${_newCreditFormProvider.amountSliderRange.toStringAsFixed(2)}', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.063, fontWeight: FontWeight.bold), textAlign: TextAlign.end)
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
                  min: _newCreditFormProvider.sliderMinValue,
                  max: _newCreditFormProvider.sliderMaxValueByRange(1), //Depende del rango del usuario (Rango 1 y Rango 2)
                  divisions: (_newCreditFormProvider.sliderMaxValueByRange(1) - 500.0) ~/ 500.0,
                  onChanged: (value){
                    _newCreditFormProvider.amountSliderRange = value;
                    _newCreditFormProvider.changeAmount(paymentSchema: _newCreditFormProvider.loan.paymentSchema, paymentSchemaDaysDuration: _newCreditFormProvider.paymentSchemaDaysDuration);
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
                  selectedButton: _newCreditFormProvider.groupButtonSelectedButton,
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
                    print('$index button is selected');
                    if(index == 0){ //0 = 15 dias; biweekly
                      _newCreditFormProvider.loan.paymentSchema = 'biweekly';
                      _newCreditFormProvider.paymentSchemaDaysDuration = 1;
                      _newCreditFormProvider.groupButtonSelectedButton = index;
                    }
                    else if(index == 1){ //1 = 30 días; monthly
                      _newCreditFormProvider.loan.paymentSchema = 'monthly';
                      _newCreditFormProvider.paymentSchemaDaysDuration = 1;
                      _newCreditFormProvider.groupButtonSelectedButton = index;
                    }
                    else if(index == 2){ //2 = 45 días; biweekly
                      _newCreditFormProvider.loan.paymentSchema = 'biweekly';
                      _newCreditFormProvider.paymentSchemaDaysDuration = 3;
                      _newCreditFormProvider.groupButtonSelectedButton = index;
                    }
                    else if(index == 3){ //3 = 60 días; monthly
                      _newCreditFormProvider.loan.paymentSchema = 'monthly';
                      _newCreditFormProvider.paymentSchemaDaysDuration = 2;
                      _newCreditFormProvider.groupButtonSelectedButton = index;
                    }
                    _newCreditFormProvider.changeAmount(paymentSchema: _newCreditFormProvider.loan.paymentSchema, paymentSchemaDaysDuration: _newCreditFormProvider.paymentSchemaDaysDuration);
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
                            child: Text('${_newCreditFormProvider.changeInterestRateTextDescription(paymentSchema: _newCreditFormProvider.loan.paymentSchema, paymentSchemaDaysDuration: _newCreditFormProvider.paymentSchemaDaysDuration)}', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.027))
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 8),
                            child: Text('\$${_newCreditFormProvider.changeAmountInterestRateTextDescription(paymentSchema: _newCreditFormProvider.loan.paymentSchema, paymentSchemaDaysDuration: _newCreditFormProvider.paymentSchemaDaysDuration)}', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.027), textAlign: TextAlign.end)
                          ),
                        ]
                      ),
                      TableRow(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 8),
                            child: Text('${_newCreditFormProvider.changePaymentDurationInstructionsText(paymentSchema: _newCreditFormProvider.loan.paymentSchema, paymentSchemaDaysDuration: _newCreditFormProvider.paymentSchemaDaysDuration)}', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.027))
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 8),
                            child: Text('\$${_newCreditFormProvider.totalLoanAmountByPaymentSchemaDaysDuration(paymentSchema: _newCreditFormProvider.loan.paymentSchema, paymentSchemaDaysDuration: _newCreditFormProvider.paymentSchemaDaysDuration)}', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.027), textAlign: TextAlign.end)
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
                            child: Text('\$${_newCreditFormProvider.totalLoanAmount(paymentSchema: _newCreditFormProvider.loan.paymentSchema, paymentSchemaDaysDuration: _newCreditFormProvider.paymentSchemaDaysDuration)}', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.045, fontWeight: FontWeight.bold), textAlign: TextAlign.end)
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
                    _loansService.isLoading ? 'Generando prestamo...' : 'Continuar', 
                    style: TextStyle(
                      color: Colors.white
                    )
                  ),
                  onPressed: (_newCreditFormProvider.loan.amount > 0 && !_loansService.isLoading) ? () async{
                    //Al objeto de Loan se le manda en su amount el monto base (es decir el selector de rango)
                    //Debido a que así lo requiere el backend
                    print( _newCreditFormProvider.loan.amount); //Mandar el monto base
                    final response = await _loansService.createLoans(_newCreditFormProvider.loan, idUser: _authService.currentClient.id!);
                    if(response == 200){
                      //Navigator.pushNamed(context, 'myCredits');
                      Navigator.of(context).pushReplacementNamed('myCredits');
                      _newCreditFormProvider.customResetNewCreditForm();
                    }
                  } : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}