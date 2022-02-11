
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:prestaprofe/src/models/client_model.dart';
import 'package:provider/provider.dart';

import 'package:prestaprofe/src/pages/pages.dart';
import 'package:prestaprofe/src/providers/providers.dart';
import 'package:prestaprofe/src/services/services.dart';
import 'package:prestaprofe/src/ui/input_decorations.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';
import 'package:prestaprofe/src/helpers/helpers.dart';

class StepTwo extends StatelessWidget {

  late List _jobsList;
  late List _salariesList;

  TextEditingController _textfieldR1NameController = new TextEditingController();
  TextEditingController _textfieldR1PhoneController = new TextEditingController();
  TextEditingController _textfieldR2NameController = new TextEditingController();
  TextEditingController _textfieldR2PhoneController = new TextEditingController();

  bool _isLoadingContacts = false;

  @override
  Widget build(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size;
    final _height = _mediaQuerySize.height;
    final _width = _mediaQuerySize.width;
    final _circleMeassure = _mediaQuerySize.height * _mediaQuerySize.width;
    final _mediaQuerySizeFixedHeightCircles = (_circleMeassure * 0.000155);
    final _textInfoWidth = _width * 0.055;

    final _registerStepTwoForm = Provider.of<RegisterFormProvider>(context);
    final _jobsService = Provider.of<JobsService>(context);
    _jobsList = _jobsService.jobs;
    final _salariesService = Provider.of<SalariesService>(context);
    _salariesList = _salariesService.salaries;

    _textfieldR1NameController.text = _registerStepTwoForm.client.firstReferencePersonName;
    _textfieldR1PhoneController.text = _registerStepTwoForm.client.firstReferencePersonPhone;
    _textfieldR2NameController.text = _registerStepTwoForm.client.secondReferencePersonName;
    _textfieldR2PhoneController.text = _registerStepTwoForm.client.secondReferencePersonPhone;
    
    return Scaffold(
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
      // floatingActionButton: (_registerStepTwoForm.isFormReferences1Active || _registerStepTwoForm.isFormReferences2Active) ? FloatingActionButton(
      //   child: Icon(Icons.import_contacts_rounded, color: Colors.white),
      //   backgroundColor: Color.fromRGBO(51, 114, 134, 1),
      //   elevation: 0,
      //   onPressed: () async {
      //     final response = await PermissionsHelper.requestForPermission(permissionType: 'contacts');
      //     if(response == 200){
      //       List<Contact> contacts = await ContactsService.getContacts();  
      //       print(contacts[0].phones![0].value);
      //       if(!_registerStepTwoForm.isValidFormStepTwo()) return;
      //     }
      //   },
      // ) : null
    );
  }

  Widget _constructRegisterBody(BuildContext context, {double? height, double? width}) {

    final _registerStepTwoForm = Provider.of<RegisterFormProvider>(context);

    final _textWidth = width! * 0.035;

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Form(
        key: _registerStepTwoForm.formKeyStepTwo,
        // child: _registerStepTwoForm.isFormReferences1Active ?
        //   _columnReferences1(context, 'REFERENCIA #1', height, width, _textWidth) : _registerStepTwoForm.isFormReferences2Active ? 
        //   _columnReferences2(context, 'REFERENCIA #2', height, width, _textWidth) :
        //   _columnMainStepTwo(height, width, _textWidth, context),
        child: _columnMainStepTwo(height, width, _textWidth, context),
      )
    );

  }

  Column _columnMainStepTwo(double? height, double width, double _textWidth, BuildContext context) {

    final _registerStepTwoForm = Provider.of<RegisterFormProvider>(context);
    final _clientForm2 = _registerStepTwoForm.client;

    return Column(
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
                    items: getJobsOptionsDropdown(_textWidth),
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
                    items: getSalariesOptionsDropdown(_textWidth),
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
                FilteringTextInputFormatter.allow(RegExp(r'^[0-9a-zA-z]{0,13}'))
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
            // CardTableRegisterStepTwo(),
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
                  if(!_registerStepTwoForm.isValidFormStepTwo()) {
                    _registerStepTwoForm.stepAppBarCount = 1;
                    return;
                  }
                  _registerStepTwoForm.stepAppBarCount = 2;
                  Navigator.pushNamed(context, 'registerStepThree');
                },
              ),
            ),
          ],
        ),
      ]
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
                      FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-zÁÉÍÓÚÜáéíóúüÑñ. ]{0,50}'))
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
                      FilteringTextInputFormatter.allow(RegExp(r'^[0-9]{0,10}'))
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
                      !_isLoadingContacts ? 'Buscar contacto en agenda' : 'Cargando', 
                      style: TextStyle(
                        color: Colors.white
                      ),
                      textAlign: TextAlign.center
                    ),
                    onPressed: !_isLoadingContacts ? () async {
                      final Contact contact = await fillContactFromDevice(context);
                      if(contact.displayName != null && contact.phones != null){
                        String resultFilteredNumber = contact.phones![0].value!.replaceAll(RegExp("[-!\$%^&*()_+|~=`{}\\[\\]:;'<>?,.\\/\"]"), "").replaceAll(RegExp(r"\s\b|\b\s"), "");
                        String finalPhoneNumber = '';
                        if(resultFilteredNumber.startsWith('521')){
                          finalPhoneNumber = resultFilteredNumber.substring(3);
                        }
                        else if(resultFilteredNumber.startsWith('52')){
                          finalPhoneNumber = resultFilteredNumber.substring(2);
                        }
                        else{
                          finalPhoneNumber = resultFilteredNumber;
                        }
                        _clientRefsForm2.firstReferencePersonName = contact.displayName!;
                        _clientRefsForm2.firstReferencePersonPhone = finalPhoneNumber;
                        _textfieldR1NameController.text = _clientRefsForm2.firstReferencePersonName;
                        _textfieldR1PhoneController.text = _clientRefsForm2.firstReferencePersonPhone;
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
                      FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-zÁÉÍÓÚÜáéíóúüÑñ. ]{0,50}'))
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
                      FilteringTextInputFormatter.allow(RegExp(r'^[0-9]{0,10}'))
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
                      !_isLoadingContacts ? 'Buscar contacto en agenda' : 'Cargando', 
                      style: TextStyle(
                        color: Colors.white
                      ),
                      textAlign: TextAlign.center
                    ),
                    onPressed: !_isLoadingContacts ? () async {
                      final Contact contact = await fillContactFromDevice(context);
                      if(contact.displayName != null && contact.phones != null){
                        String resultFilteredNumber = contact.phones![0].value!.replaceAll(RegExp("[-!\$%^&*()_+|~=`{}\\[\\]:;'<>?,.\\/\"]"), "").replaceAll(RegExp(r"\s\b|\b\s"), "");
                        String finalPhoneNumber = '';
                        if(resultFilteredNumber.startsWith('521')){
                          finalPhoneNumber = resultFilteredNumber.substring(3);
                        }
                        else if(resultFilteredNumber.startsWith('52')){
                          finalPhoneNumber = resultFilteredNumber.substring(2);
                        }
                        else{
                          finalPhoneNumber = resultFilteredNumber;
                        }
                        _clientRefsForm2.secondReferencePersonName = contact.displayName!;
                        _clientRefsForm2.secondReferencePersonPhone = finalPhoneNumber;
                        _textfieldR1NameController.text = _clientRefsForm2.secondReferencePersonName;
                        _textfieldR1PhoneController.text = _clientRefsForm2.secondReferencePersonPhone;
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

  Future<Contact> fillContactFromDevice(BuildContext context) async {
    _isLoadingContacts = true;
    final response = await PermissionsHelper.requestForPermission(permissionType: 'contacts');
    _isLoadingContacts = false;
    if(response == 200){
      List<Contact> contacts = await ContactsService.getContacts(); 
      if(contacts.length > 0){
        final responseContact = await Navigator.push(context, MaterialPageRoute(builder: (context) => ContactsListview(contactsList: contacts)));
        if(responseContact != null){
          return responseContact as Contact;
        }
      }
    }
    return new Contact();
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

  List<DropdownMenuItem<int>> getJobsOptionsDropdown(double textWidth){
    List<DropdownMenuItem<int>> list = [];
    _jobsList.forEach((job) {
      list.add(DropdownMenuItem(
        child: Text(job.name, style: TextStyle(fontSize: textWidth)),
        value: job.id,
      ));
    });
    return list;
  }

  List<DropdownMenuItem<int>> getSalariesOptionsDropdown(double textWidth){
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