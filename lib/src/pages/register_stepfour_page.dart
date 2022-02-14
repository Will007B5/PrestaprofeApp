import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prestaprofe/src/services/clients_service.dart';
import 'package:prestaprofe/src/services/services.dart';
import 'package:provider/provider.dart';

import 'package:prestaprofe/src/providers/providers.dart';

import 'package:prestaprofe/src/ui/input_decorations.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';

class StepFour extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size;
    final _height = _mediaQuerySize.height;
    final _width = _mediaQuerySize.width;
    final _circleMeassure = _mediaQuerySize.height * _mediaQuerySize.width;
    final _mediaQuerySizeFixedHeightCircles = (_circleMeassure * 0.000155);
    final _textInfoWidth = _width * 0.055;
    
    return Scaffold(
      appBar: AppBarRegister(textStep: 'INFORMACIÓN DE SESIÓN', mediaQuerySizeFixedHeightCircles: _mediaQuerySizeFixedHeightCircles, textWidth: _textInfoWidth),
      body: Container(
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
      )
    );
  }

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
            !_clientsService.savedClient ? Column(
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
                    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regExp  = new RegExp(pattern);
                    return regExp.hasMatch(value ?? '') ? null : 'Ingrese un correo válido';
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  style: TextStyle(fontSize: _textWidth),
                  decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Contraseña', prefixIcon: Icons.account_circle_rounded, height: height, textWidth: width),
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
                  decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Teléfono', prefixIcon: Icons.phone, height: height, textWidth: width),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  enabled: !_registerStepFourForm.isLoading ? true : false,
                  autocorrect: false,
                  keyboardType: TextInputType.phone,
                  initialValue: _clientForm4.phone,
                  inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.allow(RegExp(r'^[0-9]{0,10}'))
                  ],
                  onChanged: (value) => _clientForm4.phone = value,
                  validator: (value) {
                    return value!.length > 9 ? null : 'Ingrese el número a 10 digitos';
                  },
                ),
              ],
            ) : Container(),
            _clientsService.savedClient ? 
            Column(
              children: [
                SizedBox(height: 10),
                PhoneVerification(),
              ],
            ) : Container(),
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
                      if(!_clientsService.savedClient){
                        if(!_registerStepFourForm.isValidFormStepFour()) return;
                        final response = await _clientsService.createClient(_clientsService.currentClient);
                        if(response == 200){
                          _clientsService.isSaving = false;
                          _clientsService.savedClient = true;
                        }
                        if(response == 400){
                          _clientsService.isSaving = false;
                        }
                      }
                      else{
                        _clientsService.isSaving = true;
                        final response = await _clientsService.verifyCliet(_clientsService.currentClient);
                        _clientsService.isSaving = false;
                        if(response == 200){
                          Navigator.of(context).pushNamedAndRemoveUntil('login', (Route<dynamic> route) => false);
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

}

