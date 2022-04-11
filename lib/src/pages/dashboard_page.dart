import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:prestaprofe/src/models/models.dart';
import 'package:prestaprofe/src/services/services.dart';
import 'package:prestaprofe/src/ui/prestaprofe_theme.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //_mediaQuerySize.height = tamaño general de la pantalla
    //MediaQuery.of(context).padding.top = tamaño del status bar
    //kToolbarHeight = constante de Flutter que indica el tamaño del appbar
    //kBottomNavigationBarHeight = constante de Flutter que indica el tamaño del BottomNavigationBar

    final _mediaQuerySize = MediaQuery.of(context).size;

    final _width = _mediaQuerySize.width - 30;
    final _height = _mediaQuerySize.height - 30;

    final _containerBoxDecoration = BoxDecoration(
      color: PrestaprofeTheme.mainOptionsContainerFillColor,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(43), topRight: Radius.circular(43))
    );

    return PagesBackground( //Custom widget que pone el fondo
      height: _height,
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(height: 15),
                
                UserAvatar(mediaQuerySize: _mediaQuerySize, height: _height, width: _width, viewedFrom: 'dashboard'), //Widget custom
                
                SizedBox(height: 30),
              ],
            ),
            Expanded(
              child: Container(
                decoration: _containerBoxDecoration,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          _ProfileCardActions(mediaQuerySize: _mediaQuerySize, height: _height, width: _width),
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
                  ]
                ),
              ),
            ),
          ],
        ),
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

    final TextStyle _questionToClientStyle = TextStyle(
      fontSize: this.width * 0.05,
      color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary,
      fontWeight: FontWeight.bold
    );

    final BoxDecoration _clientOptionsContainerBoxDecoration = BoxDecoration(
      color: PrestaprofeTheme.clientOptionsContainerFilledColor,
      border: Border.all(color: PrestaprofeTheme.clientOptionsContainerBorderColor, width: 1.5),
      borderRadius: BorderRadius.circular(7)
    );

    final TextStyle _nextPayTextStyle = TextStyle(
      color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary,
      fontSize: width * 0.045,
      fontWeight: FontWeight.bold
    );

    final TextStyle _nextPayRichTextStyle = TextStyle(
      color: PrestaprofeTheme.black87Text,
      fontSize: width * 0.029,
      fontWeight: FontWeight.bold
    );

    final TextStyle _nextPaySymbolTextStyle = TextStyle(
      color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary,
      fontSize: width * 0.039,
      fontWeight: FontWeight.w900
    );

    final TextStyle _nextPayAmountTextStyle = TextStyle(
      color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary,
      fontSize: width * 0.067,
      fontWeight: FontWeight.w900
    );

    final TextStyle _nextPayCentsTextStyle = TextStyle(
      color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary,
      fontSize: width * 0.039,
      fontWeight: FontWeight.w900
    );

    final TextStyle _nextPayViewDetailsTextStyle = TextStyle(
      color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary,
      fontSize: width * 0.031,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline
    );

    return Container(
      child: Column(
        children: [
          SizedBox(height: 25),
          Text('¿QUÉ DESEA HACER?', style: _questionToClientStyle),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 25),
            decoration: _clientOptionsContainerBoxDecoration,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _GestureTapMenuActions(
                    route: _checkRoutesToNewLoans(_cardsService.filterUserCards(_authService.currentClient.id!)),
                    icon: Icons.payments_rounded,
                    width: (this.width / 3),
                    height: (this.height / 3),
                    text: 'SOLICITAR PRÉSTAMO'
                  )
                ),
                Expanded(
                  child: _GestureTapMenuActions(
                    route: 'myCredits',
                    icon: Icons.payment_rounded,
                    width: (this.width / 3),
                    height: (this.height / 3),
                    text: 'VER/PAGAR PRÉSTAMO'
                  )
                ),
                Expanded(
                  child: _GestureTapMenuActions(
                    route: '',
                    icon: Icons.insert_chart,
                    width: (this.width / 3),
                    height: (this.height / 3),
                    text: 'MI HISTORIAL'
                  )
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            decoration: _clientOptionsContainerBoxDecoration,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: width * 0.53,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('PRÓXIMO A PAGAR', textAlign: TextAlign.start, overflow: TextOverflow.ellipsis, maxLines: 3, style: _nextPayTextStyle),
                      SizedBox(height: 3),
                      RichText(
                        //Crea un parrafo de texto enriquecido
                        text: TextSpan(
                          // Nota: Los estilos de los TextSpans deben ser definidos explicitamente.
                          // Los elementos child del textspan heredarán los estilos del padre
                          style: _nextPayRichTextStyle,
                          children: [
                            TextSpan(text: 'Su próximo pago vence dentro de '),
                            TextSpan(text: '8 días ', style: TextStyle(color: PrestaprofeTheme.accentRedText)),
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
                              child: Text('\$', style: _nextPaySymbolTextStyle,textAlign: TextAlign.end)
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text('537', style: _nextPayAmountTextStyle, textAlign: TextAlign.end)
                            ),
                            Container(
                              child: Text('00', style: _nextPayCentsTextStyle, textAlign: TextAlign.end)
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, 'myCredits');
                              },
                              child: Text('Ver detalles', textAlign: TextAlign.end, overflow: TextOverflow.ellipsis, maxLines: 3, style: _nextPayViewDetailsTextStyle)
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
          ExtensionAd(height: height, width: width, viewedFrom: 'dashboard')
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

  const _GestureTapMenuActions({
    Key? key,
    required this.route,
    required this.icon,
    required this.width,
    required this.height,
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final TextStyle _iconOptionTextStyle = TextStyle(
      color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary,
      fontSize: this.width * 0.115,
      fontWeight: FontWeight.bold
    );

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
                  child: Stack(
                    children: [
                      Icon(this.icon, color: PrestaprofeTheme.dashboardIconContornColor, size: (this.height * this.width) * 0.0019),
                      Positioned.fill(
                        left: MediaQuery.of(context).size.width / 180, //2.3
                        bottom: MediaQuery.of(context).size.height / 1300, //0.2
                        child: Icon(this.icon, color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary, size: (this.height * this.width) * 0.00175)
                      )
                    ]
                  ),
                ),
                Container(
                  child: Text(
                    this.text,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: _iconOptionTextStyle,
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
