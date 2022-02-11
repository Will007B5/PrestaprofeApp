import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:prestaprofe/src/services/services.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';

class HomePage extends StatelessWidget {

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
              child: _constructHomeBody(context),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(), //Widget en carpeta Widgets 
    );
  }

  Widget _constructHomeBody(BuildContext context) {

    //_mediaQuerySize.height = tamaño general de la pantalla
    //MediaQuery.of(context).padding.top = tamaño del status bar
    //kToolbarHeight = constante de Flutter que indica el tamaño del appbar
    //kBottomNavigationBarHeight = constante de Flutter que indica el tamaño del BottomNavigationBar

    final _mediaQuerySize = MediaQuery.of(context).size;

    final _authService = Provider.of<AuthService>(context);

    final width = _mediaQuerySize.width - 30;
    final height = _mediaQuerySize.height - 30;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(height: 15),

              _ProfileNameAndPicture(mediaQuerySize: _mediaQuerySize, height: height, width: width),

              SizedBox(height: 30),

              _ProfileCardActions(mediaQuerySize: _mediaQuerySize, height: height, width: width)
            ],
          ),

          Expanded(child: Container()),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('RESTAN', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontWeight: FontWeight.bold, fontSize: width * 0.04)),
                            Text('(ACTIVAR EXTENSIÓN)', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontWeight: FontWeight.bold, fontSize: width * 0.025))
                          ]
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: CircularPercentIndicator(
                            radius: (height * width) * 0.000055,
                            animation: true,
                            animationDuration: 1200,
                            lineWidth: width * 0.009,
                            percent: 0.6,
                            center: Text('2', style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.035, color: Color.fromRGBO(51, 114, 134, 1))),
                            circularStrokeCap: CircularStrokeCap.butt,
                            backgroundColor: Colors.grey,
                            progressColor: Color.fromRGBO(51, 114, 134, 1),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
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
          CircleAvatar(
            radius: (this.height * this.width) * 0.00032,
            backgroundColor: Color.fromRGBO(51, 114, 134, 1),
            child: CircleAvatar(
              radius: (this.height * this.width) * 0.00030,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(130),
                child: Image(
                  image: AssetImage('assets/logouser.jpg'),
                  fit: BoxFit.fill,
                ),
              )
            ),
          ),
          SizedBox(height: 23),
          Text('HOLA, ${_authService.currentClient.name}',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(51, 114, 134, 1),
              fontWeight: FontWeight.bold,
              fontSize: this.width * 0.069,
            ),
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

    return Container(
      child: Column(
        children: [
          Text(
            '¿QUÉ DESEA HACER?',
            style: TextStyle(
              fontSize: this.width * 0.05,
              color: Color.fromRGBO(51, 114, 134, 1)
            ),
          ),
          SizedBox(height: 30),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _GestureTapMenuActions(route: 'newCreditStepOne', icon: Icons.payments_rounded, width: (this.width / 3), height: (this.height / 3), text: 'SOLICITAR PRÉSTAMO'),
                _GestureTapMenuActions(route: 'myCredits', icon: Icons.payment_rounded, width: (this.width / 3), height: (this.height / 3), text: 'PAGAR PRÉSTAMO'),
                _GestureTapMenuActions(route: '', icon: Icons.insert_chart, width: (this.width / 3), height: (this.height / 3), text: 'VER PRÉSTAMOS'),
              ],
            ),
          ),
          SizedBox(height: 15)
        ],
      ),
    );
  }
}

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

    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, this.route);
      },
      child: Column(
        children: [
          Container(
            width: this.width,
            child: Column(
              children: [
                Container(
                  child: Icon(this.icon, color: Color.fromRGBO(51, 114, 134, 1), size: (this.height * this.width) * 0.0019),
                ),
                Container(
                  child: Text(this.text,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(
                      color: Color.fromRGBO(51, 114, 134, 1),
                      fontSize: this.width * 0.115,
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
}