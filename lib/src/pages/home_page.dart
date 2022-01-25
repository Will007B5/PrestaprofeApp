import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:prestaprofe/src/services/services.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _authService = Provider.of<AuthService>(context, listen: false);

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

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(height: 15),

              _ProfileNameAndPicture(),

              SizedBox(height: 30),

              _ProfileCardActions(mediaQuerySize: _mediaQuerySize, height: _mediaQuerySize.height, width: _mediaQuerySize.width - 30)
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
                            Text('RESTAN', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontWeight: FontWeight.bold, fontSize: 14.0)),
                            Text('(ACTIVAR EXTENSIÓN)', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontWeight: FontWeight.bold, fontSize: 8.0))
                          ]
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: CircularPercentIndicator(
                            radius: 12.0,
                            animation: true,
                            animationDuration: 1200,
                            lineWidth: 4.0,
                            percent: 0.6,
                            center: Text('2', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0, color: Color.fromRGBO(51, 114, 134, 1))),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CircleAvatar(
            radius: 80,
            backgroundColor: Color.fromRGBO(51, 114, 134, 1),
            child: CircleAvatar(
              radius: 75,
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
          Text('HOLA, GUILLERMO ANDRÉS',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(51, 114, 134, 1),
              fontWeight: FontWeight.bold,
              fontSize: 23.0,
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
              fontSize: 15.0,
              color: Color.fromRGBO(51, 114, 134, 1)
            ),
          ),
          SizedBox(height: 30),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _GestureTapMenuActions(route: 'newCreditStepOne', icon: Icons.payments_rounded, width: (this.width / 3), text: 'SOLICITAR PRÉSTAMO'),
                _GestureTapMenuActions(route: 'myCredits', icon: Icons.payment_rounded, width: (this.width / 3), text: 'PAGAR PRÉSTAMO'),
                _GestureTapMenuActions(route: '', icon: Icons.insert_chart, width: (this.width / 3), text: 'VER PRÉSTAMOS'),
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
  final String text;

  const _GestureTapMenuActions({
    Key? key, 
    required this.route, 
    required this.icon, 
    required this.width, 
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
                  child: Icon(this.icon, color: Color.fromRGBO(51, 114, 134, 1), size: 55),
                ),
                Container(
                  child: Text(this.text,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(
                      color: Color.fromRGBO(51, 114, 134, 1),
                      fontSize: 12.0,
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