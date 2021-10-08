import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage>{

  String _email = '';
  String _password = '';
  bool _showPassword = false;

  //191, 155, 48
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromRGBO(51, 114, 134, 1),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    child: Image(
                      image: AssetImage('assets/bussines.jpg'),
                      fit: BoxFit.cover,
                    ),
                    width: double.infinity,
                    height: size.height * 0.28,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 6.0),
                  ),
                  Image(
                      image: AssetImage('assets/prestaprofelogowh.png'),
                      height: size.height * 0.21,
                      fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0),
                    child: _widgetEmail()
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0),
                    child: _widgetPassword()
                  ),
                  Column(
                    children: <Widget>[
                      TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(Color.fromRGBO(255, 255, 255, 0.8)),
                            textStyle: MaterialStateProperty.all(TextStyle(
                              decoration: TextDecoration.underline,
                            ))
                          ),
                          child: Text('¿Olvidaste tu contraseña?'),
                          onPressed: (){},
                      ),
                      TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(Color.fromRGBO(255, 255, 255, 0.8)),
                            textStyle: MaterialStateProperty.all(TextStyle(
                              decoration: TextDecoration.underline,
                            ))
                          ),
                          child: Text('¿Aún no estás registrado?'),
                          onPressed: (){
                            Navigator.pushNamed(context, 'registerStepOne');
                          },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    child: Text(
                      'Iniciar sesión', 
                      style: TextStyle(
                        color: Color.fromRGBO(27, 60, 70, 1)
                      )
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(191, 155, 48, 1),
                    ),
                    onPressed: (){
                      _sendData(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 13.0),
                  ),
                ],
              )
            ]
          ),
        ),
      )
    );
  }

  Widget _widgetEmail(){
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0)
        ),
        hintText: 'Email',
      ),
      onChanged: (value){
        _email = value;
      },
    );
  }

  Widget _widgetPassword(){
    return TextField(
      autocorrect: false,
      obscureText: !_showPassword,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0)
        ),
        hintText: 'Contraseña',
        suffixIcon: IconButton(
          onPressed: (){
            setState(() {
              _showPassword = !_showPassword;
            });
          },
          icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
        ),
      ),
      onChanged: (value){
        _password = value;
      },
    );
  }

  void _sendData(BuildContext context){
    // showDialog(
    //   context: context,
    //   barrierDismissible: true,
    //   builder: (context){
    //     return AlertDialog(
    //       content: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: <Widget>[
    //           Text('$_email'),
    //           Text('$_password')
    //         ],
    //       ),
    //     );
    //   }
    // );
    Navigator.pushNamed(context, 'home');
  }
}