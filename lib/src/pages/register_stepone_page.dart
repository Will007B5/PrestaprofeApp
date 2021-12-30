import 'package:flutter/material.dart';

import 'package:prestaprofe/src/providers/json_menuoptions_provider.dart';
import 'package:prestaprofe/src/ui/input_decorations.dart';
import 'package:prestaprofe/src/utils/icons_string_util.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';

class StepOne extends StatelessWidget{

  String _date = '';
  List<String> _gender = ['Hombre', 'Mujer'];
  List<String> _civilState = ['Solter@', 'Casad@', 'Viud@', 'Union libre'];
  String _optSelectedGender = 'Hombre';
  String _optSelectedCivil = 'Solter@';
  TextEditingController _textfieldDateController = new TextEditingController();

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
          child: _constructRegisterBody(context, _mediaQuerySize)
        ),
      )
    );
  }

  Widget _constructRegisterBody(BuildContext context, Size _mediaQuerySize) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(height: 15),
          Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecorations.registerInputDecoration(hintText: 'Juan', labelText: 'Nombre', prefixIcon: Icons.account_circle_rounded),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecorations.registerInputDecoration(hintText: 'Pérez', labelText: 'Apellido Paterno', prefixIcon: Icons.account_circle_rounded),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecorations.registerInputDecoration(hintText: 'Pérez', labelText: 'Apellido Materno', prefixIcon: Icons.account_circle_rounded),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _textfieldDateController,
                  enableInteractiveSelection: false,
                  decoration: InputDecorations.registerInputDecoration(hintText: '16-09-1993', labelText: 'Fecha de nacimiento', prefixIcon: Icons.calendar_today_rounded),
                  onTap: (){
                    //Para quitar el focus del textfield
                    FocusScope.of(context).requestFocus(new FocusNode());
                    _selectDate(context);
                  },
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonFormField(
                        decoration: InputDecorations.registerInputDecoration(hintText: 'Seleccione su genero', labelText: 'Genero', prefixIcon: Icons.recent_actors_rounded),
                        value: _optSelectedGender,
                        items: getGenderOptionsDropdown(),
                        onChanged: (opt){
          
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonFormField(
                        decoration: InputDecorations.registerInputDecoration(hintText: 'Seleccione su estado civil', labelText: 'Estado civil', prefixIcon: Icons.book_rounded),
                        value: _optSelectedCivil,
                        items: getCivilOptionsDropdown(),
                        onChanged: (opt){
          
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecorations.registerInputDecoration(hintText: 'FRKLP0795D4T0', labelText: 'CURP', prefixIcon: Icons.create_rounded),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecorations.registerInputDecoration(hintText: 'Avenida Acueducto #27', labelText: 'Domicilio', prefixIcon: Icons.home_rounded),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecorations.registerInputDecoration(hintText: 'Zona Centro', labelText: 'Colonia', prefixIcon: Icons.home_rounded),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecorations.registerInputDecoration(hintText: 'Morelia', labelText: 'Ciudad', prefixIcon: Icons.home_rounded),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecorations.registerInputDecoration(hintText: 'Michoacán', labelText: 'Estado', prefixIcon: Icons.home_rounded),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecorations.registerInputDecoration(hintText: 'Nombre y telefono', labelText: 'Referencia familiar', prefixIcon: Icons.home_rounded),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecorations.registerInputDecoration(hintText: 'Seleccione una institución', labelText: 'Institución', prefixIcon: Icons.work_rounded),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecorations.registerInputDecoration(hintText: 'Otra institución', labelText: 'Institución', prefixIcon: Icons.work_rounded),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecorations.registerInputDecoration(hintText: 'Seleccione un tipo de empleo', labelText: 'Empleo', prefixIcon: Icons.work_rounded),
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
                      Navigator.pushNamed(context, 'registerStepTwo');
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

  _selectDate(BuildContext context) async{
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1940),
      lastDate: new DateTime(2050),
      locale: Locale('es', 'ES')
    );
    if(picked != null){
      
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


