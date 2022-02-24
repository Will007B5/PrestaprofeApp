import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:prestaprofe/src/helpers/helpers.dart';
import 'package:prestaprofe/src/models/client_model.dart';
import 'package:prestaprofe/src/pages/pages.dart';
import 'package:prestaprofe/src/providers/providers.dart';
import 'package:prestaprofe/src/services/services.dart';
import 'package:prestaprofe/src/ui/input_decorations.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';

//Esta clase es un StatefulWidget debido a que hay que setear el estado de esta UI al seleccionar los estados, municipios y colonias mediante el CP
class StepOne extends StatefulWidget {
  @override
  State<StepOne> createState() => _StepOneState();
}
class _StepOneState extends State<StepOne> {
  List<String> _gender = ['Hombre', 'Mujer']; //Lista de opciones con los generos
  List<String> _civilState = ['Soltero/a', 'Casado/a', 'Divorciado/a', 'Separacion en proceso judicial', 'Viudo/a', 'Concubinato']; //Lista de opciones con el estado civil
  TextEditingController _textfieldDateController = new TextEditingController(); //Controlador que lleva la data de la fecha
  TextEditingController _textfieldZipCodeController = new TextEditingController(); //Controlador que lleva la data del codigo postal

  @override
  Widget build(BuildContext context) {

    final _clientsService = Provider.of<ClientsService>(context); 
    final _bdService = Provider.of<DBProvider>(context);

    final _mediaQuerySize = MediaQuery.of(context).size; //MediaQuery con los detalles de medida de pantalla
    final _height = _mediaQuerySize.height; //Alto de la pantalla
    final _width = _mediaQuerySize.width; //Ancho de la pantalla
    final _circleMeassure = _mediaQuerySize.height * _mediaQuerySize.width; //Medida de la circunferencia del paso ubicada en la barra de estado 
    final _mediaQuerySizeFixedHeightCircles = (_circleMeassure * 0.000155);
    final _textInfoWidth = _width * 0.055; //Medida de la fuente a utilizar en la barra de estado

    final _registerStepOneForm = Provider.of<RegisterFormProvider>(context);
    
    return SafeArea(
      top: false,
      child: WillPopScope(
        child: Scaffold(
          appBar: AppBarRegister(textStep: 'INFORMACIÓN PERSONAL', mediaQuerySizeFixedHeightCircles: _mediaQuerySizeFixedHeightCircles, textWidth: _textInfoWidth),
          body: (!_clientsService.isLoading && !_bdService.isLoading) ? Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _constructRegisterBody(context, height: _height, width: _width)
                )
              ],
            )
          ) : LoadingPage()
        ),
        onWillPop: () async {
          final returnToPage = await showReturningPreviousPage(context, '');
          _registerStepOneForm.client = ClientModel.cleanClient(); //Limpia instancia cliente
          _clientsService.cleanFileImages(); //Resetea variables de archivos multimedia del cliente
          return returnToPage;
        },
      ),
    );
  }

  //Este widget tiene la construccion de todo el cuerpo del body de UI
  Widget _constructRegisterBody(BuildContext context, {double? height, double? width}) {

    final _textWidth = width! * 0.035; //Medida de la fuente a utilizar en este body

    final _registerStepOneForm = Provider.of<RegisterFormProvider>(context);
    final _clientForm1 = _registerStepOneForm.client; //Variable ClientModel propia del RegisterFormProvider
    final _bdService = Provider.of<DBProvider>(context);
    _textfieldDateController.text = _clientForm1.birthDate.toString().substring(0,10);

    final _currentOffset = _textfieldZipCodeController.selection.base.offset; //Indica donde está el cursor
    _textfieldZipCodeController.value = TextEditingValue( //Le agregamos al controller de codigo postal los datos del cursor y del valor incial
      text: _bdService.currentCity.zipCode,
      selection: TextSelection.fromPosition(
        TextPosition(offset: _currentOffset),
      ),
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _registerStepOneForm.formKeyStepOne,
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(height: 15),
                TextFormField(
                  style: TextStyle(fontSize: _textWidth),
                  decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Nombre', prefixIcon: Icons.account_circle_rounded, height: height!, textWidth: width),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  enabled: !_registerStepOneForm.isLoading ? true : false,
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  initialValue: _clientForm1.name,
                  onChanged: (value) => _clientForm1.name = value,
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
                  style: TextStyle(fontSize: _textWidth),
                  decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Apellido(s)', prefixIcon: Icons.account_circle_rounded, height: height, textWidth: width),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  enabled: !_registerStepOneForm.isLoading ? true : false,
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  initialValue: _clientForm1.lastName,
                  onChanged: (value) => _clientForm1.lastName = value,
                  inputFormatters: [
                      LengthLimitingTextInputFormatter(50),
                      FilteringTextInputFormatter.allow(RegexHelper.name)
                  ],
                  validator: (value) {
                    return value!.length > 0 ? null : 'Debe llenar este campo';
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  style: TextStyle(fontSize: _textWidth),
                  controller: _textfieldDateController,
                  enableInteractiveSelection: false,
                  enabled: !_registerStepOneForm.isLoading ? true : false,
                  decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Fecha de nacimiento', prefixIcon: Icons.calendar_today_rounded, height: height, textWidth: width),
                  onTap: (){
                    //Para quitar el focus del textfield
                    FocusScope.of(context).requestFocus(new FocusNode());
                    _selectDate(context);
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonFormField(
                        isDense: true,
                        isExpanded: true,
                        decoration: InputDecorations.registerInputDecoration(hintText: 'Seleccione su genero', labelText: 'Genero', prefixIcon: Icons.recent_actors_rounded, height: height, textWidth: width),
                        icon: Container(
                          child: Icon(                  
                            Icons.arrow_drop_down,  
                            color: Color.fromRGBO(51, 114, 134, 1),   
                          ),
                        ),
                        value: _clientForm1.gender,
                        items: _getGenderOptionsDropdown(_textWidth),
                        onChanged: (opt){
                          _clientForm1.gender = opt.toString();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonFormField(
                        isDense: true,
                        isExpanded: true,
                        decoration: InputDecorations.registerInputDecoration(hintText: 'Seleccione su estado civil', labelText: 'Estado civil', prefixIcon: Icons.book_rounded, height: height, textWidth: width),
                        icon: Container(
                          child: Icon(                  
                            Icons.arrow_drop_down,  
                            color: Color.fromRGBO(51, 114, 134, 1),
                          ),
                        ),
                        value: _clientForm1.civilStatus,
                        items: _getCivilOptionsDropdown(_textWidth),
                        onChanged: (opt){
                          _clientForm1.civilStatus = opt.toString();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  style: TextStyle(fontSize: _textWidth),
                  decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Domicilio', prefixIcon: Icons.home_rounded, height: height, textWidth: width),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  enabled: !_registerStepOneForm.isLoading ? true : false,
                  autocorrect: false,
                  keyboardType: TextInputType.streetAddress,
                  initialValue: _clientForm1.address,
                  onChanged: (value) => _clientForm1.address = value,
                  inputFormatters: [ 
                      LengthLimitingTextInputFormatter(50),
                      FilteringTextInputFormatter.allow(RegexHelper.address),
                  ],
                  validator: (value) {
                    return value!.length > 0 ? null : 'Debe llenar este campo';
                  },
                ),
                SizedBox(height: 10),
                Table(
                  children: [
                    TableRow(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: TextFormField(
                            style: TextStyle(fontSize: _textWidth),
                            controller: _textfieldZipCodeController,
                            decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'C. Postal', prefixIcon: Icons.home_rounded, height: height, textWidth: width),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            enabled: !_registerStepOneForm.isLoading ? true : false,
                            autocorrect: false,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(9),
                              FilteringTextInputFormatter.allow(RegexHelper.zipCode)
                            ],
                            onChanged: (value) async {
                              _bdService.currentCity.zipCode = value;
                              if(value.length == 5){
                                final response = await _bdService.getSuggestionsByQuery(value); //Llama a la accion debouncer de busqueda de codigo postal
                                Future.delayed(Duration(milliseconds: 801)).then((_){ //Se requiere ejecutar esta accion despues de 801 milisegundos para actulizar correctamente la UI mediante este setState
                                  if(response == 200){
                                    setState(() {
                                      _registerStepOneForm.formKeyDDCity.currentState!.reset();
                                      _registerStepOneForm.formKeyDDMunicipality.currentState!.reset();
                                      _registerStepOneForm.formKeyDDState.currentState!.reset();
                                    });
                                  }
                                });
                              }
                            },
                            validator: (value) {
                              return (value!.length == 5 && _bdService.isValidZipCode) ? null : 'Código postal no valido. Complete este campo';
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: DropdownButtonFormField(
                                key: _registerStepOneForm.formKeyDDCity,
                                isDense: true,
                                isExpanded: true,
                                decoration: InputDecorations.registerInputDecoration(hintText: 'Seleccione su colonia', labelText: 'Colonia', prefixIcon: Icons.home_rounded, height: height, textWidth: width),
                                icon: Container(
                                  child: Icon(                  
                                    Icons.arrow_drop_down,  
                                    color: Color.fromRGBO(51, 114, 134, 1),
                                  ),
                                ),
                                value: _bdService.currentCity.id,
                                items: _getCitiesOptionsDropdown(context, _textWidth),
                                onChanged: (opt){
                                  _bdService.chargeZipCodeFromCityDropdow(int.parse(opt.toString())); //Llama metodo para cambiar codigo postal
                                  _textfieldZipCodeController.text = _bdService.currentCity.zipCode;
                                  _clientForm1.cityId = _bdService.currentCity.id;
                                },
                              ),
                            ),
                          ],
                        ),
                      ]
                    ),
                    TableRow(
                      children: [
                        Container(margin: EdgeInsets.only(top: 10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                child: DropdownButtonFormField(
                                  key: _registerStepOneForm.formKeyDDMunicipality,
                                  isDense: true,
                                  isExpanded: true,
                                  decoration: InputDecorations.registerInputDecoration(hintText: 'Seleccione su municipio', labelText: 'Municipio', prefixIcon: Icons.home_rounded, height: height, textWidth: width),
                                  icon: Container(
                                    child: Icon(                  
                                      Icons.arrow_drop_down,  
                                      color: Color.fromRGBO(51, 114, 134, 1),
                                    ),
                                  ),
                                  value: _bdService.currentMunicipality.id,
                                  items: _getMunicipalitiesOptionsDropdown(context, _textWidth),
                                  onChanged: (opt) async {
                                    await _bdService.chargePresetsFromMunicipalityDropdown(int.parse(opt.toString())); //Llama metodo para cambiar codigo postal
                                    _textfieldZipCodeController.text = _bdService.currentCity.zipCode;
                                    _clientForm1.cityId = _bdService.currentCity.id;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]
                    ),
                    TableRow(
                      children: [
                        Container(margin: EdgeInsets.only(top: 10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                child: DropdownButtonFormField(
                                  key: _registerStepOneForm.formKeyDDState,
                                  isDense: true,
                                  isExpanded: true,
                                  decoration: InputDecorations.registerInputDecoration(hintText: 'Seleccione su estado', labelText: 'Estado', prefixIcon: Icons.home_rounded, height: height, textWidth: width),
                                  icon: Container(
                                    child: Icon(                  
                                      Icons.arrow_drop_down,  
                                      color: Color.fromRGBO(51, 114, 134, 1),
                                    ),
                                  ),
                                  value: _bdService.currentState.id,
                                  items: _getStatesOptionsDropdown(context, _textWidth),
                                  onChanged: (opt) async{
                                    await _bdService.chargePresetsFromStateDropdown(int.parse(opt.toString())); //Llama metodo para cambiar codigo postal
                                    _textfieldZipCodeController.text = _bdService.currentCity.zipCode;
                                    _clientForm1.cityId = _bdService.currentCity.id;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]
                    )
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  child: TextFormField(
                    style: TextStyle(fontSize: _textWidth),
                    decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'CURP', prefixIcon: Icons.account_circle_rounded, height: height, textWidth: width),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    enabled: !_registerStepOneForm.isLoading ? true : false,
                    autocorrect: false,
                    keyboardType: TextInputType.text,
                    initialValue: _clientForm1.curp,
                    onChanged: (value) => _clientForm1.curp = value.toUpperCase(),
                    textCapitalization: TextCapitalization.characters,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(18),
                      FilteringTextInputFormatter.allow(RegexHelper.curp)
                    ],
                    validator: (value) {
                      return value!.length == 18 ? null : 'Debe introducir CURP válida';
                    },
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
                      _registerStepOneForm.isLoading ? 'Por favor espere...' : 'Continuar', 
                      style: TextStyle(
                        color: Colors.white
                      )
                    ),
                    onPressed: _registerStepOneForm.isLoading ? null : (){
                      FocusScope.of(context).unfocus(); //Linea para ocultar el teclado
                      _clientForm1.cityId = _bdService.currentCity.id;
                      if(!_registerStepOneForm.isValidFormStepOne()) {
                        return;
                      }
                      _registerStepOneForm.stepAppBarCount = 2;
                      Navigator.pushNamed(context, 'registerStepTwo');
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<bool> showReturningPreviousPage(BuildContext context, String inRgisterOrLogedIn) async {
    bool _isTueOrFalse = false;
    await showDialog(
      context: context,
      builder: (context) => WillPopScope(
        child: AlertDialog(
          title: Text('¿Desea cancelar el registro?'),
          content: Text('La información agregada se perderá'),
          actions: [
            TextButton(
              child: Text('No'),
              onPressed: (){
                _isTueOrFalse = false;
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Si'),
              onPressed: (){
                _isTueOrFalse = true;
                Navigator.pop(context);
              },
            ),
          ],
        ),
        onWillPop: () async {
          return false;
        },
      ),
      barrierDismissible: false
    );
    print(_isTueOrFalse);
    return _isTueOrFalse;
  }

  //Metodo que permite llenar el controlador de fecha con la data de la nueva fecha
  void _selectDate(BuildContext context) async{
    final _registerStepOneForm = Provider.of<RegisterFormProvider>(context, listen: false);
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
      _textfieldDateController.text = picked.toString().substring(0,10);
      _clientForm1.birthDate = DateTime.utc(int.parse(_textfieldDateController.text.toString().substring(0,4)), int.parse(_textfieldDateController.text.toString().substring(5,7)), int.parse(_textfieldDateController.text.toString().substring(8,10)));
    }
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
    setState(() {});
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
    setState(() {});
    return list;
  }

  //Creacion de opciones del dropdwon de ciudades
  List<DropdownMenuItem<int>> _getCitiesOptionsDropdown(BuildContext context, double textWidth){
    final _bdService = Provider.of<DBProvider>(context);
    List<DropdownMenuItem<int>> list = [];
    _bdService.citiesList.forEach((city){
      list.add(DropdownMenuItem(
        child: FittedBox(fit: BoxFit.contain, child: Text(city.name, style: TextStyle(fontSize: textWidth))),
        value: city.id,
      ));
    });
    //Se llama setState debido a que hay cierta dependencia entre los componentes de seleccion de estados y municipios en esta UI y tambien deben de cambiar
    setState(() {});
    return list;
  }
}


