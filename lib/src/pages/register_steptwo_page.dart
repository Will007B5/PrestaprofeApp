import 'package:flutter/material.dart';

import 'package:prestaprofe/src/providers/json_menuoptions_provider.dart';
import 'package:prestaprofe/src/ui/input_decorations.dart';
import 'package:prestaprofe/src/utils/icons_string_util.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';

class StepTwo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size;
    final _mediaQuerySizeFixedHeightCircles = ((_mediaQuerySize.height - MediaQuery.of(context).padding.top - kToolbarHeight) *0.067);
    
    return Scaffold(
      appBar: AppBarRegister(mediaQuerySizeFixedHeightCircles: _mediaQuerySizeFixedHeightCircles),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color.fromRGBO(191, 155, 48, 0.91),
        child: SingleChildScrollView(
          child: _constructRegisterBody(context, _mediaQuerySize),
        ),
      ),
    );
  }

  Widget _constructRegisterBody(BuildContext context, Size _mediaQuerySize) {

    final _mediaQuerySizeFixedHeight = ((_mediaQuerySize.height - MediaQuery.of(context).padding.top - kToolbarHeight - kBottomNavigationBarHeight - 9));
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          _CardsFromJSON(),

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
                Navigator.pushNamed(context, 'registerStepThree');
              },
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
    final data = jsonMenuOptionsProvider.getMenuOptions['routes']['routesRegisterUser'][1]['childRoutes'];
    final List<Widget> options = [];

    options.add(SizedBox(height: 15));

    if(data != null){
      data.forEach((opt) {
        final widgetTemp = Container(
          height: _mediaQuerySize.height * 0.20,
          child: Card(
            color: Colors.grey.shade300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
    return Container(
      width: double.infinity,
      child: Column(
        children: options
      )
    );
  }
}