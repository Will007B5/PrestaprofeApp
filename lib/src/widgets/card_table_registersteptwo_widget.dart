import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:prestaprofe/src/ui/input_decorations.dart';
import 'package:prestaprofe/src/utils/icons_string_util.dart';
import 'package:prestaprofe/src/widgets/widgets.dart';

class CardTableRegisterStepTwo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          children: [
            GestureDetector(
              child: _SingleCard(text: '#1'),
              onTap: (){
                _showReferencesDialog(context, 'REFERENCIA #1');
              },
            ),
            GestureDetector(
              child: _SingleCard(text: '#2'),
              onTap: (){
                _showReferencesDialog(context, 'REFERENCIA #2');
              },
            )
          ]
        )
      ],
    );
  }

  _showReferencesDialog(BuildContext context, titleAppBar){
    showGeneralDialog(
      context: context,
      transitionDuration: Duration(milliseconds: 250),
      pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          appBar: AppBar(
            title: Text(titleAppBar, style: TextStyle(fontSize: 22.5, fontWeight: FontWeight.bold)),
            automaticallyImplyLeading: false,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(), 
                icon: Icon(Icons.close)
              )
            ],
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            child: _bodyFormReferencesDialog()
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.person_add_alt_rounded, color: Colors.white),
            backgroundColor: Color.fromRGBO(51, 114, 134, 1),
            elevation: 0,
            onPressed: null,
          )
        );
      },
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.white
    );
  }

  Widget _bodyFormReferencesDialog() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          SizedBox(height: 15),
          Form(
            child: Column(
              children: [
                Container(
                  decoration: _inputBorderBoxDecoration(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: TextFormField(
                      decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Nombre(s)', prefixIcon: Icons.account_circle_rounded),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: _inputBorderBoxDecoration(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: TextFormField(
                      decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Apellido(s)', prefixIcon: Icons.account_circle_rounded),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: _inputBorderBoxDecoration(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: TextFormField(
                      decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Teléfono', prefixIcon: Icons.phone_rounded),
                    ),
                  ),
                )
                // Container(
                //   width: double.infinity,
                //   child: MaterialButton(
                //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                //     disabledColor: Colors.grey,
                //     color: Color.fromRGBO(51, 114, 134, 1),
                //     elevation: 0,
                //     child: Text(
                //       'Contactos', 
                //       style: TextStyle(
                //         color: Colors.white
                //       )
                //     ),
                //     onPressed: (){
                //     },
                //   ),
                // )
              ]
            ),
          ),
        ],
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

class _SingleCard extends StatelessWidget {

  final String text;

  const _SingleCard({
    Key? key, 
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _CardBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 9),
                child: Icon(Icons.check_circle_sharp, color: Colors.green[600]),
              ),
            ],
          ),
          CircleAvatar(
            backgroundColor: Color.fromRGBO(51, 114, 134, 1),
            child: Icon(Icons.contact_page_rounded, size: 35, color: Colors.white),
            radius: 35,
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              children: [
                Text('REFERENCIA', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                Text(this.text, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
              ],
            ),
          )
        ],
      ) 
    );
  }
}

class _CardBackground extends StatelessWidget {

  final Widget child;

  const _CardBackground({
    Key? key, 
    required this.child
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            height: 165,
            decoration: BoxDecoration(
              color: Color.fromRGBO(51, 114, 134, 0.53),
              borderRadius: BorderRadius.circular(20)
            ),
            child: this.child,
          ),
        ),
      ),
    );
  }
}