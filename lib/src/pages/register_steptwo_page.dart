import 'package:flutter/material.dart';
import 'package:prestaprofe/src/utils/icons_string_util.dart';
import 'package:prestaprofe/src/providers/json_menuoptions_provider.dart';

class StepTwo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: 
        _cardFromJSON(jsonMenuOptionsProvider.getMenuOptions['routes']['routesRegisterUser'][1]['childRoutes'], context, size),
      ),
    );
  }

    List<Widget> _cardFromJSON(List<dynamic>? data, BuildContext context, size) {
    final List<Widget> options = [];
    options.add(
      Container(
        width: double.infinity,
        height: size.height * 0.19,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
            ),
            Text(
              'REGISTRO', 
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold
              )
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 3.0),
            ),
            Text(
              'Carga los documentos solicitados',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold

              )
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 3.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(Icons.looks_one, size: 45.0, color: Colors.green),
                Icon(Icons.looks_two, size: 45.0, color: Colors.green),
                Icon(Icons.looks_3_outlined, size: 45.0),
              ],
            )
          ],
        ),
      ),
    );
    if(data != null){
      data.forEach((opt) {
        final widgetTemp = Container(
          width: double.infinity,
          height: size.height * 0.20,
          child: Card(
            color: Colors.grey.shade300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  title: Text(opt['text']),
                  trailing: Icon(Icons.camera_alt, size: 60.0),
                )
              ],
            ),
          ),
        );
        options.add(widgetTemp);
      });
    }
    options.add(
      Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 26.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton(
                child: Text(
                  'Continuar', 
                  style: TextStyle(
                    color: Colors.white
                  )
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                onPressed: (){
                  Navigator.pushNamed(context, 'registerStepThree');
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
          ),
        ],
      )
    );
    return options;
  }
}