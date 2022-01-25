import 'package:flutter/material.dart';

import 'package:prestaprofe/src/ui/input_decorations.dart';
import 'package:prestaprofe/src/utils/icons_string_util.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';

class StepOne extends StatelessWidget{

  String _date = '';
  List<String> _gender = ['Hombre', 'Mujer'];
  List<String> _civilState = ['Soltero/a', 'Casado/a', 'Divorciado/a', 'Separacion en proceso judicial', 'Viudo/a', 'Concubinato'];
  String _optSelectedGender = 'Hombre';
  String _optSelectedCivil = 'Soltero/a';
  TextEditingController _textfieldDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size;
    final _mediaQuerySizeFixedHeightCircles = ((_mediaQuerySize.height - MediaQuery.of(context).padding.top - kToolbarHeight) * 0.063);
    
    return Scaffold(
      appBar: AppBarRegister(textStep: 'INFORMACIÓN PERSONAL', mediaQuerySizeFixedHeightCircles: _mediaQuerySizeFixedHeightCircles),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: _constructRegisterBody(context, _mediaQuerySize)
            )
          ],
        )
      )
    );
  }

  Widget _constructRegisterBody(BuildContext context, Size _mediaQuerySize) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(height: 15),
                Container(
                  decoration: _inputBorderBoxDecoration(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: TextFormField(
                      decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Nombre', prefixIcon: Icons.account_circle_rounded),
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
                      controller: _textfieldDateController,
                      enableInteractiveSelection: false,
                      decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Fecha de nacimiento', prefixIcon: Icons.calendar_today_rounded),
                      onTap: (){
                        //Para quitar el focus del textfield
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _selectDate(context);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: _inputBorderBoxDecoration(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: DropdownButtonFormField(
                            isDense: true,
                            isExpanded: true,
                            decoration: InputDecorations.registerInputDecoration(hintText: 'Seleccione su genero', labelText: 'Genero', prefixIcon: Icons.recent_actors_rounded),
                            icon: Container(
                              child: Icon(                  
                                Icons.arrow_drop_down,  
                                color: Color.fromRGBO(51, 114, 134, 1),   
                              ),
                            ),
                            value: _optSelectedGender,
                            items: getGenderOptionsDropdown(),
                            onChanged: (opt){

                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: _inputBorderBoxDecoration(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: DropdownButtonFormField(
                            isDense: true,
                            isExpanded: true,    
                            decoration: InputDecorations.registerInputDecoration(hintText: 'Seleccione su estado civil', labelText: 'Estado civil', prefixIcon: Icons.book_rounded),
                            icon: Container(
                              child: Icon(                  
                                Icons.arrow_drop_down,  
                                color: Color.fromRGBO(51, 114, 134, 1),   
                              ),
                            ),
                            value: _optSelectedCivil,
                            items: getCivilOptionsDropdown(),
                            onChanged: (opt){

                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  decoration: _inputBorderBoxDecoration(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: TextFormField(
                      decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Domicilio', prefixIcon: Icons.home_rounded),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Table(
                  children: [
                    TableRow(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          decoration: _inputBorderBoxDecoration(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: TextFormField(
                              decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'C. Postal', prefixIcon: Icons.home_rounded),
                            ),
                          ),
                        ),
                        Container(
                          decoration: _inputBorderBoxDecoration(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: TextFormField(
                              decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Estado', prefixIcon: Icons.home_rounded),
                            ),
                          ),
                        ),
                      ]
                    ),
                    TableRow(
                      children: [
                        Container(margin: EdgeInsets.only(top: 10)),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          decoration: _inputBorderBoxDecoration(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: TextFormField(
                              decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Ciudad', prefixIcon: Icons.home_rounded),
                            ),
                          ),
                        ),
                      ]
                    )
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  decoration: _inputBorderBoxDecoration(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: TextFormField(
                      decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'CURP', prefixIcon: Icons.account_circle_rounded),
                    ),
                  ),
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
                      Navigator.pushNamed(context, 'registerStepTwo');
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
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

  _selectDate(BuildContext context) async{
    DateTime? picked = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1940),
      lastDate: new DateTime.now(),
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


