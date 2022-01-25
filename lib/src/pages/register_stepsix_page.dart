import 'package:flutter/material.dart';

import 'package:prestaprofe/src/ui/input_decorations.dart';
import 'package:prestaprofe/src/utils/icons_string_util.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';

class StepSix extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size;
    final _mediaQuerySizeFixedHeightCircles = ((_mediaQuerySize.height - MediaQuery.of(context).padding.top - kToolbarHeight) * 0.063);

    return Scaffold(
      appBar: AppBarRegister(textStep: 'VERIFICAR CELULAR', mediaQuerySizeFixedHeightCircles: _mediaQuerySizeFixedHeightCircles),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: _constructRegisterBody(context, _mediaQuerySize),
        ),
      ),
    );
  }

  Widget _constructRegisterBody(BuildContext context, Size _mediaQuerySize) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: _mediaQuerySize.height * 0.195),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            elevation: 15,
            child: Container(
              decoration: _containerCardBoxDecoration(),
              padding: EdgeInsets.symmetric(horizontal: 27, vertical: 17),
              child: Column(
                children: [
                  SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _textFieldOTP(context, first: true, last: false),
                      _textFieldOTP(context, first: false, last: false),
                      _textFieldOTP(context, first: false, last: false),
                      _textFieldOTP(context, first: false, last: true)
                    ],
                  ),
                  SizedBox(height: 25),
                ],
              ),
            ),
          ),
          SizedBox(height: 63),
          Text('Enviar código',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(51, 114, 134, 1),
            ),
          ),
          SizedBox(height: 7),
          Text('¿Aún no recibes el código?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87
            ),
          ),

        ],
      ),
    );
  }

  BoxDecoration _containerCardBoxDecoration() {
    return BoxDecoration(
      color: Color.fromRGBO(255, 255, 255, 1), 
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Color.fromRGBO(51, 114, 134, 1),
        width: 3,
      )
    );
  }

  _textFieldOTP(BuildContext context, {required bool first, required bool last}){
    return Container(
      height: 85,
      child: AspectRatio(
        aspectRatio: 0.7,
        child: TextField(
          autofocus: true,
          onChanged: (value){
            if(value.length == 1 && last == false){
              FocusScope.of(context).nextFocus();
            }
            if(value.length == 0 && first == false){
              FocusScope.of(context).previousFocus();
            }
            // if(value.length == 1 && last == true){
            //   FocusScope.of(context).unfocus(); //Linea para ocultar el teclado
            // }
          },
          cursorColor: Color.fromRGBO(51, 114, 134, 1),
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black12),
              borderRadius: BorderRadius.circular(12)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Color.fromRGBO(51, 114, 134, 1)),
              borderRadius: BorderRadius.circular(12)
            )
          ),
        ),
      ),
    );
  }

}