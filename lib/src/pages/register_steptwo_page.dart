import 'package:flutter/material.dart';

import 'package:prestaprofe/src/ui/input_decorations.dart';
import 'package:prestaprofe/src/utils/icons_string_util.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';

class StepTwo extends StatelessWidget {

  String _date = '';
  List<String> _gender = ['Hombre', 'Mujer'];
  List<String> _civilState = ['\$3,000.00 a \$10,000.00', '\$10,000.00 a \$20,000.00', '\$20,000.00 a \$30,000.00', '\$30,000.00 a \$40,000.00', '\$40,000.00 a \$50,000.00', 'Mas de \$50,000.00'];
  String _optSelectedCivil = '\$3,000.00 a \$10,000.00';
  TextEditingController _textfieldDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size;
    final _mediaQuerySizeFixedHeightCircles = ((_mediaQuerySize.height - MediaQuery.of(context).padding.top - kToolbarHeight) * 0.063);
    
    return Scaffold(
      appBar: AppBarRegister(textStep: 'INFORMACIÓN LABORAL', mediaQuerySizeFixedHeightCircles: _mediaQuerySizeFixedHeightCircles),
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
        ),
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
                            decoration: InputDecorations.registerInputDecoration(hintText: 'Seleccione su cargo', labelText: 'Cargo', prefixIcon: Icons.cases_rounded),
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
                            decoration: InputDecorations.registerInputDecoration(hintText: 'Seleccione su rango salarial', labelText: 'Rango salarial mensual', prefixIcon: Icons.attach_money_rounded),
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
                      decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'RFC', prefixIcon: Icons.account_circle_rounded),
                    ),
                  ),
                ),
                SizedBox(height: 23),
                Divider(
                  color: Color.fromRGBO(51, 114, 134, 1),
                  thickness: 2.5,
                ),
                SizedBox(height: 5),
                Text('Con motivo de verificación, es necesario agregar la información de contacto de dos personas que puedan brindar alguna referencia sobre usted.', style: TextStyle(fontSize: 16), textAlign: TextAlign.justify),
                SizedBox(height: 10),
                CardTableRegisterStepTwo(),
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
                      Navigator.pushNamed(context, 'registerStepThree');
                    },
                  ),
                ),
              ],
            ),
          ]
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