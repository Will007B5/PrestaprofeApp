import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prestaprofe/src/services/services.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBarHome(), //Widget en carpeta Widgets 
      body: SingleChildScrollView(
        child: _constructHomeBody(context)
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
    final _mediaQuerySizeFixedHeight = _mediaQuerySize.height - MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                color: Color.fromRGBO(191, 155, 48, 1),
                width: double.infinity,
                height: _mediaQuerySize.height - (_mediaQuerySize.height - _mediaQuerySizeFixedHeight), // 1000 - (1000 - 900) = 1000 - 100 = 900
              ),
              Container(
                color: Color.fromRGBO(51, 114, 134, 1),
                width: double.infinity,
                height: 230,
              ),
              Positioned(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 15),

                      _ProfileNameAndPicture(),

                      SizedBox(height: 15),

                      _ProfileCardActions()
                    ]
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
class _ProfileNameAndPicture extends StatelessWidget {
  const _ProfileNameAndPicture({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(130),
            child: Image(
              image: AssetImage('assets/logouser.jpg'),
              fit: BoxFit.fill,
              height: 130 ,
              width: 130 ,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text('Hola, Guillermo Andrés',
            overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class _ProfileCardActions extends StatelessWidget {
  const _ProfileCardActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _mediaQuerySize = MediaQuery.of(context).size;
    final _mediaQuerySizeFixedHeightCircles = ((_mediaQuerySize.height - MediaQuery.of(context).padding.top - kToolbarHeight) *0.135);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 21),
              child: Text(
                "¿Qué quieres hacer?",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Color.fromRGBO(51, 114, 134, 1)
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Table(
                children: [
                  TableRow(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, 'newCreditStepOne');
                        },
                        child: Container(
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(_mediaQuerySizeFixedHeightCircles),
                                child: Container(
                                  child: Icon(Icons.add_circle, color: Colors.white, size: ((_mediaQuerySizeFixedHeightCircles) - 35)),
                                  height: _mediaQuerySizeFixedHeightCircles,
                                  width: _mediaQuerySizeFixedHeightCircles,
                                  color: Color.fromRGBO(51, 114, 134, 0.9)
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text('Solicitar nuevo préstamo',
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: Color.fromRGBO(51, 114, 134, 1),
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, 'myCredits');
                        },
                        child: Container(
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(_mediaQuerySizeFixedHeightCircles),
                                child: Container(
                                  child: Icon(Icons.monetization_on_rounded, color: Colors.white, size: ((_mediaQuerySizeFixedHeightCircles) - 35)),
                                  height: _mediaQuerySizeFixedHeightCircles,
                                  width: _mediaQuerySizeFixedHeightCircles,
                                  color: Color.fromRGBO(51, 114, 134, 0.9)
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text('Mis préstamos',
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: Color.fromRGBO(51, 114, 134, 1),
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ]
                  ),
                  TableRow(
                    children: [
                      Container(),
                      Container(
                        child: Column(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(_mediaQuerySizeFixedHeightCircles),
                              child: Container(
                                child: Icon(Icons.query_stats_rounded, color: Colors.white, size: ((_mediaQuerySizeFixedHeightCircles) - 35)),
                                height: _mediaQuerySizeFixedHeightCircles,
                                width: _mediaQuerySizeFixedHeightCircles,
                                color: Color.fromRGBO(51, 114, 134, 0.9)
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text('Estadísticas generales',
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                style: TextStyle(
                                  color: Color.fromRGBO(51, 114, 134, 1),
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(),
                    ]
                  )
                ],
              ),
            ),
            SizedBox(height: 15)
          ],
        ),
      ),
    );
  }
}