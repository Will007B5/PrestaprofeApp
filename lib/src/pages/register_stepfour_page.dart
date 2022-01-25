import 'package:flutter/material.dart';

import 'package:prestaprofe/src/ui/input_decorations.dart';
import 'package:prestaprofe/src/utils/icons_string_util.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';

class StepFour extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size;
    final _mediaQuerySizeFixedHeightCircles = ((_mediaQuerySize.height - MediaQuery.of(context).padding.top - kToolbarHeight) * 0.063);

    return Scaffold(
      appBar: AppBarRegister(textStep: 'REFERENCIA FAMILIAR', mediaQuerySizeFixedHeightCircles: _mediaQuerySizeFixedHeightCircles),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: _constructRegisterBody(context, _mediaQuerySize)
        ),
      )
    );
  }

  Widget _constructRegisterBody(BuildContext context, Size _mediaQuerySize) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          SizedBox(height: 15),
          Form(
            child: Column(
              children: [
                // _InstructionsAd(),
                Container(
                  decoration: _inputBorderBoxDecoration(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: TextFormField(
                      decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Nombre(s)', prefixIcon: Icons.account_circle_rounded),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: _inputBorderBoxDecoration(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: TextFormField(
                      decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Apellido(s)', prefixIcon: Icons.account_circle_rounded),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: _inputBorderBoxDecoration(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: TextFormField(
                      decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Teléfono', prefixIcon: Icons.account_circle_rounded),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    disabledColor: Colors.grey,
                    color: Color.fromRGBO(51, 114, 134, 1),
                    elevation: 0,
                    child: Text(
                      'Contactos', 
                      style: TextStyle(
                        color: Colors.white
                      )
                    ),
                    onPressed: (){
                      
                    },
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    disabledColor: Colors.grey,
                    color: Color.fromRGBO(51, 114, 134, 1),
                    elevation: 0,
                    child: Text(
                      'Continuar', 
                      style: TextStyle(
                        color: Colors.white
                      )
                    ),
                    onPressed: (){
                      Navigator.pushNamed(context, 'registerStepFive');
                    },
                  ),
                ),
              ]
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _inputBorderBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8),
        border: Border.all(
        color: Color.fromRGBO(51, 114, 134, 1),
        width: 2.4,
      ),
    );
  }

}

class _InstructionsAd extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: _buildBoxDecoration(),
      child: Column(
        children: [
          SizedBox(height: 15),
          Text('Capture una nueva fotografía o seleccione alguna de la galería', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.85)), textAlign: TextAlign.center),
          SizedBox(height: 15),
          Text('- La imágen debe de ser clara', style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.85))),
          SizedBox(height: 5),
          Text('- La información debe ser reciente', style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.85))),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: Color.fromRGBO(51, 114, 134, 0.9),
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.17),
          offset: Offset(0,5),
          blurRadius: 5
        )
      ]
    );
  }
}

