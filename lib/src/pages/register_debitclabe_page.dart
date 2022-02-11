import 'package:flutter/material.dart';

import 'package:prestaprofe/src/ui/input_decorations.dart';

class RegisterDebitClabe extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size;
    final _height = _mediaQuerySize.height;
    final _width = _mediaQuerySize.width;
    final _objectSize = _height * _width;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Container()),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: _objectSize * 0.00038,
                          backgroundColor: Color.fromRGBO(51, 114, 134, 1),
                          child: CircleAvatar(
                            backgroundColor: Color.fromRGBO(51, 114, 134, 1),
                            radius:  _objectSize * 0.00036,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(130),
                              child: Image(
                                image: AssetImage('assets/creditcard.png'),
                                fit: BoxFit.fill,
                              ),
                            )
                          ),
                        ),
                        SizedBox(height: 15),
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          color: Color.fromRGBO(255, 255, 255, 0.94),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 35, horizontal: 15),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 1), 
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Color.fromRGBO(51, 114, 134, 1),
                                width: 2,
                              )
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('AGREGUE SU NÚMERO DE TARJETA O CLABE INTERBANCARIA', style: TextStyle(fontWeight: FontWeight.bold, fontSize: _width * 0.037, color: Color.fromRGBO(51, 114, 134, 1)), textAlign: TextAlign.center),
                                SizedBox(height: 25),
                                Container(
                                  decoration: _inputBorderBoxDecoration(),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: TextFormField(
                                      style: TextStyle(fontSize: _width * 0.04),
                                      decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'No. Tarjeta o CLABE', prefixIcon: Icons.account_circle_rounded, height: _height, textWidth: _width),
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      //enabled: !registerStepOneForm.isLoadingStepOne ? true : false,
                                      autocorrect: false,
                                      keyboardType: TextInputType.number,
                                      initialValue: '',
                                      onChanged: null,
                                      // validator: (value) {
                                      //   String pattern = r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$";
                                      //   RegExp regExp  = new RegExp(pattern);
                                      //   return regExp.hasMatch(value ?? '') ? null : 'Solo se permiten letras';
                                      // },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('Agregar en otro momento', style: TextStyle(fontWeight: FontWeight.bold, fontSize: _width * 0.035, color: Colors.red[400]), textAlign: TextAlign.center),
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
                              'Aceptar', 
                              style: TextStyle(
                                color: Colors.white
                              )
                            ),
                            onPressed: (){
                              
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
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