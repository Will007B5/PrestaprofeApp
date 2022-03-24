import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:prestaprofe/src/services/services.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';


class FrecuentQuestionsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size; //MediaQuery con los detalles de medida de pantalla
    final _width = _mediaQuerySize.width;
    final _textInfoWidth = _width * 0.055; //Medida de la fuente a utilizar en la barra de estado

    final _internetService = Provider.of<InternetService>(context);
    
    double _toolbarHeight = _internetService.hasInternet ? kToolbarHeight : (kToolbarHeight + 19);

    return Scaffold(
      appBar: AppBarHome(textStep: '', textWidth: _textInfoWidth, toolbarHeight: _toolbarHeight), //Widget en carpeta Widgets 
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: _constructFrecuentQuestionsBody(context),
            )
          ]
        )
      ),
    );
  }

  Widget _constructFrecuentQuestionsBody(BuildContext context) {

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
                  Icon(Icons.help, size: _objectSize * 0.00024, color: Color.fromRGBO(51, 114, 134, 1)),
                  Text('PREGUNTAS FRECUENTES', style: TextStyle(color: Color.fromRGBO(51, 114, 134, 1), fontSize: _textWidth * 0.05, fontWeight: FontWeight.bold)),
                ],
              ),
            ]
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('1. ¿Lorem Ipsum Lorem Ipsum?', style: TextStyle(color: Colors.black87, fontSize: _textWidth * 0.045, fontWeight: FontWeight.bold), textAlign: TextAlign.start),
                    Text('R. Excepteur incididunt duis sunt consectetur culpa nulla sunt fugiat. Id occaecat adipisicing veniam laboris dolor id esse est. Enim qui culpa aute incididunt consequat labore dolore ut.', style: TextStyle(color: Colors.black87, fontSize: _textWidth * 0.035), textAlign: TextAlign.start)
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('2. ¿Lorem Ipsum Lorem Ipsum?', style: TextStyle(color: Colors.black87, fontSize: _textWidth * 0.045, fontWeight: FontWeight.bold), textAlign: TextAlign.start),
                    Text('R. Excepteur incididunt duis sunt consectetur culpa nulla sunt fugiat. Id occaecat adipisicing veniam laboris dolor id esse est. Enim qui culpa aute incididunt consequat labore dolore ut.', style: TextStyle(color: Colors.black87, fontSize: _textWidth * 0.035), textAlign: TextAlign.start)
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('3. ¿Lorem Ipsum Lorem Ipsum?', style: TextStyle(color: Colors.black87, fontSize: _textWidth * 0.045, fontWeight: FontWeight.bold), textAlign: TextAlign.start),
                    Text('R. Excepteur incididunt duis sunt consectetur culpa nulla sunt fugiat. Id occaecat adipisicing veniam laboris dolor id esse est. Enim qui culpa aute incididunt consequat labore dolore ut.', style: TextStyle(color: Colors.black87, fontSize: _textWidth * 0.035), textAlign: TextAlign.start)
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('4. ¿Lorem Ipsum Lorem Ipsum?', style: TextStyle(color: Colors.black87, fontSize: _textWidth * 0.045, fontWeight: FontWeight.bold), textAlign: TextAlign.start),
                    Text('R. Excepteur incididunt duis sunt consectetur culpa nulla sunt fugiat. Id occaecat adipisicing veniam laboris dolor id esse est. Enim qui culpa aute incididunt consequat labore dolore ut.', style: TextStyle(color: Colors.black87, fontSize: _textWidth * 0.035), textAlign: TextAlign.start)
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('5. ¿Lorem Ipsum Lorem Ipsum?', style: TextStyle(color: Colors.black87, fontSize: _textWidth * 0.045, fontWeight: FontWeight.bold), textAlign: TextAlign.start),
                    Text('R. Excepteur incididunt duis sunt consectetur culpa nulla sunt fugiat. Id occaecat adipisicing veniam laboris dolor id esse est. Enim qui culpa aute incididunt consequat labore dolore ut.', style: TextStyle(color: Colors.black87, fontSize: _textWidth * 0.035), textAlign: TextAlign.start)
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('6. ¿Lorem Ipsum Lorem Ipsum?', style: TextStyle(color: Colors.black87, fontSize: _textWidth * 0.045, fontWeight: FontWeight.bold), textAlign: TextAlign.start),
                    Text('R. Excepteur incididunt duis sunt consectetur culpa nulla sunt fugiat. Id occaecat adipisicing veniam laboris dolor id esse est. Enim qui culpa aute incididunt consequat labore dolore ut.', style: TextStyle(color: Colors.black87, fontSize: _textWidth * 0.035), textAlign: TextAlign.start)
                  ],
                ),
                SizedBox(height: 10)
              ],
            ),
          )
        ],
      ),
    );

  }
}