import 'package:flutter/material.dart';
import 'package:prestaprofe/src/providers/providers.dart';
import 'package:prestaprofe/src/services/services.dart';

import 'package:prestaprofe/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class StepThree extends StatefulWidget {

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  @override
  Widget build(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size;
    final _height = _mediaQuerySize.height;
    final _width = _mediaQuerySize.width;
    final _circleMeassure = _mediaQuerySize.height * _mediaQuerySize.width;
    final _mediaQuerySizeFixedHeightCircles = (_circleMeassure * 0.000155);
    final _textInfoWidth = _width * 0.055;

    bool _isValidForm = false;
    
    return Scaffold(
      appBar: AppBarRegister(textStep: 'ADJUNTAR ARCHIVOS', mediaQuerySizeFixedHeightCircles: _mediaQuerySizeFixedHeightCircles, textWidth: _textInfoWidth),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: _constructRegisterBody(context, _isValidForm, height: _height, width: _width),
            )
          ],
        )
      ),
    );
  }

  Widget _constructRegisterBody(BuildContext context, bool isValidForm, {double? height, double? width}) {

    final _registerForm = Provider.of<RegisterFormProvider>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Column(
            children: [
              _CardsFromJSON(),
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
                  // onPressed: isValidForm ? () {
                  //   _registerForm.stepAppBarCount = 3;
                  //   Navigator.pushNamed(context, 'registerStepFour');
                  // } : null,
                  onPressed: () {
                    _registerForm.stepAppBarCount = 3;
                    Navigator.pushNamed(context, 'registerStepFour');
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

class _CardsFromJSON extends StatefulWidget {

  @override
  State<_CardsFromJSON> createState() => _CardsFromJSONState();
}

class _CardsFromJSONState extends State<_CardsFromJSON> {
  
  @override
  Widget build(BuildContext context) {

    final _registerForm = Provider.of<RegisterFormProvider>(context);

    final _mediaQuerySize = MediaQuery.of(context).size;
    final _height = _mediaQuerySize.height;
    final _width = _mediaQuerySize.width;
    final _iconSize = _height * _width;
    final _textWidth = _width;
    
    final data = {
      {
        "icon": Icons.file_present_rounded, 
        "text": "Frente identificación INE",
        "type": "ine",
        "asBackend": "ine"
      },
      {
        "icon": Icons.file_present_rounded, 
        "text": "Reverso identificación INE",
        "type": "ineBack",
        "asBackend": "ine_back"
      },
      {
        "icon": Icons.file_present_rounded, 
        "text": "Selfie con INE en mano",
        "type": "selfie",
        "asBackend": "selfie"
      },
      { 
        "icon": Icons.file_present_rounded, 
        "text": "Comprobante de domicilio",
        "type": "proofAddress",
        "asBackend": "proof_address"
      },
      {
        "icon": Icons.file_present_rounded, 
        "text": "Talon de cheque",
        "type": "payStub",
        "asBackend": "pay_stub"
      }
    };
    final List<Widget> options = [];

    options.add(SizedBox(height: 15));

    if(data != null){
      data.forEach((opt) {
        final widgetTemp = Container(
          padding: EdgeInsets.symmetric(vertical: 4),
          height: _mediaQuerySize.height * 0.195,
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'registerStepThreeFile', arguments: opt['type']).then((res) => _refreshPage(_registerForm)),
            child: Card(
              elevation: 15,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Container(
                decoration: _containerCardBoxDecoration(context, opt['asBackend']!.toString()),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      title: Text(opt['text']!.toString(), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: _textWidth * 0.043)),
                      trailing: Icon(opt['icon']! as IconData, size: _iconSize * 0.000215, color: _getColorCard(context, opt['asBackend']!.toString(), 'border')),
                    )
                  ],
                ),
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

  //No borrar este metodo. Es parte del comportamiento de un StatefullWidget
  void _refreshPage(RegisterFormProvider registerForm){
    if(mounted){
      setState(() {

      });
    }
  }

  Color _getColorCard(BuildContext context, String backType, String objectType){
    final _registerStepThreeForm = Provider.of<RegisterFormProvider>(context);
    final _clientForm3 = _registerStepThreeForm.client;
    if(_clientForm3.toMap()[backType] != '' && _clientForm3.toMap()[backType].toString() != 'null'){
      return objectType == 'background' ? Color.fromRGBO(51, 114, 134, 1).withOpacity(0.25) : Color.fromRGBO(51, 114, 134, 1);
    }
    return objectType == 'background' ? Colors.red[900]!.withOpacity(0.13) : Colors.red[900]!;
  }

  BoxDecoration _containerCardBoxDecoration(BuildContext context, String backType) {
    return BoxDecoration(
      color: _getColorCard(context, backType, 'background'), 
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: _getColorCard(context, backType, 'border'),
        width: 3,
      )
    );
  }
}