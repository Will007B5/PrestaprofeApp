import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:prestaprofe/src/helpers/helpers.dart';
import 'package:prestaprofe/src/providers/providers.dart';
import 'package:prestaprofe/src/services/services.dart';
import 'package:prestaprofe/src/ui/custom_uis.dart';
class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size;

    return SafeArea(
      top: false,
      child: Scaffold(
        //Crea una instancia de LoginFormProvider
        //Y solo todo este (ChangeNotifierProvider) va a vivir en este scope (login_page.dart)
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: PrestaprofeTheme.prestaprofeTheme().colorScheme.primary,
          // color: Colors.white,
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: ChangeNotifierProvider(
                  create: ( _ ) => LoginFormProvider(),
                  builder: (context, _) {
                    return _constructLoginBody(_mediaQuerySize, context);
                  },
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _constructLoginBody(Size _mediaQuerySize, BuildContext context) {

    final _loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: _mediaQuerySize.height * 0.355,
            child: Image(
              image: AssetImage('assets/bussines.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: _mediaQuerySize.height * 0.18,
            child: Image(
              image: AssetImage('assets/prestaprofelogowh.png'),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 25),

          _LoginForm(),
          
          Expanded(child: Container()), //Para agregar este expanden (sobre todo en elementos Scroll, es necesario que sea Container(aqui se insertan medidas)->Column->Expanded->Container)
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              //SelectableText('TOKEN: ${PushNotificationService.token}'),
              Container(
                height: 82,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 1,
                      child: TextButton(
                          style: PrestaprofeButtonsStyle.loginUnderlineButtons(fontSize: _mediaQuerySize.width * 0.043), //Estilo custom de archivo buttons_style.dart
                          child: Text('¿Aún no estás registrado?', style: TextStyle(color: PrestaprofeTheme.loginUnderlineButtonsColor)),
                          onPressed: !_loginForm.isLoading ? (){
                            Navigator.pushNamed(context, 'registerStepOne');
                          } : null,
                      ),
                    ),
                    TextButton(
                        style: PrestaprofeButtonsStyle.loginUnderlineButtons(fontSize: _mediaQuerySize.width * 0.043), //Estilo custom de archivo buttons_style.dart
                        child: Text('¿Olvidaste tu contraseña?', style: TextStyle(color: PrestaprofeTheme.loginUnderlineButtonsColor)),
                        onPressed: !_loginForm.isLoading ? (){

                        } : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 3)
        ],
      ),
    );
  }
}
class _LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final _loginForm = Provider.of<LoginFormProvider>(context);
    final _clientsService = Provider.of<ClientsService>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Form(
        key: _loginForm.formKey,
        child: Column(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              enabled: !_loginForm.isLoading ? true : false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(hintText: 'ejemplo@dominio.com', labelText: 'Correo electrónico', prefixIcon: Icons.alternate_email_sharp), //Utilizando metodo estatico de clase InputDecorations creada por mi (lib/src/ui/input_decorations.dart),
              onChanged: (value) => _loginForm.email = value,
              validator: (value) {
                return RegexHelper.email.hasMatch(value ?? '') ? null : 'Ingrese un correo válido';
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              autovalidateMode: AutovalidateMode.disabled,
              enabled: !_loginForm.isLoading ? true : false,
              enableSuggestions: false,
              autocorrect: false,
              obscureText: !_loginForm.obscurePasswordField,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(hintText: '', labelText: 'Contraseña', prefixIcon: Icons.lock_outline, suffixIcon: _loginForm.obscurePasswordField ? Icons.visibility_off : Icons.visibility, context: context), //Utilizando metodo estatico de clase InputDecorations creada por mi (lib/src/ui/input_decorations.dart)
              onChanged: (value) => _loginForm.password = value,
              validator: (value) {
                if(value != null && value.length > 0){
                  return null;
                }
                return 'Ingrese la contraseña';
              },
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                disabledColor: PrestaprofeTheme.loginButtonDisabledColor,
                color: PrestaprofeTheme.loginButtonFillColor,
                elevation: 0,
                child: Text(
                  _loginForm.isLoading ? 'Ingresando...' : 'Iniciar sesión', 
                  style: TextStyle(
                    color: PrestaprofeTheme.loginButtonTextColor
                  )
                ),
                onPressed: _loginForm.isLoading ? null : () async {
                  FocusScope.of(context).unfocus(); //Linea para ocultar el teclado
                  final _authService = Provider.of<AuthService>(context, listen: false);
                  if(!_loginForm.isValidForm()) return;
                  _loginForm.isLoading = true;
                  final String? errorMessage = await _authService.login(_loginForm.email, _loginForm.password);
                  if(errorMessage == null){
                    _clientsService.currentClient = _authService.currentClient;
                    //Inicia sesion
                    Navigator.pushReplacementNamed(context, 'home'); //pushReplacementNamed borra el stack de rutas para que ya no se pueda regresar
                  }
                  else{
                    //Manda errores
                    NotificationsService.showSnackbar(errorMessage, 'error');
                    _loginForm.isLoading = false;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}