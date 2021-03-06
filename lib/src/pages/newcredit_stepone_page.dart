import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

import 'package:prestaprofe/src/pages/pages.dart';
import 'package:prestaprofe/src/providers/providers.dart';
import 'package:prestaprofe/src/services/services.dart';
import 'package:prestaprofe/src/ui/custom_uis.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';

class NewCreditStepOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size; //MediaQuery con los detalles de medida de pantalla
    final _width = _mediaQuerySize.width;
    final _textInfoWidth = _width * 0.055; //Medida de la fuente a utilizar en la barra de estado

    final _newCreditFormProvider = Provider.of<NewCreditFormProvider>(context, listen: false);
    final _loansService = Provider.of<LoansService>(context);
    _newCreditFormProvider.initialAmount(paymentSchema: _newCreditFormProvider.loan.paymentSchema, paymentSchemaDaysDuration: _newCreditFormProvider.paymentSchemaDaysDuration);

    final _internetService = Provider.of<InternetService>(context);

    double _toolbarHeight = _internetService.hasInternet ? kToolbarHeight : (kToolbarHeight + 19);

    return !_loansService.isLoading
      ? SafeArea(
          top: false,
          child: Scaffold(
            appBar: AppBarHome(
              textStep: '',
              textWidth: _textInfoWidth,
              toolbarHeight: _toolbarHeight
            ), //Widget en carpeta Widgets
            body: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
              child: _constructNewCreditBody(context)
            ),
            //bottomNavigationBar: CustomBottomNavigation(), //Widget en carpeta Widgets
          ),
        )
      : LoadingPage();
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

    return PagesBackground(
      height: _height,
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.payments_rounded, size: _objectSize * 0.00024, color: PrestaprofeTheme.goldenIconPages),
                      Text(
                        'SOLICITAR PR??STAMO',
                        style: TextStyle(color: PrestaprofeTheme.whiteTextTitlePages, fontSize: _textWidth * 0.05, fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: PrestaprofeTheme.mainOptionsContainerFillColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(43), topRight: Radius.circular(43))
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: _width * 0.4,
                            child: Text(
                              '??CUANTO DINERO NECESITA?',
                              style: TextStyle(
                                color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary,
                                fontSize: _textWidth * 0.04,
                                fontWeight: FontWeight.bold
                              )
                            )
                          ),
                          Container(
                            width: _width * 0.6,
                            child: IntrinsicHeight(
                              //Se combina este widget con el Cross.stretch para que los containers hijos sean del mismo alto que la row
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    alignment: Alignment(0, 0.17),
                                    child: Text(
                                      '\$',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        color: PrestaprofeTheme.extensionGreenSuccessColor,
                                        fontSize:_textWidth * 0.0487,
                                        fontWeight:FontWeight.w900
                                      ),
                                    )
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${_newCreditFormProvider.amountSliderRange.toStringAsFixed(0)}',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        color: PrestaprofeTheme.extensionGreenSuccessColor,
                                        fontSize: _textWidth * 0.076,
                                        fontWeight: FontWeight.w900
                                      )
                                    )
                                  ),
                                  Container(
                                    child: Text(
                                      '00',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        color: PrestaprofeTheme.extensionGreenSuccessColor,
                                        fontSize: _textWidth * 0.0487,
                                        fontWeight: FontWeight.w900
                                      ),
                                    )
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 7,
                          thumbColor: Color.fromRGBO(51, 114, 134, 1),
                          activeTrackColor: Color.fromRGBO(51, 114, 134, 1),
                          inactiveTrackColor: Colors.grey.shade300,
                          thumbShape: CustomSliderThumbCircle(
                            thumbRadius: 16,
                            colorShape: Color.fromRGBO(51, 114, 134, 1),
                            colorIcon: Color.fromARGB(255, 238, 195, 67)
                          ), //Clase custom para poner el icono
                          activeTickMarkColor: Color.fromRGBO(51, 114, 134, 1),
                          inactiveTickMarkColor: Colors.grey.shade300
                        ),
                        child: Slider(
                          value: _newCreditFormProvider.amountSliderRange,
                          min: _newCreditFormProvider.sliderMinValue,
                          max: _newCreditFormProvider.sliderMaxValueByRange(2), //Depende del rango del usuario (Rango 1 y Rango 2)
                          divisions: (_newCreditFormProvider.sliderMaxValueByRange(2) - 500.0) ~/ 500.0,
                          onChanged: (value) {
                            _newCreditFormProvider.amountSliderRange = value;
                            _newCreditFormProvider.changeAmount(paymentSchema: _newCreditFormProvider.loan.paymentSchema, paymentSchemaDaysDuration: _newCreditFormProvider.paymentSchemaDaysDuration);
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ELIJA LA FORMA DE PAGO',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromRGBO(51, 114, 134, 1),
                              fontSize: _textWidth * 0.04,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 10),
                          Table(
                            children: [
                              TableRow(
                                children: [
                                  Text(
                                    'PAGO QUINCENAL',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromRGBO(51, 114, 134, 1),
                                      fontSize: _textWidth * 0.04,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                    'PAGO MENSUAL',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromRGBO(51, 114, 134, 1),
                                      fontSize: _textWidth * 0.04,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
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
                            unselectedShadow: [BoxShadow(color: Colors.transparent)],
                            selectedShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 15,
                                spreadRadius: 0.1
                              )
                            ],
                            onSelected: (index, isSelected) {
                              print(' button is selected');
                              if (index == 0) {
                                //0 = 15 dias; biweekly
                                _newCreditFormProvider.loan.paymentSchema = 'biweekly';
                                _newCreditFormProvider.paymentSchemaDaysDuration = 1;
                                _newCreditFormProvider.groupButtonSelectedButton = index;
                              } else if (index == 1) {
                                //1 = 30 d??as; monthly
                                _newCreditFormProvider.loan.paymentSchema = 'monthly';
                                _newCreditFormProvider.paymentSchemaDaysDuration = 1;
                                _newCreditFormProvider.groupButtonSelectedButton = index;
                              } else if (index == 2) {
                                //2 = 45 d??as; biweekly
                                _newCreditFormProvider.loan.paymentSchema = 'biweekly';
                                _newCreditFormProvider.paymentSchemaDaysDuration = 3;
                                _newCreditFormProvider.groupButtonSelectedButton = index;
                              } else if (index == 3) {
                                //3 = 60 d??as; monthly
                                _newCreditFormProvider.loan.paymentSchema = 'monthly';
                                _newCreditFormProvider.paymentSchemaDaysDuration = 2;
                                _newCreditFormProvider.groupButtonSelectedButton = index;
                              }
                              _newCreditFormProvider.changeAmount(
                                paymentSchema: _newCreditFormProvider.loan.paymentSchema,
                                paymentSchemaDaysDuration: _newCreditFormProvider.paymentSchemaDaysDuration
                              );
                            },
                            buttons: [
                              '15 D??AS',
                              '30 D??AS',
                              '45 D??AS',
                              '60 D??AS'
                            ],
                          ),
                          SizedBox(height: 30),
                          // Container(
                          //   child: Table(
                          //     children: [
                          //       TableRow(
                          //         children: [
                          //           Container(
                          //             margin: EdgeInsets.only(bottom: 8),
                          //             child: Text('${_newCreditFormProvider.changeInterestRateTextDescription(paymentSchema: _newCreditFormProvider.loan.paymentSchema, paymentSchemaDaysDuration: _newCreditFormProvider.paymentSchemaDaysDuration)}', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.027))
                          //           ),
                          //           Container(
                          //             margin: EdgeInsets.only(bottom: 8),
                          //             child: Text('$${_newCreditFormProvider.changeAmountInterestRateTextDescription(paymentSchema: _newCreditFormProvider.loan.paymentSchema, paymentSchemaDaysDuration: _newCreditFormProvider.paymentSchemaDaysDuration)}', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.027), textAlign: TextAlign.end)
                          //           ),
                          //         ]
                          //       ),
                          //       TableRow(
                          //         children: [
                          //           Container(
                          //             margin: EdgeInsets.only(bottom: 8),
                          //             child: Text('${_newCreditFormProvider.changePaymentDurationInstructionsText(paymentSchema: _newCreditFormProvider.loan.paymentSchema, paymentSchemaDaysDuration: _newCreditFormProvider.paymentSchemaDaysDuration)}', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.027))
                          //           ),
                          //           Container(
                          //             margin: EdgeInsets.only(bottom: 8),
                          //             child: Text('$${_newCreditFormProvider.totalLoanAmountByPaymentSchemaDaysDuration(paymentSchema: _newCreditFormProvider.loan.paymentSchema, paymentSchemaDaysDuration: _newCreditFormProvider.paymentSchemaDaysDuration)}', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.027), textAlign: TextAlign.end)
                          //           ),
                          //         ]
                          //       ),
                          //       TableRow(
                          //         children: [
                          //           Container(
                          //             margin: EdgeInsets.only(bottom: 8),
                          //             child: Text('TOTAL A PAGAR', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.045, fontWeight: FontWeight.bold))
                          //           ),
                          //           Container(
                          //             margin: EdgeInsets.only(bottom: 8),
                          //             child: Text('$${_newCreditFormProvider.totalLoanAmount(paymentSchema: _newCreditFormProvider.loan.paymentSchema, paymentSchemaDaysDuration: _newCreditFormProvider.paymentSchemaDaysDuration)}', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.045, fontWeight: FontWeight.bold), textAlign: TextAlign.end)
                          //           ),
                          //         ]
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Container(
                            child: Table(
                              children: [
                                TableRow(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 3),
                                      child: Text(
                                        'TASA DE INTER??S QUINCENAL',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: _textWidth * 0.027,
                                          fontWeight: FontWeight.bold
                                        )
                                      )
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 3),
                                    ),
                                  ]
                                ),
                                TableRow(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 8),
                                      //child: Text('3.5% INTER??S + 1.75% INTER??S POR APERTURA DE CTA. + 1.5% INTER??S POR MANEJO DE CTA. + IVA = .70 X 1 QUINCENA', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.027, fontWeight: FontWeight.bold))
                                      child: RichText(
                                        //Crea un parrafo de texto enriquecido
                                        text: TextSpan(
                                          // Nota: Los estilos de los TextSpans deben ser definidos explicitamente.
                                          // Los elementos child del textspan heredar??n los estilos del padre
                                          style: TextStyle(
                                            fontSize: _textWidth * 0.027,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(51, 114, 134, 1),
                                          ),
                                          children: [
                                            TextSpan(text: '3.5% INTER??S '),
                                            TextSpan(text: '+ ', style: TextStyle(color: Colors.black87)),
                                            TextSpan(text: '1.75% INTER??S POR APERTURA DE CTA. '),
                                            TextSpan(text: '+ ', style: TextStyle(color: Colors.black87)),
                                            TextSpan(text: '1.5% INTER??S POR MANEJO DE CTA. '),
                                            TextSpan(text: '+ ', style: TextStyle(color: Colors.black87)),
                                            TextSpan(text: 'IVA '),
                                            TextSpan(text: '= ', style: TextStyle(color: Colors.black87)),
                                            TextSpan(text: '.70 '),
                                            TextSpan(text: 'X ', style: TextStyle(color: Colors.black87)),
                                            TextSpan(text: '1 QUINCENA'),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 8),
                                      child: Text('\$537.70', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.029), textAlign: TextAlign.end)
                                    ),
                                  ]
                                ),
                                TableRow(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 16),
                                      child: Text(
                                        '1 PAGO QUINCENAL DE',
                                        style: TextStyle(
                                          color: Color.fromRGBO(51, 114, 134, 1),
                                          fontSize: _textWidth * 0.031,
                                          fontWeight: FontWeight.bold
                                        )
                                      )
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 16),
                                      child: Text(
                                        '\$537.70',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize:_textWidth * 0.033)
                                      )
                                    ),
                                  ]
                                ),
                                TableRow(
                                  children: [
                                    Container(
                                      child: Text(
                                        'TOTAL A PAGAR',
                                        style: TextStyle(
                                          color: Color.fromRGBO(51, 114, 134, 1),
                                          fontSize: _textWidth * 0.051,
                                          fontWeight: FontWeight.bold
                                        )
                                      )
                                    ),
                                    Container(
                                      child: Text(
                                        '\$${_newCreditFormProvider.totalLoanAmount(paymentSchema: _newCreditFormProvider.loan.paymentSchema, paymentSchemaDaysDuration: _newCreditFormProvider.paymentSchemaDaysDuration)}',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          color: Color.fromRGBO(51, 114, 134, 1),
                                          fontSize: _textWidth * 0.051,
                                          fontWeight: FontWeight.bold
                                        )
                                      )
                                    ),
                                  ]
                                ),
                              ],
                            ),
                          ),
                        ],
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _loansService.isLoading
                                      ? 'Generando prestamo...'
                                      : 'SOLICITAR',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                      )
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 5)),
                                  Text(
                                    _loansService.isLoading
                                      ? 'Generando prestamo...'
                                      : 'PR??STAMO',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 238, 195, 67),
                                        fontWeight: FontWeight.bold
                                      )
                                  ),
                                ],
                              ),
                              onPressed: (_newCreditFormProvider.loan.amount > 0 && !_loansService.isLoading)
                                ? () async {
                                    //Al objeto de Loan se le manda en su amount el monto base (es decir el selector de rango)
                                    //Debido a que as?? lo requiere el backend
                                    print(_newCreditFormProvider.loan.amount); //Mandar el monto base
                                    final response = await _loansService.createLoans(_newCreditFormProvider.loan, idUser: _authService.currentClient.id!);
                                    if (response == 200) {
                                      //Navigator.pushNamed(context, 'myCredits');
                                      Navigator.of(context).pushReplacementNamed('myCredits');
                                      _newCreditFormProvider.customResetNewCreditForm();
                                    }
                                  }
                                : null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

//Clase custom para poner el signo mas dentro de la figura del widget slider
class CustomSliderThumbCircle extends SliderComponentShape {
  final double thumbRadius;
  final Color colorShape;
  final Color colorIcon;

  const CustomSliderThumbCircle({required this.thumbRadius, required this.colorShape, required this.colorIcon});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, 
    {
      Animation<double>? activationAnimation,
      Animation<double>? enableAnimation,
      bool? isDiscrete,
      TextPainter? labelPainter,
      RenderBox? parentBox,
      SliderThemeData? sliderTheme,
      TextDirection? textDirection,
      double? value,
      double? textScaleFactor,
      Size? sizeWithOverflow,
    }
  ){

    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..color = colorShape //Color circulo del slider
      ..style = PaintingStyle.fill;

    TextSpan span = new TextSpan(
      style: new TextStyle(
        fontSize: thumbRadius * 1.13,
        fontWeight: FontWeight.w900,
        color: colorIcon, //Color del valor dentro del circulo del slider
      ),
      text: String.fromCharCode(0x2B), //charcode sacado de documentaci??n flutter
    );

    TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    tp.layout();
    Offset textCenter = Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawCircle(center, thumbRadius * .9, paint);
    tp.paint(canvas, textCenter);
  }
}
