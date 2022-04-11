import 'package:flutter/material.dart';

import 'package:prestaprofe/src/ui/custom_uis.dart';

class ExtensionAd extends StatelessWidget {

  final double height;
  final double width;
  final String viewedFrom;

  const ExtensionAd({
    Key? key, 
    required this.height,
    required this.width,
    required this.viewedFrom
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Color _containerBorderColor = this.viewedFrom == 'dashboard' ? PrestaprofeTheme.clientOptionsContainerBorderColorAccentRed : PrestaprofeTheme.clientOptionsContainerBorderColor;

    final BoxDecoration _extensionContainerBoxDecoration = BoxDecoration(
      color: PrestaprofeTheme.clientOptionsContainerFilledColor,
      border: Border.all(color: _containerBorderColor, width: 1.5),
      borderRadius: BorderRadius.circular(7)
    );

    return Container(
      padding: EdgeInsets.only(right: 15, left: 15, top: 15),
      decoration: _extensionContainerBoxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('¿Se le complica pagar?',
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(
                      color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary,
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 3),
                  RichText(
                    //Crea un parrafo de texto enriquecido
                    text: TextSpan(
                      // Nota: Los estilos de los TextSpans deben ser definidos explicitamente.
                      // Los elementos child del textspan heredarán los estilos del padre
                      style: TextStyle(
                        color: PrestaprofeTheme.black87Text,
                        fontSize: width * 0.029,
                        fontWeight: FontWeight.bold
                      ),
                      children: [
                        TextSpan(text: 'Tiene derecho a '),
                        TextSpan(text: '2 ', style: TextStyle(color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary)),
                        TextSpan(text: 'extensiones de pago'),
                      ],
                    ),
                  ),
                  SizedBox(height: 9),
                  Row(
                    children: [
                      Container(
                        width: width * 0.3,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    alignment: AlignmentDirectional.center,
                                    height: 17,
                                    width: 17,
                                    color: PrestaprofeTheme.extensionInactiveMarksColor
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    alignment: AlignmentDirectional.center,
                                    height: 17,
                                    width: 17,
                                    color: PrestaprofeTheme.extensionGreenSuccessColor
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    alignment: AlignmentDirectional.center,
                                    height: 17,
                                    width: 17,
                                    color: PrestaprofeTheme.extensionGreenSuccessColor
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Extensión 2/3',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: PrestaprofeTheme.extensionInactiveMarksColor,
                                    fontSize: width * 0.029,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(right: 5, left: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: width * 0.2,
                                    child: Text('Minimo a pagar: ',
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: TextStyle(
                                        color: PrestaprofeTheme.accentRedText,
                                        fontSize: width * 0.033,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          alignment: Alignment(0, 0.17),
                                          child: Text('\$',
                                            style: TextStyle(
                                              color: PrestaprofeTheme.extensionGreenSuccessColor,
                                              fontSize: width * 0.036,
                                              fontWeight:FontWeight.w900
                                            ),
                                            textAlign: TextAlign.end
                                          )
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text('537',
                                            style: TextStyle(
                                              color: PrestaprofeTheme.extensionGreenSuccessColor,
                                              fontSize: width * 0.064,
                                              fontWeight: FontWeight.w900
                                            ),
                                            textAlign: TextAlign.end
                                          )
                                        ),
                                        Container(
                                          child: Text('00',
                                          style: TextStyle(
                                            color: PrestaprofeTheme.extensionGreenSuccessColor,
                                            fontSize: width * 0.036,
                                            fontWeight: FontWeight.w900
                                          ),
                                          textAlign:TextAlign.end
                                          )
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        'Interés + \$60.00 MXN extensión',
                                        textAlign: TextAlign.end,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        style: TextStyle(
                                          color: PrestaprofeTheme.black87Text,
                                          fontSize: width * 0.029,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: MaterialButton(
                          height: 25,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          disabledColor: PrestaprofeTheme.disabledColor,
                          color: PrestaprofeTheme.extensionButtonActivateColor,
                          elevation: 0,
                          child: Text(
                            'ACTIVAR',
                            style: TextStyle(
                              color: PrestaprofeTheme.whiteColorText,
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.035
                            )
                          ),
                          onPressed: () {},
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}