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
                      final response = await _clientsService.createClient(_clientsService.currentClient);
                      if(response == 200){
                        //Navigator; Remueve todo el stack de rutas y hace push a la nueva ruta de verificacion
                        //Esto para que en caso de que desde esa nueva ruta quiera retornar para atras, lo mandará directamente al login
                        _registerStepFourForm.client = ClientModel.cleanClient(); //Limpia instancia cliente
                        _clientsService.cleanFileImages(); //Resetea variables de archivos multimedia del cliente
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PhoneVerification(currentClient: _clientsService.currentClient, inRgisterOrLogedIn: 'register',)), ModalRoute.withName('login'));
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

