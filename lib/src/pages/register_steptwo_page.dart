
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:provider/provider.dart';

import 'package:prestaprofe/src/helpers/helpers.dart';
import 'package:prestaprofe/src/pages/pages.dart';
import 'package:prestaprofe/src/providers/providers.dart';
import 'package:prestaprofe/src/services/services.dart';
import 'package:prestaprofe/src/ui/input_decorations.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';

class StepTwo extends StatelessWidget {

  late List _jobsList; //Varibale que mas se cargará con los jobs hasta que se utilice
  late List _salariesList; //Varibale que mas se cargará con los salaries hasta que se utilice

  TextEditingController _textfieldR1NameController = new TextEditingController(); //Controlador que lleva la data del nombre de la referencia 1
  TextEditingController _textfieldR1PhoneController = new TextEditingController(); //Controlador que lleva la data del telefono de la referencia 1
  TextEditingController _textfieldR2NameController = new TextEditingController(); //Controlador que lleva la data del nombre de la referencia 2
  TextEditingController _textfieldR2PhoneController = new TextEditingController(); //Controlador que lleva la data del telefono de la referencia 2

  @override
  Widget build(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size; //MediaQuery con los detalles de medida de pantalla
    final _height = _mediaQuerySize.height; //Alto de la pantalla
    final _width = _mediaQuerySize.width; //Ancho de la pantalla
    final _circleMeassure = _mediaQuerySize.height * _mediaQuerySize.width; //Medida de la circunferencia del paso ubicada en la barra de estado 
    final _mediaQuerySizeFixedHeightCircles = (_circleMeassure * 0.000155);
    final _textInfoWidth = _width * 0.055; //Medida de la fuente a utilizar en la barra de estado

    final _registerStepTwoForm = Provider.of<RegisterFormProvider>(context);
    final _jobsService = Provider.of<JobsService>(context);
    _jobsList = _jobsService.jobs;
    final _salariesService = Provider.of<SalariesService>(context);
    _salariesList = _salariesService.salaries;

    _textfieldR1NameController.text = _registerStepTwoForm.client.firstReferencePersonName!;
    _textfieldR1PhoneController.text = _registerStepTwoForm.client.firstReferencePersonPhone!;
    _textfieldR2NameController.text = _registerStepTwoForm.client.secondReferencePersonName!;
    _textfieldR2PhoneController.text = _registerStepTwoForm.client.secondReferencePersonPhone!;
    
    return WillPopScope(
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBarRegister(textStep: 'INFORMACIÓN LABORAL', mediaQuerySizeFixedHeightCircles: _mediaQuerySizeFixedHeightCircles, textWidth: _textInfoWidth),
          body: (!_jobsService.isLoading && !_salariesService.isLoading) ? Container(
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
            ),
          ) : LoadingPage(),
        ),
      ),
      onWillPop: () async {
        //Al detectar el boton de retorno, decrementa la variable que controla el paso en el que esta la UI
        _registerStepTwoForm.stepAppBarCount = 1;
        return true;
      },
    );
  }

  //Este widget tiene la construccion de todo el cuerpo del body de UI
  Widget _constructRegisterBody(BuildContext context, {double? height, double? width}) {

    final _registerStepTwoForm = Provider.of<RegisterFormProvider>(context);
    final _clientsService = Provider.of<ClientsService>(context);
    final _clientForm2 = _registerStepTwoForm.client; //Variable ClientModel propia del RegisterFormProvider
    final _textWidth = width! * 0.035; //Medida de la fuente a utilizar en este body

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Form(
        key: _registerStepTwoForm.formKeyStepTwo,
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonFormField(
                        isDense: true,
                        isExpanded: true,
                        decoration: InputDecorations.registerInputDecoration(hintText: 'Seleccione su cargo', labelText: 'Cargo', prefixIcon: Icons.cases_rounded, height: height!, textWidth: width),
                        icon: Container(
                          child: Icon(                  
                            Icons.arrow_drop_down,  
                            color: Color.fromRGBO(51, 114, 134, 1),   
                          ),
                        ),
                        value: _registerStepTwoForm.client.jobId,
                        items: _getJobsOptionsDropdown(_textWidth),
                        onChanged: (opt){
                          _registerStepTwoForm.client.jobId = int.parse( opt.toString() );
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
                        decoration: InputDecorations.registerInputDecoration(hintText: 'Seleccione su rango salarial', labelText: 'Rango salarial mensual', prefixIcon: Icons.attach_money_rounded, height: height, textWidth: width),
                        icon: Container(
                          child: Icon(                  
                            Icons.arrow_drop_down,  
                            color: Color.fromRGBO(51, 114, 134, 1),   
                          ),
                        ),
                        value: _registerStepTwoForm.client.salaryId,
                        items: _getSalariesOptionsDropdown(_textWidth),
                        onChanged: (opt){
                          _registerStepTwoForm.client.salaryId = int.parse( opt.toString() );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  style: TextStyle(fontSize: _textWidth),
                  decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'RFC', prefixIcon: Icons.account_circle_rounded, height: height, textWidth: width),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  enabled: !_registerStepTwoForm.isLoading ? true : false,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  initialValue: _clientForm2.rfc,
                  onChanged: (value) => _clientForm2.rfc = value,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(18),
                    FilteringTextInputFormatter.allow(RegexHelper.rfc)
                  ],
                  validator: (value) {
                    return value!.length == 13 ? null : 'Debe introducir RFC válida';
                  },
                ),
                SizedBox(height: 23),
                Divider(
                  color: Color.fromRGBO(51, 114, 134, 1),
                  thickness: 1.4,
                ),
                SizedBox(height: 5),
                Text('Con motivo de verificación, es necesario agregar la información de contacto de dos personas que puedan brindar alguna referencia sobre usted.', style: TextStyle(fontSize: _textWidth * 1.15), textAlign: TextAlign.justify),
                SizedBox(height: 10),
                _columnReferences1(context, 'REFERENCIA #1', height, width, _textWidth),
                _columnReferences2(context, 'REFERENCIA #2', height, width, _textWidth),
                SizedBox(height: 10)
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
                      FocusScope.of(context).unfocus(); //Linea para ocultar el teclado
                      if(!_registerStepTwoForm.isValidFormStepTwo()) {
                        return;
                      }
                      _clientsService.currentStringJob = _jobsList.firstWhere((job) => job.id == _clientForm2.jobId).name;
                      _clientsService.currentStringSalary = _salariesList.firstWhere((salary) => salary.id == _clientForm2.salaryId).range;
                      _registerStepTwoForm.stepAppBarCount = 3;
                      Navigator.pushNamed(context, 'registerStepThree');
                    },
                  ),
                ),
              ],
            ),
          ]
        ),
      )
    );
  }

  Widget _columnReferences1(BuildContext context, String reference, double? height, double width, double _textWidth) {

    final _registerStepTwoRefsForm = Provider.of<RegisterFormProvider>(context);
    final _clientRefsForm2 = _registerStepTwoRefsForm.client;
    
    return Column(
      children: [
        SizedBox(height: 15),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Color.fromRGBO(255, 255, 255, 0.94),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 23, horizontal: 15),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 1), 
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Color.fromRGBO(51, 114, 134, 1),
                width: 2,
              )
            ),
            child: Column(
              children: [
                Text(reference, style: TextStyle(fontSize: _textWidth * 1.7, fontWeight: FontWeight.bold, color: Color.fromRGBO(51, 114, 134, 1)), textAlign: TextAlign.justify),
                SizedBox(height: 10),
                TextFormField(
                  style: TextStyle(fontSize: _textWidth),
                  decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Nombre completo', prefixIcon: Icons.account_circle_rounded, height: height!, textWidth: width),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  //enabled: !registerStepOneForm.isLoadingStepOne ? true : false,
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  controller: _textfieldR1NameController,
                  onChanged: (value) {
                    _clientRefsForm2.firstReferencePersonName = value;
                  },
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
                  decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Teléfono', prefixIcon: Icons.phone_rounded, height: height, textWidth: width),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  //enabled: !registerStepOneForm.isLoadingStepOne ? true : false,
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  controller: _textfieldR1PhoneController,
                  onChanged: (value) {
                    _clientRefsForm2.firstReferencePersonPhone = value;
                  },
                  inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.allow(RegexHelper.phone)
                  ],
                  validator: (value) {
                    return value!.length > 9 ? null : 'Ingrese el número a 10 digitos';
                  },
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
                      !_registerStepTwoRefsForm.isLoadingContact1 ? 'Buscar contacto en agenda' : 'Cargando', 
                      style: TextStyle(
                        color: Colors.white
                      ),
                      textAlign: TextAlign.center
                    ),
                    onPressed: !(_registerStepTwoRefsForm.isLoadingContact1 || _registerStepTwoRefsForm.isLoadingContact2) ? () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      _registerStepTwoRefsForm.isLoadingContact1 = true;
                      final Contact contact = await _fillContactFromDevice(context);
                      _registerStepTwoRefsForm.isLoadingContact1 = false;
                      if(contact.displayName != null && contact.phones != null){
                        _clientRefsForm2.firstReferencePersonName = contact.displayName!;
                        _clientRefsForm2.firstReferencePersonPhone = RegexHelper.makeValidPhone(phoneNumber: contact.phones![0].value!);
                        _textfieldR1NameController.text = _clientRefsForm2.firstReferencePersonName!;
                        _textfieldR1PhoneController.text = _clientRefsForm2.firstReferencePersonPhone!;
                      }
                    } : null,
                  ),
                ),
              ]
            ),
          ),
        ),
      ],
    );
  }

  Widget _columnReferences2(BuildContext context, String reference, double? height, double width, double _textWidth) {

    final _registerStepTwoRefsForm = Provider.of<RegisterFormProvider>(context);
    final _clientRefsForm2 = _registerStepTwoRefsForm.client;
    
    return Column(
      children: [
        SizedBox(height: 15),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Color.fromRGBO(255, 255, 255, 0.94),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 23, horizontal: 15),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 1), 
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Color.fromRGBO(51, 114, 134, 1),
                width: 2,
              )
            ),
            child: Column(
              children: [
                Text(reference, style: TextStyle(fontSize: _textWidth * 1.7, fontWeight: FontWeight.bold, color: Color.fromRGBO(51, 114, 134, 1)), textAlign: TextAlign.justify),
                SizedBox(height: 10),
                TextFormField(
                  style: TextStyle(fontSize: _textWidth),
                  decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Nombre completo', prefixIcon: Icons.account_circle_rounded, height: height!, textWidth: width),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  //enabled: !registerStepOneForm.isLoadingStepOne ? true : false,
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  controller: _textfieldR2NameController,
                  onChanged: (value) {
                    _clientRefsForm2.secondReferencePersonName = value;
                  },
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
                  decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Teléfono', prefixIcon: Icons.phone_rounded, height: height, textWidth: width),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  //enabled: !registerStepOneForm.isLoadingStepOne ? true : false,
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  controller: _textfieldR2PhoneController,
                  onChanged: (value) {
                    _clientRefsForm2.secondReferencePersonPhone = value;
                  },
                  inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.allow(RegexHelper.phone)
                  ],
                  validator: (value) {
                    return value!.length > 9 ? null : 'Ingrese el número a 10 digitos';
                  },
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
                      !_registerStepTwoRefsForm.isLoadingContact2 ? 'Buscar contacto en agenda' : 'Cargando', 
                      style: TextStyle(
                        color: Colors.white
                      ),
                      textAlign: TextAlign.center
                    ),
                    onPressed: !(_registerStepTwoRefsForm.isLoadingContact1 || _registerStepTwoRefsForm.isLoadingContact2) ? () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      _registerStepTwoRefsForm.isLoadingContact2 = true;
                      final Contact contact = await _fillContactFromDevice(context);
                      _registerStepTwoRefsForm.isLoadingContact2 = false;
                      if(contact.displayName != null && contact.phones != null){
                        _clientRefsForm2.secondReferencePersonName = contact.displayName!;
                        _clientRefsForm2.secondReferencePersonPhone = RegexHelper.makeValidPhone(phoneNumber: contact.phones![0].value!);
                        _textfieldR2NameController.text = _clientRefsForm2.secondReferencePersonName!;
                        _textfieldR2PhoneController.text = _clientRefsForm2.secondReferencePersonPhone!;
                      }
                    } : null,
                  ),
                ),
              ]
            ),
          ),
        ),
      ],
    );
  }

  Future<Contact> _fillContactFromDevice(BuildContext context) async {
    final _mediaQuerySizeWidth = MediaQuery.of(context).size.width;
    final _textInfoWidth = _mediaQuerySizeWidth * 0.055;
    final response = await PermissionsHelper.requestForPermission(permissionType: 'contacts');
    if(response == 200){
      List<Contact> contacts = await ContactsService.getContacts(withThumbnails: false); 
      if(contacts.length > 0){
        final responseContact = await Navigator.push(context, MaterialPageRoute(builder: (context) => ContactsListview(contactsList: contacts, textWidth: _textInfoWidth)));
        if(responseContact != null){
          return responseContact as Contact;
        }
      }
    }
    return new Contact();
  }

  //Creacion de opciones del dropdwon de jobs
  List<DropdownMenuItem<int>> _getJobsOptionsDropdown(double textWidth){
    List<DropdownMenuItem<int>> list = [];
    _jobsList.forEach((job) {
      list.add(DropdownMenuItem(
        child: Text(job.name, style: TextStyle(fontSize: textWidth)),
        value: job.id,
      ));
    });
    return list;
  }

  //Creacion de opciones del dropdwon de salaries
  List<DropdownMenuItem<int>> _getSalariesOptionsDropdown(double textWidth){
    List<DropdownMenuItem<int>> list = [];
    _salariesList.forEach((salary) {
      list.add(DropdownMenuItem(
        child: Text(salary.range, style: TextStyle(fontSize: textWidth)),
        value: salary.id,
      ));
    });
    return list;
  }

}