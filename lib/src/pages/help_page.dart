import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size;

    final width = _mediaQuerySize.width - 30;
    final height = _mediaQuerySize.height - 30;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              child: _CardsFromJSON()
            ),
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
    final _height = _mediaQuerySize.height;
    final _width = _mediaQuerySize.width;
    final _iconSize = _height * _width;
    final _textWidth = _width;
    
    final data = {
      {
        "mainIcon": Icons.support_agent_rounded, 
        "titleCard": "Línea Prestaprofe",
        "bodyCard": "443 320 7494",
        "bodyCardExtra": "Lu - Do, 08:00 a 23:00 h.",
        "subText": "Llamar",
        "subIcon": Icons.phone_rounded,
        "action" : "call"
      },
      {
        "mainIcon": Icons.assignment_ind_rounded, 
        "titleCard": "Contacto Prestaprofe",
        "bodyCard": "Contacte via email con nuestro equipo de soporte",
        "bodyCardExtra": "prestaprofe@email.com",
        "subText": "Escribir",
        "subIcon": Icons.email_rounded,
        "action" : "email"
      },
      {
        "mainIcon": Icons.help, 
        "titleCard": "Preguntas frecuentes",
        "bodyCard": "Obtenga información sobre PrestaprofeApp",
        "bodyCardExtra": "",
        "subText": "Ver",
        "subIcon": Icons.zoom_in_rounded,
        "action" : "questions"
      },
    };

    final List<Widget> options = [];

    options.add(SizedBox(height: 15));

    data.forEach((opt) {
      final widgetTemp = Container(
        padding: EdgeInsets.symmetric(vertical: 4),
        height: _mediaQuerySize.height * 0.235, //Coreggir tamaño por que hace overflow
        child: Card(
          elevation: 9,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            decoration: _containerCardBoxDecoration(context),
            padding: EdgeInsets.only(top: 13),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(opt['mainIcon']! as IconData, size: _iconSize * 0.000215, color: Color.fromRGBO(51, 114, 134, 1)),
                  title: Text(opt['titleCard']!.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: _textWidth * 0.0475), overflow: TextOverflow.ellipsis),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(opt['bodyCard']!.toString(), style: TextStyle(color: Colors.black87, fontSize: _textWidth * 0.035), overflow: TextOverflow.ellipsis, maxLines: 2),
                      opt['bodyCardExtra'] != '' ? Text(opt['bodyCardExtra']!.toString(), style: TextStyle(color: Colors.black87, fontSize: _textWidth * 0.035, fontStyle: FontStyle.italic), overflow: TextOverflow.ellipsis) : Container(),
                    ],
                  )
                ),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () async {
                    await _makeActions(context, opt['action']!.toString());
                  },
                  child: Column(
                    children: [
                      Icon(opt['subIcon']! as IconData, size: _iconSize * 0.00008, color: Color.fromRGBO(51, 114, 134, 1)),
                      Text(opt['subText']!.toString(), style: TextStyle(fontSize: _textWidth * 0.0323, color: Color.fromRGBO(51, 114, 134, 1)))
                    ],
                  ),
                ),
                SizedBox(height: 2)
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
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Color.fromRGBO(51, 114, 134, 1),
        width: 2.3,
      )
    );
  }
}