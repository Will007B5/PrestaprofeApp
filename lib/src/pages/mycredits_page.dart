import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:prestaprofe/src/services/services.dart';
import 'package:prestaprofe/src/ui/custom_uis.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';

class MyCredits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size; //MediaQuery con los detalles de medida de pantalla
    final _width = _mediaQuerySize.width;
    final _textInfoWidth = _width * 0.055; //Medida de la fuente a utilizar en la barra de estado

    final _internetService = Provider.of<InternetService>(context);

    double _toolbarHeight = _internetService.hasInternet ? kToolbarHeight : (kToolbarHeight + 19);

    return SafeArea(
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
        //bottomNavigationBar: CustomBottomNavigation(),
      ),
    );
  }

  Widget _constructNewCreditBody(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size;
    final _authService = Provider.of<AuthService>(context);
    final _loansService = Provider.of<LoansService>(context);
    final _height = _mediaQuerySize.height - 30;
    final _width = _mediaQuerySize.width - 30;
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
                      Icon(Icons.payment_rounded, size: _objectSize * 0.00024, color: PrestaprofeTheme.goldenIconPages),
                      Text('VER/PAGAR PRÉSTAMO',
                        style: TextStyle(
                          color: PrestaprofeTheme.whiteTextTitlePages,
                          fontSize: _textWidth * 0.05,
                          fontWeight: FontWeight.bold
                        )
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
                      SizedBox(height: 20),
                      Text('${_authService.currentClient.name}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary,
                          fontSize: _textWidth * 0.065,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 5),
                      Icon(Icons.info, size: _objectSize * 0.00024, color: PrestaprofeTheme.successGreen300),
                      SizedBox(height: 5),
                      Text(
                        'ACTUALMENTE CUENTA CON EL SIGUIENTE PRÉSTAMO',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary,
                          fontSize: _textWidth * 0.039,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        decoration: BoxDecoration(
                          color: PrestaprofeTheme.clientOptionsContainerFilledColor,
                          border: Border.all( color: PrestaprofeTheme.clientOptionsContainerBorderColor, width: 1.5),
                          borderRadius: BorderRadius.circular(7)
                        ),
                        child: Column(
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                  alignment: Alignment(0, 0.17),
                                                  child: Text('\$',
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary,
                                                      fontSize: _width * 0.039,
                                                      fontWeight: FontWeight.w900
                                                    ),
                                                  )
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                child: Text('537',
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary,
                                                    fontSize: _width * 0.067,
                                                    fontWeight: FontWeight.w900
                                                  ),
                                                )
                                              ),
                                              Container(
                                                child: Text('00',
                                                  style: TextStyle(
                                                    color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary,
                                                    fontSize: _width * 0.039,
                                                    fontWeight: FontWeight.w900
                                                  ),
                                                  textAlign: TextAlign.end
                                                )
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'Creada el 10/Marzo',
                                            textAlign: TextAlign.end,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: TextStyle(
                                              color: PrestaprofeTheme.extensionInactiveMarksColor,
                                              fontSize: _width * 0.029,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'FECHA LÍMITE DE PAGO',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: TextStyle(
                                              color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary,
                                              fontSize: _width * 0.039,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '25/MARZO/2022',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: TextStyle(
                                              color: PrestaprofeTheme.accentRedText,
                                              fontSize: _width * 0.037,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Table(
                                children: [
                                  TableRow(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 3),
                                        child: Text(
                                          'TASA DE INTERÉS QUINCENAL',
                                          style: TextStyle(
                                            color: PrestaprofeTheme.black87Text,
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
                                        //child: Text('3.5% INTERÉS + 1.75% INTERÉS POR APERTURA DE CTA. + 1.5% INTERÉS POR MANEJO DE CTA. + IVA = \$37.70 X 1 QUINCENA', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.027, fontWeight: FontWeight.bold))
                                        child: RichText(
                                          //Crea un parrafo de texto enriquecido
                                          text: TextSpan(
                                            // Nota: Los estilos de los TextSpans deben ser definidos explicitamente.
                                            // Los elementos child del textspan heredarán los estilos del padre
                                            style: TextStyle(
                                              fontSize: _textWidth * 0.027,
                                              fontWeight: FontWeight.bold,
                                              color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary,
                                            ),
                                            children: [
                                              TextSpan(text: '3.5% INTERÉS '),
                                              TextSpan(text: '+ ', style: TextStyle(color: PrestaprofeTheme.black87Text)),
                                              TextSpan(text:'1.75% INTERÉS POR APERTURA DE CTA. '),
                                              TextSpan(text: '+ ', style: TextStyle(color: PrestaprofeTheme.black87Text)),
                                              TextSpan(text:'1.5% INTERÉS POR MANEJO DE CTA. '),
                                              TextSpan(text: '+ ', style: TextStyle(color: PrestaprofeTheme.black87Text)),
                                              TextSpan(text: 'IVA '),
                                              TextSpan(text: '= ', style: TextStyle(color: PrestaprofeTheme.black87Text)),
                                              TextSpan(text: '\$37.70 '),
                                              TextSpan(text: 'X ', style: TextStyle(color: PrestaprofeTheme.black87Text)),
                                              TextSpan(text: '1 QUINCENA'),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          '\$37.70', 
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary,
                                            fontSize: _textWidth * 0.029
                                          )
                                        )
                                      ),
                                    ]
                                  ),
                                  TableRow(
                                    children: [
                                      Container(
                                        child: Text(
                                          '1 PAGO QUINCENAL DE',
                                          style: TextStyle(
                                            color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary,
                                            fontSize: _textWidth * 0.031,
                                            fontWeight: FontWeight.bold
                                          )
                                        )
                                      ),
                                      Container(
                                        child: Text(
                                          '\$537.70',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary,
                                            fontSize: _textWidth * 0.033
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
                      ),
                      SizedBox(height: 7),
                      Container(
                        padding: EdgeInsets.only(right: 15, left: 15, top: 20, bottom: 5),
                        decoration: BoxDecoration(
                          color: PrestaprofeTheme.clientOptionsContainerFilledColor,
                          border: Border.all(color: PrestaprofeTheme.clientOptionsContainerBorderColor, width: 1.5),
                          borderRadius: BorderRadius.circular(7)
                        ),
                        child: Column(
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'PRÓXIMO A PAGAR',
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        style: TextStyle(
                                          color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary,
                                          fontSize: _width * 0.039,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment(0, 0.17),
                                            child: Text(
                                              '\$',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary,
                                                fontSize: _width * 0.076,
                                                fontWeight: FontWeight.w900
                                              )
                                            )
                                          ),
                                          Container(
                                            alignment:Alignment.center,
                                            child: Text(
                                              '537',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary,
                                                fontSize: _width * 0.1,
                                                fontWeight: FontWeight.w900
                                              )
                                            )
                                          ),
                                          Container(
                                            child: Text(
                                              '00',
                                              textAlign:TextAlign.end,
                                              style: TextStyle(
                                                color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary,
                                                fontSize: _width * 0.076,
                                                fontWeight: FontWeight.w900
                                              )
                                            )
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        child: RichText(
                                          //Crea un parrafo de texto enriquecido
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            // Nota: Los estilos de los TextSpans deben ser definidos explicitamente.
                                            // Los elementos child del textspan heredarán los estilos del padre
                                            style: TextStyle(
                                              color: PrestaprofeTheme.black87Text,
                                              fontSize: _width * 0.031,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            children: [
                                              TextSpan(text: 'Vencimiento 25/Marzo/2022'),
                                              TextSpan(text: '\n'),
                                              // TextSpan(text: ' | '),
                                              TextSpan(text: 'Evita intereses moratorios ', style: TextStyle(fontWeight:FontWeight.normal)),
                                              TextSpan(text: '¡Paga a tiempo! '),
                                              TextSpan(text: '(\$5.51 por día)\n', style: TextStyle(fontWeight: FontWeight.normal)),
                                              TextSpan(text: '3 días de atraso; interés moratorio - \$16.53', style: TextStyle(color: PrestaprofeTheme.accentRedText)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        child: MaterialButton(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                          disabledColor: PrestaprofeTheme.disabledColor,
                                          color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary,
                                          elevation: 0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'GENERAR REFERENCIA',
                                                style: TextStyle(
                                                  color: PrestaprofeTheme.whiteColorText,
                                                  fontWeight: FontWeight .bold
                                                )
                                              )
                                            ],
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 7),
                      ExtensionAd(height: _height, width: _width, viewedFrom: 'myCredits'),
                      SizedBox(height: 5)
                      // SizedBox(height: 50),
                      // Text('\$${_loansService.loans.last.amount.toStringAsFixed(2)}', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.085, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                      // SizedBox(height: 50),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: <Widget>[
                      //     Container(
                      //       width: _width * 0.4,
                      //       child: Text('DEBE LIQUIDAR ANTES DE: ', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.044, fontWeight: FontWeight.bold))
                      //     ),
                      //     Container(
                      //       width: _width * 0.6,
                      //       //child: Text('${_loansService.loans.last.expiredDate.toString()}', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1),fontSize: _textWidth * 0.055, fontWeight: FontWeight.bold), textAlign: TextAlign.end)
                      //     ),
                      //   ],
                      // ),
                      // Column(
                      //   children: [
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: <Widget>[
                      //         Container(
                      //           width: _width * 0.4,
                      //           child: Text('REFERENCIA: ', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.044, fontWeight: FontWeight.bold))
                      //         ),
                      //         Container(
                      //           width: _width * 0.6,
                      //           child: Text('${_loansService.loans.last.paymentReference ?? ''}', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1),fontSize: _textWidth * 0.055, fontWeight: FontWeight.bold), textAlign: TextAlign.end)
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      // Expanded(child: Container()),
                      // Column(
                      //   children: [
                      //     Container(
                      //       width: double.infinity,
                      //       child: MaterialButton(
                      //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      //         disabledColor: Colors.grey,
                      //         color: Color.fromRGBO(51, 114, 134, 1),
                      //         elevation: 0,
                      //         child: Text(
                      //           _loansService.isLoading ? 'Generando referencia...' : 'Generar referencia',
                      //           style: TextStyle(
                      //             color: Colors.white
                      //           )
                      //         ),
                      //         onPressed: (!_loansService.isLoading && _loansService.loans.last.paymentReference == null) ? () async {
                      //           // print(_loansService.loans.last.amount);
                      //           // final r = double.parse(_loansService.loans.last.amount) * 100;
                      //           // String amountTrued = '';
                      //           // if (r.toString().contains('.')) {
                      //           //   amountTrued = r.toString().substring(0, r.toString().indexOf('.'));
                      //           // }
                      //           // else{
                      //           //   amountTrued = r.toString();
                      //           // }
                      //           // DateTime fecha = _loansService.loans.last.expiredDate!;
                      //           // int dia = fecha.day;
                      //           // int mes = fecha.month;
                      //           // int an = fecha.year;
                      //           // String completeDate = '';
                      //           // if(mes > 9){
                      //           //   completeDate = dia.toString() + mes.toString() + an.toString().substring(2,4);
                      //           // }
                      //           // else{
                      //           //   completeDate = dia.toString() + '0' + mes.toString() + an.toString().substring(2,4);
                      //           // }
                      //           print(Reference35Generator.makeReference(positions: _authService.currentClient.id.toString()+_authService.currentClient.curp!.substring(0,4)));
                      //           final reference = Reference35Generator.makeReference(positions: _authService.currentClient.id.toString()+_authService.currentClient.curp!.substring(0,4));
                      //           await _loansService.updateReference(reference, _loansService.loans.last);
                      //           //Navigator.of(context).pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
                      //         } : null,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
