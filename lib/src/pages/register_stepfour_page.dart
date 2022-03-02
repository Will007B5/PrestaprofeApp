import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:prestaprofe/src/helpers/helpers.dart';
import 'package:prestaprofe/src/models/models.dart';
import 'package:prestaprofe/src/pages/pages.dart';
import 'package:prestaprofe/src/providers/providers.dart';
import 'package:prestaprofe/src/services/clients_service.dart';
import 'package:prestaprofe/src/services/services.dart';
import 'package:prestaprofe/src/ui/input_decorations.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';

class StepFour extends StatelessWidget {

  TextEditingController _textfieldConfirmPasswordController = new TextEditingController(); //Controlador que lleva la data de la confirmacion de contraseña

  @override
  Widget build(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size; //MediaQuery con los detalles de medida de pantalla
    final _height = _mediaQuerySize.height; //Alto de la pantalla
    final _width = _mediaQuerySize.width; //Ancho de la pantalla
    final _circleMeassure = _mediaQuerySize.height * _mediaQuerySize.width; //Medida de la circunferencia del paso ubicada en la barra de estado 
    final _mediaQuerySizeFixedHeightCircles = (_circleMeassure * 0.000155);
    final _textInfoWidth = _width * 0.055; //Medida de la fuente a utilizar en la barra de estado

    final _registerStepFourForm = Provider.of<RegisterFormProvider>(context);
    final _clientsService = Provider.of<ClientsService>(context);
    
    return WillPopScope(
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBarRegister(textStep: 'INFORMACIÓN DE SESIÓN', mediaQuerySizeFixedHeightCircles: _mediaQuerySizeFixedHeightCircles, textWidth: _textInfoWidth),
          body: (!_clientsService.isSaving) ? Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _constructRegisterBody(context, height: _height, width: _width),
                )
              ],
            ),
          ) : LoadingPage()
        ),
      ),
      onWillPop: () async {
        _registerStepFourForm.stepAppBarCount = 3;
        return true;
      },
    );
  }

  //Este widget tiene la construccion de todo el cuerpo del body de UI
  Widget _constructRegisterBody(BuildContext context, {double? height, double? width}) {

    final _textWidth = width! * 0.035;

    final _registerStepFourForm = Provider.of<RegisterFormProvider>(context);
    final _clientsService = Provider.of<ClientsService>(context);
    final _clientForm4 = _registerStepFourForm.client;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _registerStepFourForm.formKeyStepFour,
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(height: 15),
                TextFormField(
                  style: TextStyle(fontSize: _textWidth),
                  decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Email', prefixIcon: Icons.account_circle_rounded, height: height!, textWidth: width),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  enabled: !_registerStepFourForm.isLoading ? true : false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  initialValue: _clientForm4.email,
                  onChanged: (value) => _clientForm4.email = value,
                  inputFormatters: [
                      LengthLimitingTextInputFormatter(50),
                  ],
                  validator: (value) {
                    return RegexHelper.email.hasMatch(value ?? '') ? null : 'Ingrese un correo válido';
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  style: TextStyle(fontSize: _textWidth),
                  decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Contraseña', prefixIcon: Icons.account_circle_rounded, suffixIcon: _registerStepFourForm.obscurePasswordFieldStepFour ? Icons.visibility_off : Icons.visibility, context: context, height: height, textWidth: width),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  enabled: !_registerStepFourForm.isLoading ? true : false,
                  enableSuggestions: false,
                  autocorrect: false,
                  obscureText: !_registerStepFourForm.obscurePasswordFieldStepFour,
                  keyboardType: TextInputType.text,
                  initialValue: _clientForm4.password,
                  inputFormatters: [
                      LengthLimitingTextInputFormatter(25),
                  ],
                  onChanged: (value) => _clientForm4.password = value,
                  validator: (value) {
                    if(value != null && value.length > 8){
                      return null;
                    }
                    return 'Ingrese la contraseña. Debe ser mayor a 8 caracteres';
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  style: TextStyle(fontSize: _textWidth),
                  decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Repita la contraseña', prefixIcon: Icons.account_circle_rounded, suffixIcon: _registerStepFourForm.obscurePasswordFieldStepFour ? Icons.visibility_off : Icons.visibility, context: context, height: height, textWidth: width),
                  autovalidateMode: AutovalidateMode.always,
                  enabled: !_registerStepFourForm.isLoading ? true : false,
                  enableSuggestions: false,
                  autocorrect: false,
                  obscureText: !_registerStepFourForm.obscurePasswordFieldStepFour,
                  keyboardType: TextInputType.text,
                  controller: _textfieldConfirmPasswordController,
                  inputFormatters: [
                      LengthLimitingTextInputFormatter(25),
                  ],
                  validator: (value) {
                    if(_textfieldConfirmPasswordController.text == _clientForm4.password && _textfieldConfirmPasswordController.text.length > 8){
                      return null;
                    }
                    return 'Las contraseñas no coinciden';
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  style: TextStyle(fontSize: _textWidth),
                  decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Teléfono', prefixIcon: Icons.phone, height: height, textWidth: width),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  enabled: !_registerStepFourForm.isLoading ? true : false,
                  autocorrect: false,
                  keyboardType: TextInputType.phone,
                  initialValue: _clientForm4.phone,
                  inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.allow(RegexHelper.phone)
                  ],
                  onChanged: (value) => _clientForm4.phone = value,
                  validator: (value) {
                    return value!.length > 9 ? null : 'Ingrese el número a 10 digitos';
                  },
                ),
              ],
            ),
            Expanded(child: Container()),
            Column(
              children: [
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    disabledColor: Colors.grey,
                    color: Color.fromRGBO(51, 114, 134, 1),
                    elevation: 0,
                    child: Text(
                      _clientsService.isSaving ? 'Cargando...' : 'Aceptar', 
                      style: TextStyle(
                        color: Colors.white
                      )
                    ),
                    onPressed: _clientsService.isSaving ? null : () async {
                      FocusScope.of(context).unfocus(); //Linea para ocultar el teclado
                      if(!_registerStepFourForm.isValidFormStepFour()) return;
                      final responseConfirmDialog = await _showConfirmDialog(context, _clientForm4);
                      if(responseConfirmDialog == 200){
                        final responseIdNewClient = await _clientsService.createClient(_clientForm4);
                        if(responseIdNewClient != null){
                          _clientForm4.id = responseIdNewClient;
                          //Navigator; Remueve todo el stack de rutas y hace push a la nueva ruta de verificacion
                          //Esto para que en caso de que desde esa nueva ruta quiera retornar para atras, lo mandará directamente al login
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PhoneVerification(currentClient: _clientForm4, inRgisterOrLogedIn: 'register',)), ModalRoute.withName('login'));
                          _registerStepFourForm.client = ClientModel.cleanClient(); //Limpia instancia cliente
                          _clientsService.cleanFileImages(); //Resetea variables de archivos multimedia del cliente
                          print('YAYAYAYAYAYTERMINDO');
                        }
                      }
                    },
                  ),
                )
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

  Future<int> _showConfirmDialog(BuildContext context, ClientModel client) async {
    final _clientService = Provider.of<ClientsService>(context, listen: false);
    final _selected = await Navigator.of(context).push(new MaterialPageRoute<String>(
      fullscreenDialog: true,
      builder: (BuildContext context) {
        return new Scaffold(
          appBar: new AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: Icon(Icons.clear_rounded),
                onPressed: () {
                  Navigator.of(context).pop();
                }
              ),
            ],
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 15),
                            Text('¿Registrar con la información ingresada?', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.043, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                            SizedBox(height: 20),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              elevation: 9,
                              child: Padding(
                                padding: const EdgeInsets.all(17.0),
                                child: Table(
                                  columnWidths: {
                                    0: FlexColumnWidth(3),
                                    1: FlexColumnWidth(4)
                                  },     
                                  children: [
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('Nombre', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('${client.name}', textAlign: TextAlign.end, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        )
                                      ]
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('Apellidos', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('${client.lastName}', textAlign: TextAlign.end, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        )
                                      ]
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('Fecha de nacimiento', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('${client.birthDate.toString().substring(0,10)}', textAlign: TextAlign.end, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        )
                                      ]
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('Genero', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('${client.gender}', textAlign: TextAlign.end, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        )
                                      ]
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('Estado civil', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('${client.civilStatus}', textAlign: TextAlign.end, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        )
                                      ]
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('Domicilio', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('${client.address}, ${_clientService.currentStringCompleteAddress}', textAlign: TextAlign.end, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        )
                                      ]
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('CURP', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('${client.curp}', textAlign: TextAlign.end, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        )
                                      ]
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('Cargo', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('${_clientService.currentStringJob}', textAlign: TextAlign.end, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        )
                                      ]
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('Rango salarial mensual', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('${_clientService.currentStringSalary}', textAlign: TextAlign.end, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        )
                                      ]
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('RFC', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('${client.rfc}', textAlign: TextAlign.end, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        )
                                      ]
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('Nombre Referencia #1', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('${client.firstReferencePersonName}', textAlign: TextAlign.end, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        )
                                      ]
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('Teléfono Referencia #1', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('${client.firstReferencePersonPhone}', textAlign: TextAlign.end, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        )
                                      ]
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('Nombre Referencia #2', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('${client.secondReferencePersonName}', textAlign: TextAlign.end, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        )
                                      ]
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('Teléfono Referencia #2', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('${client.secondReferencePersonPhone}', textAlign: TextAlign.end, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        )
                                      ]
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('Telefono', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('${client.phone}', textAlign: TextAlign.end, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        )
                                      ]
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('Email', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 2),
                                          child: Text('${client.email}', textAlign: TextAlign.end, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037)),
                                        )
                                      ]
                                    )
                                  ],
                                ),
                              ),
                            )
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
                                  'REGISTRAR',
                                  style: TextStyle(
                                    color: Colors.white
                                  )
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop('Registrar');
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        );
      }
    ));
    if(_selected != null){
      return 200;
    }
    else{
      return 400;
    }
  }


}

