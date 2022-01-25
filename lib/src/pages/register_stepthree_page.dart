import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:prestaprofe/src/ui/input_decorations.dart';
import 'package:prestaprofe/src/utils/icons_string_util.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';

class StepThree extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size;
    final _mediaQuerySizeFixedHeightCircles = ((_mediaQuerySize.height - MediaQuery.of(context).padding.top - kToolbarHeight) * 0.063);
    
    return Scaffold(
      appBar: AppBarRegister(textStep: 'ADJUNTAR ARCHIVOS', mediaQuerySizeFixedHeightCircles: _mediaQuerySizeFixedHeightCircles),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: _constructRegisterBody(context, _mediaQuerySize),
            )
          ],
        )
      ),
    );
  }

  Widget _constructRegisterBody(BuildContext context, Size _mediaQuerySize) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'registerStepThreeFile'),
                child: _CardsFromJSON()
              ),
            ],
          ),
          Expanded(child: Container()),
          Column(
            children: [
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
            ],
          ),
        ],
      ),
    );
  }
}

class _CardsFromJSON extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size;
    final data = {
      {
        "icon": Icons.file_present_rounded, 
        "text": "Frente identificación INE"
      },
      {
        "icon": Icons.file_present_rounded, 
        "text": "Reverso identificación INE"
      },
      {
        "icon": Icons.file_present_rounded, 
        "text": "Selfie con INE en mano"
      },
      { 
        "icon": Icons.file_present_rounded, 
        "text": "Comprobante de domicilio"
      },
      {
        "icon": Icons.file_present_rounded, 
        "text": "Talon de cheque"
      }
    };
    final List<Widget> options = [];

    options.add(SizedBox(height: 15));

    if(data != null){
      data.forEach((opt) {
        final widgetTemp = Container(
          padding: EdgeInsets.symmetric(vertical: 4),
          height: _mediaQuerySize.height * 0.205,
          child: Card(
            elevation: 15,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Color.fromRGBO(255, 255, 255, 0.94),
            child: Container(
              decoration: _containerCardBoxDecoration(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    title: Text(opt['text']!.toString(), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                    trailing: Icon(opt['icon']! as IconData, size: 60.0, color: Color.fromRGBO(51, 114, 134, 0.77)),
                  )
                ],
              ),
            ),
          ),
        );

        options.add(widgetTemp);
        
      });
    }
    return Container(
      width: double.infinity,
      child: Column(
        children: options
      )
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

}