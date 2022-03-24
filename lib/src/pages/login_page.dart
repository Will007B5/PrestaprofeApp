import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:prestaprofe/src/helpers/helpers.dart';
import 'package:prestaprofe/src/models/models.dart';
import 'package:prestaprofe/src/providers/providers.dart';
import 'package:prestaprofe/src/services/services.dart';
import 'package:prestaprofe/src/ui/input_decorations.dart';

class LoginPage extends StatelessWidget {

  static ButtonStyle _textButtonsStyle = ButtonStyle(
    overlayColor: MaterialStateProperty.all(Color.fromRGBO(51, 114, 134, 0.2)),
    shape: MaterialStateProperty.all(StadiumBorder()),
    foregroundColor: MaterialStateProperty.all(Color.fromRGBO(255, 255, 255, 0.8)),
    textStyle: MaterialStateProperty.all(TextStyle(
      decoration: TextDecoration.underline,
      fontSize: 16
    ))
  );

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
          color: Color.fromRGBO(51, 114, 134, 1),
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
    final _clientsService = Provider.of<ClientsService>(context);
    final _registerFormProvider = Provider.of<RegisterFormProvider>(context);
    final loginForm = Provider.of<LoginFormProvider>(context);
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
                          style: _textButtonsStyle,
                          child: Text('¿Aún no estás registrado?'),
                          onPressed: !loginForm.isLoading ? (){
                            Navigator.pushNamed(context, 'registerStepOne');
                          } : null,
                      ),
                    ),
                    TextButton(
                        style: _textButtonsStyle,
                        child: Text('¿Olvidaste tu contraseña?'),
                        onPressed: !loginForm.isLoading ? (){

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
    
    final loginForm = Provider.of<LoginFormProvider>(context);
    final _clientsService = Provider.of<ClientsService>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Form(
        key: loginForm.formKey,
        child: Column(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              enabled: !loginForm.isLoading ? true : false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(hintText: 'ejemplo@dominio.com', labelText: 'Correo electrónico', prefixIcon: Icons.alternate_email_sharp), //Utilizando metodo estatico de clase InputDecorations creada por mi (lib/src/ui/input_decorations.dart),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                return RegexHelper.email.hasMatch(value ?? '') ? null : 'Ingrese un correo válido';
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              autovalidateMode: AutovalidateMode.disabled,
              enabled: !loginForm.isLoading ? true : false,
              enableSuggestions: false,
              autocorrect: false,
              obscureText: !loginForm.obscurePasswordField,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(hintText: '', labelText: 'Contraseña', prefixIcon: Icons.lock_outline, suffixIcon: loginForm.obscurePasswordField ? Icons.visibility_off : Icons.visibility, context: context), //Utilizando metodo estatico de clase InputDecorations creada por mi (lib/src/ui/input_decorations.dart)
              onChanged: (value) => loginForm.password = value,
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
                disabledColor: Colors.grey,
                color: Color.fromRGBO(191, 155, 48, 1),
                elevation: 0,
                child: Text(
                  loginForm.isLoading ? 'Ingresando...' : 'Iniciar sesión', 
                  style: TextStyle(
                    color: Color.fromRGBO(27, 60, 70, 1)
                  )
                ),
                onPressed: loginForm.isLoading ? null : () async {
                  FocusScope.of(context).unfocus(); //Linea para ocultar el teclado
                  final authService = Provider.of<AuthService>(context, listen: false);
                  if(!loginForm.isValidForm()) return;
                  loginForm.isLoading = true;
                  final String? errorMessage = await authService.login(loginForm.email, loginForm.password);
                  if(errorMessage == null){
                    _clientsService.currentClient = authService.currentClient;
                    //Inicia sesion
                    Navigator.pushReplacementNamed(context, 'home'); //pushReplacementNamed borra el stack de rutas para que ya no se pueda regresar
                  }
                  else{
                    //Manda errores
                    NotificationsService.showSnackbar(errorMessage, 'error');
                    loginForm.isLoading = false;
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