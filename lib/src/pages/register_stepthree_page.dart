import 'package:flutter/material.dart';

import 'package:prestaprofe/src/providers/json_menuoptions_provider.dart';
import 'package:prestaprofe/src/ui/input_decorations.dart';
import 'package:prestaprofe/src/utils/icons_string_util.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';

class StepThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size;
    final _mediaQuerySizeFixedHeightCircles = ((_mediaQuerySize.height - MediaQuery.of(context).padding.top - kToolbarHeight) *0.067);

    return Scaffold(
      appBar: AppBarRegister(mediaQuerySizeFixedHeightCircles: _mediaQuerySizeFixedHeightCircles),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        height: double.infinity,
        width: double.infinity,
        color: Color.fromRGBO(191, 155, 48, 0.91),
        child: SingleChildScrollView(
          child: _constructRegisterBody(context, _mediaQuerySize),
        ),
      ),
    );
  }

  Widget _constructRegisterBody(BuildContext context, Size _mediaQuerySize) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 10),
          Text('Verificación',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text('Ingresa el código',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black38
            ),
          ),
          SizedBox(height: _mediaQuerySize.height * 0.115),
          Container(
            decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.88), borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                SizedBox(height: 35),
                TextFormField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefix: Padding(
                      padding: EdgeInsets.symmetric(horizontal:8),
                      child: Text('(+52)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    suffixIcon: Icon(Icons.check_circle, color:Colors.green, size: 32)
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    disabledColor: Colors.grey,
                    color: Color.fromRGBO(51, 114, 134, 1),
                    elevation: 0,
                    child: Text(
                      'Registrar', 
                      style: TextStyle(
                        color: Colors.white
                      )
                    ),
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, 'login');
                    },
                  ),
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.88), borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _textFieldOTP(context, first: true, last: false),
                    _textFieldOTP(context, first: false, last: false),
                    _textFieldOTP(context, first: false, last: false),
                    _textFieldOTP(context, first: false, last: true)
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    disabledColor: Colors.grey,
                    color: Color.fromRGBO(51, 114, 134, 1),
                    elevation: 0,
                    child: Text(
                      'Verificar', 
                      style: TextStyle(
                        color: Colors.white
                      )
                    ),
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, 'login');
                    },
                  ),
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
          SizedBox(height: 21),
          Text('¿Aún no recibes el código?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black38
            ),
          ),
           SizedBox(height: 15),
          Text('Reenviar nuevo código',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(51, 114, 134, 1),
            ),
          ),
        ],
      ),
    );
  }

  _textFieldOTP(BuildContext context, {required bool first, required bool last}){
    return Container(
      height: 85,
      child: AspectRatio(
        aspectRatio: 0.7,
        child: TextField(
          autofocus: true,
          onChanged: (value){
            if(value.length == 1 && last == false){
              FocusScope.of(context).nextFocus();
            }
            if(value.length == 0 && first == false){
              FocusScope.of(context).previousFocus();
            }
          },
          cursorColor: Color.fromRGBO(51, 114, 134, 1),
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black12),
              borderRadius: BorderRadius.circular(12)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Color.fromRGBO(51, 114, 134, 1)),
              borderRadius: BorderRadius.circular(12)
            )
          ),
        ),
      ),
    );
  }

}