import 'package:flutter/material.dart';
import 'package:prestaprofe/src/providers/json_menuoptions_provider.dart';
import 'package:prestaprofe/src/utils/icons_string_util.dart';

class StepOne extends StatefulWidget {

  @override
  _StepOneState createState() => _StepOneState();

}

class _StepOneState extends State<StepOne>{

  String _date = '';
  List<String> _gender = ['Hombre', 'Mujer'];
  List<String> _civilState = ['Solter@', 'Casad@', 'Viud@', 'Union libre'];
  String _optSelectedGender = 'Hombre';
  String _optSelectedCivil = 'Solter@';
  TextEditingController _textfieldDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

  final size = MediaQuery.of(context).size;

    return Scaffold(
      body: ListView(
        children: _createForm(context, size),
      )
    );
  }

  List<Widget> _createForm(BuildContext context, Size size){
    final List<Widget> textfields = [
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
              'Completa el siguiente formulario',
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
                Icon(Icons.looks_two_outlined, size: 45.0),
                Icon(Icons.looks_3_outlined, size: 45.0),
              ],
            )
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)
                ),
                labelText: 'Nombre'
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
            ),
            TextField(
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)
                ),
                labelText: 'Apellido paterno'
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
            ),
            TextField(
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)
                ),
                labelText: 'Apellido materno'
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
            ),
            TextField(
              controller: _textfieldDateController,
              enableInteractiveSelection: false,
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)
                ),
                labelText: 'Fecha de nacimiento'
              ),
              onTap: (){
                //Para quitar el focus del textfield
                FocusScope.of(context).requestFocus(new FocusNode());
                _selectDate(context);
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: InputDecorator(
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.0)
                      ),
                      labelText: 'Sexo'
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _optSelectedGender,
                        items: getGenderOptionsDropdown(),
                        onChanged: (opt){
                          setState(() {
                            _optSelectedGender = opt.toString();
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: InputDecorator(
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.0)
                      ),
                      labelText: 'Estado civil'
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _optSelectedCivil,
                        items: getCivilOptionsDropdown(),
                        onChanged: (opt){
                          setState(() {
                            _optSelectedCivil = opt.toString();
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
            ),
            TextField(
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)
                ),
                labelText: 'CURP'
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
            ),
            TextField(
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)
                ),
                labelText: 'Domicilio'
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
            ),
            TextField(
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)
                ),
                labelText: 'Institución donde laboras'
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
            ),
            TextField(
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)
                ),
                labelText: 'Tipo de empleo'
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
            ),
            TextField(
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0)
                ),
                labelText: 'Ingresos mensuales'
              ),
            )
          ]
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
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
              Navigator.pushNamed(context, 'registerStepTwo');
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
    ];
    
    return textfields;
  }

  _selectDate(BuildContext context) async{
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1940),
      lastDate: new DateTime(2050),
      locale: Locale('es', 'ES')
    );
    if(picked != null){
      setState(() {
        _date = picked.toIso8601String();
        _textfieldDateController.text = _date;
      });
    }
  }

  List<DropdownMenuItem<String>> getGenderOptionsDropdown(){
    List<DropdownMenuItem<String>> list = [];
    _gender.forEach((gender) {
      list.add(DropdownMenuItem(
        child: Text(gender),
        value: gender,
      ));
    });
    return list;
  }

  List<DropdownMenuItem<String>> getCivilOptionsDropdown(){
    List<DropdownMenuItem<String>> list = [];
    _civilState.forEach((civil) {
      list.add(DropdownMenuItem(
        child: Text(civil),
        value: civil,
      ));
    });
    return list;
  }

}
