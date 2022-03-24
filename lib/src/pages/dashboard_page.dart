import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:provider/provider.dart';

import 'package:prestaprofe/src/models/models.dart';
import 'package:prestaprofe/src/services/services.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //_mediaQuerySize.height = tamaño general de la pantalla
    //MediaQuery.of(context).padding.top = tamaño del status bar
    //kToolbarHeight = constante de Flutter que indica el tamaño del appbar
    //kBottomNavigationBarHeight = constante de Flutter que indica el tamaño del BottomNavigationBar

    final _mediaQuerySize = MediaQuery.of(context).size;

    final width = _mediaQuerySize.width - 30;
    final height = _mediaQuerySize.height - 30;

    return Container(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Container(
              width: double.infinity,
              height: height / 2,
              child: Image(
                image: AssetImage('assets/homewallpaper.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          CustomScrollView(physics: ClampingScrollPhysics(), slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 15),
                        _ProfileNameAndPicture(
                            mediaQuerySize: _mediaQuerySize,
                            height: height,
                            width: width),
                        SizedBox(height: 30),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(43),
                                topRight: Radius.circular(43))),
                        child: Column(children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                _ProfileCardActions(
                                    mediaQuerySize: _mediaQuerySize,
                                    height: height,
                                    width: width),
                              ],
                            ),
                          ),
                          Expanded(child: Container()),
                          Column(
                            //BANNER
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Container(
                              //   width: double.infinity,
                              //   height: height / 10.5,
                              //   color: Colors.white,
                              //   child: Image(
                              //     image: AssetImage('assets/banner.jpg'),
                              //     fit: BoxFit.fill
                              //   ),
                              // )
                              // Container(
                              //   width: double.infinity,
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     children: [
                              //       Row(
                              //         children: [
                              //           Column(
                              //             crossAxisAlignment: CrossAxisAlignment.end,
                              //             children: [
                              //               Text('RESTAN', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontWeight: FontWeight.bold, fontSize: width * 0.04)),
                              //               Text('(ACTIVAR EXTENSIÓN)', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontWeight: FontWeight.bold, fontSize: width * 0.025))
                              //             ]
                              //           ),
                              //           Padding(
                              //             padding: EdgeInsets.symmetric(horizontal: 4),
                              //             child: CircularPercentIndicator(
                              //               radius: (height * width) * 0.000055,
                              //               animation: true,
                              //               animationDuration: 1200,
                              //               lineWidth: width * 0.009,
                              //               percent: 0.6,
                              //               center: Text('2', style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.035, color: Color.fromRGBO(51, 114, 134, 1))),
                              //               circularStrokeCap: CircularStrokeCap.butt,
                              //               backgroundColor: Colors.grey,
                              //               progressColor: Color.fromRGBO(51, 114, 134, 1),
                              //             ),
                              //           )
                              //         ],
                              //       )
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(height: 3)
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ],
      ),
    );
  }
}

class _ProfileNameAndPicture extends StatelessWidget {
  final Size mediaQuerySize;
  final double height;
  final double width;

  const _ProfileNameAndPicture({
    Key? key,
    required this.mediaQuerySize,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authService = Provider.of<AuthService>(context);
    return Container(
      child: Column(
        children: [
          // CircleAvatar(
          //   radius: (this.height * this.width) * 0.00028,
          //   backgroundColor: Color.fromRGBO(51, 114, 134, 1),
          //   child: CircleAvatar(
          //     radius: (this.height * this.width) * 0.00026,
          //     child: ClipRRect(
          //       borderRadius: BorderRadius.circular(130),
          //       child: Image(
          //         image: AssetImage('assets/logouser.jpg'),
          //         fit: BoxFit.fill,
          //       ),
          //     )
          //   ),
          // ),
          OutlineGradientButton(
            gradient: SweepGradient(
              colors: [
                Color.fromARGB(255, 107, 91, 43),
                Color.fromARGB(255, 255, 225, 136),
                Color.fromARGB(255, 238, 195, 67),
                Color.fromARGB(255, 107, 91, 43),
                Color.fromARGB(255, 238, 195, 67),
                Color.fromARGB(255, 107, 91, 43),
                Color.fromARGB(255, 255, 225, 136),
                Color.fromARGB(255, 107, 91, 43),
                Color.fromARGB(255, 238, 195, 67),
                Color.fromARGB(255, 107, 91, 43),
                Color.fromARGB(255, 238, 195, 67),
                Color.fromARGB(255, 255, 225, 136),
                Color.fromARGB(255, 107, 91, 43),
                Color.fromARGB(255, 238, 195, 67),
                Color.fromARGB(255, 107, 91, 43),
              ],
              center: Alignment(0.1, 0.0),
              //focal: Alignment(0.6, -0.2),
            ),
            strokeWidth: 6.3,
            radius: Radius.circular(130),
            backgroundColor: Colors.black87,
            child: CircleAvatar(
                radius: (this.height * this.width) * 0.00026,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(130),
                  child: Image(
                    image: AssetImage('assets/logouser.jpg'),
                    fit: BoxFit.fill,
                  ),
                )),
          ),
          SizedBox(height: 8),
          Column(
            children: [
              Text(
                'HOLA,',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: this.width * 0.043,
                ),
              ),
              SizedBox(height: 2),
              Text(
                '${_authService.currentClient.name.toUpperCase()}',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 238, 195, 67),
                  fontWeight: FontWeight.bold,
                  fontSize: this.width * 0.0587,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileCardActions extends StatelessWidget {
  final Size mediaQuerySize;
  final double height;
  final double width;

  const _ProfileCardActions({
    Key? key,
    required this.mediaQuerySize,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authService = Provider.of<AuthService>(context);
    final _cardsService = Provider.of<CardsService>(context);

    return Container(
      child: Column(
        children: [
          SizedBox(height: 25),
          Text(
            '¿QUÉ DESEA HACER?',
            style: TextStyle(
                fontSize: this.width * 0.05,
                color: Color.fromRGBO(51, 114, 134, 1),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 25),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300, width: 1.5),
                borderRadius: BorderRadius.circular(7)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: _GestureTapMenuActions(
                        route: _checkRoutesToNewLoans(_cardsService
                            .filterUserCards(_authService.currentClient.id!)),
                        icon: Icons.payments_rounded,
                        width: (this.width / 3),
                        height: (this.height / 3),
                        text: 'SOLICITAR PRÉSTAMO')),
                Expanded(
                    child: _GestureTapMenuActions(
                        route: 'myCredits',
                        icon: Icons.payment_rounded,
                        width: (this.width / 3),
                        height: (this.height / 3),
                        text: 'VER/PAGAR PRÉSTAMO')),
                Expanded(
                    child: _GestureTapMenuActions(
                        route: '',
                        icon: Icons.insert_chart,
                        width: (this.width / 3),
                        height: (this.height / 3),
                        text: 'MI HISTORIAL')),
              ],
            ),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300, width: 1.5),
                borderRadius: BorderRadius.circular(7)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: width * 0.53,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PRÓXIMO A PAGAR',
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                            color: Color.fromRGBO(51, 114, 134, 1),
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 3),
                      RichText(
                        //Crea un parrafo de texto enriquecido
                        text: TextSpan(
                          // Nota: Los estilos de los TextSpans deben ser definidos explicitamente.
                          // Los elementos child del textspan heredarán los estilos del padre
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: width * 0.029,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(text: 'Su próximo pago vence dentro de '),
                            TextSpan(
                                text: '8 días ',
                                style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: width * 0.47,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                alignment: Alignment(0, 0.17),
                                child: Text('\$',
                                    style: TextStyle(
                                        color: Color.fromRGBO(51, 114, 134, 1),
                                        fontSize: width * 0.039,
                                        fontWeight: FontWeight.w900),
                                    textAlign: TextAlign.end)),
                            Container(
                                alignment: Alignment.center,
                                child: Text('537',
                                    style: TextStyle(
                                        color: Color.fromRGBO(51, 114, 134, 1),
                                        fontSize: width * 0.067,
                                        fontWeight: FontWeight.w900),
                                    textAlign: TextAlign.end)),
                            Container(
                                child: Text('00',
                                    style: TextStyle(
                                        color: Color.fromRGBO(51, 114, 134, 1),
                                        fontSize: width * 0.039,
                                        fontWeight: FontWeight.w900),
                                    textAlign: TextAlign.end)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, 'myCredits');
                              },
                              child: Text(
                                'Ver detalles',
                                textAlign: TextAlign.end,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(
                                    color: Color.fromRGBO(51, 114, 134, 1),
                                    fontSize: width * 0.031,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.only(right: 15, left: 15, top: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.red, width: 1.5),
                borderRadius: BorderRadius.circular(7)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '¿Se le complica pagar?',
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                              color: Color.fromRGBO(51, 114, 134, 1),
                              fontSize: width * 0.045,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 3),
                        RichText(
                          //Crea un parrafo de texto enriquecido
                          text: TextSpan(
                            // Nota: Los estilos de los TextSpans deben ser definidos explicitamente.
                            // Los elementos child del textspan heredarán los estilos del padre
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: width * 0.029,
                                fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(text: 'Tiene derecho a '),
                              TextSpan(
                                  text: '2 ',
                                  style: TextStyle(
                                      color: Color.fromRGBO(51, 114, 134, 1))),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                            alignment:
                                                AlignmentDirectional.center,
                                            height: 17,
                                            width: 17,
                                            color: Colors.grey.shade400),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                            alignment:
                                                AlignmentDirectional.center,
                                            height: 17,
                                            width: 17,
                                            color:
                                                Color.fromRGBO(2, 158, 51, 1)),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                            alignment:
                                                AlignmentDirectional.center,
                                            height: 17,
                                            width: 17,
                                            color:
                                                Color.fromRGBO(2, 158, 51, 1)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Extensión 2/3',
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        style: TextStyle(
                                            color: Colors.grey.shade400,
                                            fontSize: width * 0.029,
                                            fontWeight: FontWeight.bold),
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
                                          child: Text(
                                            'Minimo a pagar: ',
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: width * 0.033,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                  alignment: Alignment(0, 0.17),
                                                  child: Text('\$',
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              2, 158, 51, 1),
                                                          fontSize:
                                                              width * 0.036,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                      textAlign:
                                                          TextAlign.end)),
                                              Container(
                                                  alignment: Alignment.center,
                                                  child: Text('537',
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              2, 158, 51, 1),
                                                          fontSize:
                                                              width * 0.064,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                      textAlign:
                                                          TextAlign.end)),
                                              Container(
                                                  child: Text('00',
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              2, 158, 51, 1),
                                                          fontSize:
                                                              width * 0.036,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                      textAlign:
                                                          TextAlign.end)),
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
                                                  color: Colors.black87,
                                                  fontSize: width * 0.029,
                                                  fontWeight: FontWeight.bold),
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
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                disabledColor: Colors.grey,
                                color: Color.fromRGBO(2, 158, 51, 1),
                                elevation: 0,
                                child: Text('ACTIVAR',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * 0.035)),
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
          ),
        ],
      ),
    );
  }

  String _checkRoutesToNewLoans(List<CardModel> userCards) {
    if (userCards.length > 0) {
      return 'newCreditStepOne';
    }
    return 'registerDebitClabe';
  }
}

//Widget de gesto que recibe ciertos parametros para construir opciones del home
class _GestureTapMenuActions extends StatelessWidget {
  final String route;
  final IconData icon;
  final double width;
  final double height;
  final String text;

  const _GestureTapMenuActions(
      {Key? key,
      required this.route,
      required this.icon,
      required this.width,
      required this.height,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, this.route);
      },
      child: Column(
        children: [
          Container(
            width: this.width,
            child: Column(
              children: [
                Container(
                  child: Stack(children: [
                    Icon(this.icon,
                        color: Color.fromARGB(255, 247, 214, 118),
                        size: (this.height * this.width) * 0.0019),
                    Positioned.fill(
                        left: MediaQuery.of(context).size.width / 180, //2.3
                        bottom: MediaQuery.of(context).size.height / 1300, //0.2
                        child: Icon(this.icon,
                            color: Color.fromRGBO(51, 114, 134, 1),
                            size: (this.height * this.width) * 0.00175))
                  ]),
                ),
                Container(
                  child: Text(
                    this.text,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(
                        color: Color.fromRGBO(51, 114, 134, 1),
                        fontSize: this.width * 0.115,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
