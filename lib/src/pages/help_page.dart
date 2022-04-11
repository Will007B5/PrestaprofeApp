import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:prestaprofe/src/services/services.dart';
import 'package:prestaprofe/src/ui/custom_uis.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';

class HelpPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size;

    final _authService = Provider.of<AuthService>(context);

    final _height = _mediaQuerySize.height - 30;
    final _width = _mediaQuerySize.width - 30;
    final _textWidth = _width;
    final _objectSize = _height * _width;

    return PagesBackground(
      height: _height,
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.help, size: _objectSize * 0.00024, color: PrestaprofeTheme.goldenIconPages),
                      Text('AYUDA',
                        style: TextStyle(
                          color: PrestaprofeTheme.whiteTextTitlePages,
                          fontSize: _textWidth * 0.05,
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 3),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: PrestaprofeTheme.mainOptionsContainerFillColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(43), topRight: Radius.circular(43))
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text('${_authService.currentClient.name}',
                        style: TextStyle(
                            color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary,
                            fontSize: _textWidth * 0.065,
                            fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center
                      ),
                      SizedBox(height: 7),
                      Text('¿CÓMO PODEMOS AYUDARLE?',
                        style: TextStyle(
                          color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary,
                          fontSize: _textWidth * 0.039,
                          fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center
                      ),
                      _CardsFromJSON(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        // child: Column(
        //   children: [
        //     _CardsFromJSON(),
        //   ],
        // )
      ),
    );
  }
}

class _CardsFromJSON extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size;
    final _height = _mediaQuerySize.height;
    final _width = _mediaQuerySize.width;
    final _iconSize = _height * _width;
    final _textWidth = _width;
    
    final data = {
      {
        "mainIcon": Icons.support_agent_rounded, 
        "titleCard": "Línea Prestaprofe",
        "bodyCard": "443-320-7494",
        "bodyCardExtra": "Lun a Vie 08:00 am a 18:00 hrs",
        "subText": "Llamar",
        "subIcon": Icons.phone_rounded,
        "action" : "call"
      },
      {
        "mainIcon": Icons.assignment_ind_rounded, 
        "titleCard": "Contacto Prestaprofe",
        "bodyCard": "Contacte via email con nuestro equipo de soporte",
        "bodyCardExtra": "info@prestaprofe.com",
        "subText": "Escribir",
        "subIcon": Icons.email_rounded,
        "action" : "email"
      },
      {
        "mainIcon": Icons.help, 
        "titleCard": "Preguntas frecuentes",
        "bodyCard": "¿Tiene dudas? En nuestra sección de preguntas frecuentes podrá encontrar información sobre la app",
        "bodyCardExtra": "",
        "subText": "Ver",
        "subIcon": Icons.zoom_in_rounded,
        "action" : "questions"
      },
    };

    final List<Widget> options = [];

    options.add(SizedBox(height: 10));

    data.forEach((opt) {
      final widgetTemp = Container(
        height: _mediaQuerySize.height * 0.2, //Coreggir tamaño por que hace overflow
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            decoration: _containerCardBoxDecoration(context),
            padding: EdgeInsets.only(top: 13),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(opt['mainIcon']! as IconData, size: _iconSize * 0.000215, color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary),
                  title: Text(opt['titleCard']!.toString().toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary, fontSize: _textWidth * 0.0434), overflow: TextOverflow.ellipsis),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(opt['bodyCard']!.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: PrestaprofeTheme.black87Text, fontSize: _textWidth * 0.035), overflow: TextOverflow.ellipsis, maxLines: 3),
                      opt['bodyCardExtra'] != '' ? Text(opt['bodyCardExtra']!.toString(), style: TextStyle(color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary, fontSize: _textWidth * 0.035, fontStyle: FontStyle.italic), overflow: TextOverflow.ellipsis) : Container(),
                    ],
                  )
                ),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () async {
                    await _makeActions(context, opt['action']!.toString());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(opt['subIcon']! as IconData, size: _iconSize * 0.00008, color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary),
                      SizedBox(width: 7),
                      Text(opt['subText']!.toString(), style: TextStyle(fontSize: _textWidth * 0.0323, color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary))
                    ],
                  ),
                ),
                SizedBox(height: 10)
              ],
            ),
          ),
        ),
      );
      options.add(widgetTemp);
    });
    return Container(
      width: double.infinity,
      child: Column(
        children: options
      )
    );
  }

  //Agregar un dialogo para pedir esta confirmacion
  Future<int> _makeActions(BuildContext context, String actionType) async {
    switch(actionType){
      case 'call':
        // Android and iOS
        const uri = 'tel:4433207494';
        if (await canLaunch(uri)) {
          await launch(uri);
        } else {
          throw 'Could not launch $uri';
        }
        break;
      case 'email':
        // Android and iOS
        const uri = 'mailto:prestaprofe@email.com?subject=Soporte&body=Buen%20Dia';
        if (await canLaunch(uri)) {
          await launch(uri);
        } else {
          throw 'Could not launch $uri';
        }
        break;
      case 'questions':
        Navigator.pushNamed(context, 'frecuentQuestions');
        break;
    }
    return 400;
  }

  //Decoration que contornea de un color la card
  BoxDecoration _containerCardBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: PrestaprofeTheme.clientOptionsContainerFilledColor,
      border: Border.all(color: PrestaprofeTheme.clientOptionsContainerBorderColor, width: 1.5),
      borderRadius: BorderRadius.circular(7)
    );
  }
}