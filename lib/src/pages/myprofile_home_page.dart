import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prestaprofe/src/providers/providers.dart';
import 'package:prestaprofe/src/ui/input_decorations.dart';
import 'package:provider/provider.dart';

import 'package:prestaprofe/src/helpers/helpers.dart';
import 'package:prestaprofe/src/services/services.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';

class MyProfileHome extends StatelessWidget {

  List<String> _gender = ['Hombre', 'Mujer']; //Lista de opciones con los generos
  List<String> _civilState = ['Soltero/a', 'Casado/a', 'Divorciado/a', 'Separacion en proceso judicial', 'Viudo/a', 'Concubinato']; //Lista de opciones con el estado civil

  @override
  Widget build(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size; //MediaQuery con los detalles de medida de pantalla
    final _width = _mediaQuerySize.width;
    final _textInfoWidth = _width * 0.055; //Medida de la fuente a utilizar en la barra de estado

    final _internetService = Provider.of<InternetService>(context);

    double _toolbarHeight = _internetService.hasInternet ? kToolbarHeight : (kToolbarHeight + 19);

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBarHome(
          textStep: '',
          textWidth: _textInfoWidth,
          toolbarHeight: _toolbarHeight
        ), //Widget en carpeta Widgets
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: _constructMyProfileBody(context)
        ),
        //bottomNavigationBar: CustomBottomNavigation(),
      ),
    );
  }

  Widget _constructMyProfileBody(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size;
    final _authService = Provider.of<AuthService>(context);
    final _loansService = Provider.of<LoansService>(context);
    final _height = _mediaQuerySize.height - 30;
    final _width = _mediaQuerySize.width - 30;
    final _textInputWidth = _width * 0.035; //Medida de la fuente a utilizar en la barra de estado
    final _textWidth = _width;
    final _objectSize = _height * _width;

    return Container(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              child: Image(
                image: AssetImage('assets/homewallpaper.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          CustomScrollView(
            physics: ClampingScrollPhysics(), 
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
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
                              children: <Widget>[
                                Icon(Icons.person, size: _objectSize * 0.00024, color: Color.fromARGB(255, 238, 195, 67)),
                                Text('MI PERFIL',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: _textWidth * 0.05,
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(43), topRight: Radius.circular(43))
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            child: Column(
                              children: [
                                SizedBox(height: 20),
                                Text('DATOS PERSONALES',
                                  style: TextStyle(
                                    color: Color.fromRGBO(51, 114, 134, 1),
                                    fontSize: _textWidth * 0.056,
                                    fontWeight: FontWeight.bold
                                  ),
                                  textAlign: TextAlign.center
                                ),
                                SizedBox(height: 15),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey.shade300, width: 1.5),
                                    borderRadius: BorderRadius.circular(7)
                                  ),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        style: TextStyle(fontSize: _textInputWidth),
                                        decoration: InputDecorations.myProfileHomeInputDecoration(hintText: '', labelText: 'Nombre', prefixIcon: Icons.account_circle_rounded, textWidth: _textInputWidth),
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        //enabled: !_registerStepOneForm.isLoading ? true : false,
                                        autocorrect: false,
                                        keyboardType: TextInputType.name,
                                        //initialValue: _clientForm1.name,
                                        //onChanged: (value) => _clientForm1.name = value,
                                        inputFormatters: [
                                            LengthLimitingTextInputFormatter(50),
                                            FilteringTextInputFormatter.allow(RegexHelper.name) //RegexService es una clase creada en el proyecto para expresiones regulares y validaciones
                                        ],
                                        validator: (value) {
                                          return value!.length > 0 ? null : 'Debe llenar este campo';
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      TextFormField(
                                        style: TextStyle(fontSize: _textInputWidth),
                                        decoration: InputDecorations.myProfileHomeInputDecoration(hintText: '', labelText: 'Apellido(s)', prefixIcon: Icons.account_circle_rounded, textWidth: _textInputWidth),
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        //enabled: !_registerStepOneForm.isLoading ? true : false,
                                        autocorrect: false,
                                        keyboardType: TextInputType.name,
                                        //initialValue: _clientForm1.name,
                                        //onChanged: (value) => _clientForm1.name = value,
                                        inputFormatters: [
                                            LengthLimitingTextInputFormatter(50),
                                            FilteringTextInputFormatter.allow(RegexHelper.name) //RegexService es una clase creada en el proyecto para expresiones regulares y validaciones
                                        ],
                                        validator: (value) {
                                          return value!.length > 0 ? null : 'Debe llenar este campo';
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      TextFormField(
                                        style: TextStyle(fontSize: _textInputWidth),
                                        //controller: _textfieldDateController,
                                        enableInteractiveSelection: false,
                                        //enabled: !_registerStepOneForm.isLoading ? true : false,
                                        decoration: InputDecorations.myProfileHomeInputDecoration(hintText: '', labelText: 'Fecha de nacimiento', prefixIcon: Icons.calendar_today_rounded, textWidth: _textInputWidth),
                                        onTap: (){
                                          //Para quitar el focus del textfield
                                          FocusScope.of(context).requestFocus(new FocusNode());
                                          //_selectDate(context);
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: DropdownButtonFormField(
                                              isDense: true,
                                              isExpanded: true,
                                              decoration: InputDecorations.myProfileHomeInputDecoration(hintText: 'Seleccione su genero', labelText: 'Genero', prefixIcon: Icons.recent_actors_rounded, textWidth: _textInputWidth),
                                              icon: Container(
                                                child: Icon(                  
                                                  Icons.arrow_drop_down,  
                                                  color: Color.fromRGBO(51, 114, 134, 1),   
                                                ),
                                              ),
                                              //value: _clientForm1.gender,
                                              items: _getGenderOptionsDropdown(_textInputWidth),
                                              onChanged: (opt){
                                                //_clientForm1.gender = opt.toString();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: DropdownButtonFormField(
                                              isDense: true,
                                              isExpanded: true,
                                              decoration: InputDecorations.myProfileHomeInputDecoration(hintText: 'Seleccione su estado civil', labelText: 'Estado civil', prefixIcon: Icons.book_rounded, textWidth: _textInputWidth),
                                              icon: Container(
                                                child: Icon(                  
                                                  Icons.arrow_drop_down,  
                                                  color: Color.fromRGBO(51, 114, 134, 1),
                                                ),
                                              ),
                                              //value: _clientForm1.civilStatus,
                                              items: _getCivilOptionsDropdown(_textInputWidth),
                                              onChanged: (opt){
                                                //_clientForm1.civilStatus = opt.toString();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      TextFormField(
                                        style: TextStyle(fontSize: _textInputWidth),
                                        decoration: InputDecorations.myProfileHomeInputDecoration(hintText: '', labelText: 'CURP', prefixIcon: Icons.account_circle_rounded, textWidth: _textInputWidth),
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        //enabled: !_registerStepOneForm.isLoading ? true : false,
                                        autocorrect: false,
                                        keyboardType: TextInputType.text,
                                        //initialValue: _clientForm1.curp,
                                        //onChanged: (value) => _clientForm1.curp = value.toUpperCase(),
                                        textCapitalization: TextCapitalization.characters,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(18),
                                          FilteringTextInputFormatter.allow(RegexHelper.curp)
                                        ],
                                        validator: (value) {
                                          return value!.length == 18 ? null : 'Debe introducir CURP válida';
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text('Domicilio y otros datos importantes',
                                  style: TextStyle(
                                    color: Color.fromRGBO(51, 114, 134, 1),
                                    fontSize: _textWidth * 0.05,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic
                                  ),
                                  textAlign: TextAlign.center
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey.shade300, width: 1.5),
                                    borderRadius: BorderRadius.circular(7)
                                  ),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        style: TextStyle(fontSize: _textInputWidth),
                                        decoration: InputDecorations.myProfileHomeInputDecoration(hintText: '', labelText: 'Domicilio', prefixIcon: Icons.home_rounded, textWidth: _textInputWidth),
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        //enabled: !_registerStepOneForm.isLoading ? true : false,
                                        autocorrect: false,
                                        keyboardType: TextInputType.streetAddress,
                                        //initialValue: _clientForm1.address,
                                        //onChanged: (value) => _clientForm1.address = value,
                                        inputFormatters: [ 
                                            LengthLimitingTextInputFormatter(50),
                                            FilteringTextInputFormatter.allow(RegexHelper.address),
                                        ],
                                        validator: (value) {
                                          return value!.length > 0 ? null : 'Debe llenar este campo';
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      DropdownButtonFormField(
                                        //key: _registerStepOneForm.formKeyDDCity,
                                        isDense: true,
                                        isExpanded: true,
                                        decoration: InputDecorations.myProfileHomeInputDecoration(hintText: 'Seleccione su colonia', labelText: 'Colonia', prefixIcon: Icons.home_rounded, textWidth: _textInputWidth),
                                        icon: Container(
                                          child: Icon(                  
                                            Icons.arrow_drop_down,  
                                            color: Color.fromRGBO(51, 114, 134, 1),
                                          ),
                                        ),
                                        //value: _bdService.currentCity.id,
                                        items: _getCitiesOptionsDropdown(context, _textInputWidth),
                                        onChanged: (opt){
                                          //_bdService.chargeZipCodeFromCityDropdow(int.parse(opt.toString())); //Llama metodo para cambiar codigo postal
                                          //_textfieldZipCodeController.text = _bdService.currentCity.zipCode;
                                          //_clientForm1.cityId = _bdService.currentCity.id;
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      DropdownButtonFormField(
                                        //key: _registerStepOneForm.formKeyDDMunicipality,
                                        isDense: true,
                                        isExpanded: true,
                                        decoration: InputDecorations.myProfileHomeInputDecoration(hintText: 'Seleccione su ciudad o municipio', labelText: 'Ciudad o municipio', prefixIcon: Icons.home_rounded, textWidth: _textInputWidth),
                                        icon: Container(
                                          child: Icon(                  
                                            Icons.arrow_drop_down,  
                                            color: Color.fromRGBO(51, 114, 134, 1),
                                          ),
                                        ),
                                        //value: _bdService.currentMunicipality.id,
                                        items: _getMunicipalitiesOptionsDropdown(context, _textInputWidth),
                                        onChanged: (opt) async {
                                          //await _bdService.chargePresetsFromMunicipalityDropdown(int.parse(opt.toString())); //Llama metodo para cambiar codigo postal
                                          //_textfieldZipCodeController.text = _bdService.currentCity.zipCode;
                                          //_clientForm1.cityId = _bdService.currentCity.id;
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      DropdownButtonFormField(
                                        //key: _registerStepOneForm.formKeyDDState,
                                        isDense: true,
                                        isExpanded: true,
                                        decoration: InputDecorations.myProfileHomeInputDecoration(hintText: 'Seleccione su estado', labelText: 'Estado', prefixIcon: Icons.home_rounded, textWidth: _textInputWidth),
                                        icon: Container(
                                          child: Icon(                  
                                            Icons.arrow_drop_down,  
                                            color: Color.fromRGBO(51, 114, 134, 1),
                                          ),
                                        ),
                                        //value: _bdService.currentState.id,
                                        items: _getStatesOptionsDropdown(context, _textInputWidth),
                                        onChanged: (opt) async {
                                          //await _bdService.chargePresetsFromStateDropdown(int.parse(opt.toString())); //Llama metodo para cambiar codigo postal
                                          //_textfieldZipCodeController.text = _bdService.currentCity.zipCode;
                                          //_clientForm1.cityId = _bdService.currentCity.id;
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Expanded(child: Container()),
                                Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.edit_rounded, size: _objectSize * 0.000085, color: Color.fromRGBO(51, 114, 134, 1)),
                                          SizedBox(width: 5),
                                          Text('Editar Perfil',
                                            style: TextStyle(
                                              color: Color.fromRGBO(51, 114, 134, 1),
                                              fontSize: _textWidth * 0.04,
                                              fontWeight: FontWeight.bold,
                                              decoration: TextDecoration.underline
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 7),
                                    Container(
                                      width: double.infinity,
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                        disabledColor: Colors.grey,
                                        color: Color.fromRGBO(51, 114, 134, 1),
                                        elevation: 0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(_loansService.isLoading
                                              ? 'Guardando'
                                              : 'GUARDAR',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)
                                              ),
                                            SizedBox(width: 5),
                                            Text(_loansService.isLoading
                                              ? 'información...'
                                              : 'INFORMACIÓN',
                                              style: TextStyle(
                                                color: Color.fromARGB(255, 238, 195, 67),
                                                fontWeight: FontWeight.bold
                                              )
                                            ),
                                          ],
                                        ),
                                        onPressed: null,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ]
          ),
        ],
      ),
    );
  }

  //Creacion de opciones del dropdwon de estado civil
  List<DropdownMenuItem<String>> _getCivilOptionsDropdown(double textWidth){
    List<DropdownMenuItem<String>> list = [];
    _civilState.forEach((civil) {
      list.add(DropdownMenuItem(
        child: Text(civil, style: TextStyle(fontSize: textWidth)),
        value: civil,
      ));
    });
    return list;
  }

  //Creacion de opciones del dropdwon de genero
  List<DropdownMenuItem<String>> _getGenderOptionsDropdown(double textWidth){
    List<DropdownMenuItem<String>> list = [];
    _gender.forEach((gender) {
      list.add(DropdownMenuItem(
        child: Text(gender, style: TextStyle(fontSize: textWidth)),
        value: gender,
      ));
    });
    return list;
  }

  //Metodo que permite llenar el controlador de fecha con la data de la nueva fecha
  void _selectDate(BuildContext context) async{
    final _registerStepOneForm = Provider.of<MyProfileHomeFormProvider>(context, listen: false);
    final _clientForm1 = _registerStepOneForm.client;
    DateTime? picked = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1940),
      lastDate: new DateTime.now(),
      locale: Locale('es', 'ES')
    );
    if(picked != null){
      //_textfieldDateController.text = picked.toString().substring(0,10);
      //_clientForm1.birthDate = DateTime.utc(int.parse(_textfieldDateController.text.toString().substring(0,4)), int.parse(_textfieldDateController.text.toString().substring(5,7)), int.parse(_textfieldDateController.text.toString().substring(8,10)));
    }
  }

  //Creacion de opciones del dropdwon de estados
  List<DropdownMenuItem<int>> _getStatesOptionsDropdown(BuildContext context, double textWidth){
    final _bdService = Provider.of<DBProvider>(context);
    List<DropdownMenuItem<int>> list = [];
    _bdService.statesList.forEach((state) {
      list.add(DropdownMenuItem(
        child: FittedBox(fit: BoxFit.contain, child: Text(state.name, style: TextStyle(fontSize: textWidth))),
        value: state.id,
      ));
    });
    //Se llama setState debido a que hay cierta dependencia entre los componentes de seleccion de municipios y ciudades en esta UI y tambien deben de cambiar
    //setState(() {});
    return list;
  }

  //Creacion de opciones del dropdwon de municipios
  List<DropdownMenuItem<int>> _getMunicipalitiesOptionsDropdown(BuildContext context, double textWidth){
    final _bdService = Provider.of<DBProvider>(context);
    List<DropdownMenuItem<int>> list = [];
    _bdService.municipalitiesList.forEach((municipality) {
      list.add(DropdownMenuItem(
        child: FittedBox(fit: BoxFit.contain, child: Text(municipality.name, style: TextStyle(fontSize: textWidth))),
        value: municipality.id,
      ));
    });
    //Se llama setState debido a que hay cierta dependencia entre los componentes de seleccion de estados y ciudades en esta UI y tambien deben de cambiar
    //setState(() {});
    return list;
  }

  //Creacion de opciones del dropdwon de ciudades
  List<DropdownMenuItem<int>> _getCitiesOptionsDropdown(BuildContext context, double textWidth){
    final _bdService = Provider.of<DBProvider>(context);
    List<DropdownMenuItem<int>> list = [];
    _bdService.citiesList.forEach((city){
      list.add(DropdownMenuItem(
        child: FittedBox(fit: BoxFit.contain, child: Text('${city.name} (C.P. ${city.zipCode})', style: TextStyle(fontSize: textWidth))),
        value: city.id,
      ));
    });
    //Se llama setState debido a que hay cierta dependencia entre los componentes de seleccion de estados y municipios en esta UI y tambien deben de cambiar
    //setState(() {});
    return list;
  }
}
