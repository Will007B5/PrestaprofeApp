import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prestaprofe/src/helpers/helpers.dart';
import 'package:provider/provider.dart';
import 'package:contacts_service/contacts_service.dart'; 

import 'package:prestaprofe/src/providers/providers.dart';
import 'package:prestaprofe/src/ui/input_decorations.dart';

class CardTableRegisterStepTwo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _registerStepTwoRefsForm = Provider.of<RegisterFormProvider>(context);
    return Table(
      children: [
        TableRow(
          children: [
            GestureDetector(
              child: _SingleCard(text: '#1'),
              onTap: (){
                //_registerStepTwoRefsForm.isFormReferences1Active = true;
                //_showReferencesDialog(context, 'REFERENCIA #1');
              },
            ),
            GestureDetector(
              child: _SingleCard(text: '#2'),
              onTap: (){
                //_registerStepTwoRefsForm.isFormReferences2Active = true;
                //_showReferencesDialog(context, 'REFERENCIA #2');
              },
            )
          ]
        )
      ],
    );
  }

  _showReferencesDialog(BuildContext context, String titleAppBar){

    final _mediaQuerySize = MediaQuery.of(context).size;
    final _textWidth = _mediaQuerySize.width * 0.055;

    showGeneralDialog(
      context: context,
      transitionDuration: Duration(milliseconds: 250),
      pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          appBar: AppBar(
            title: Text(titleAppBar, style: TextStyle(fontSize: _textWidth, fontWeight: FontWeight.bold)),
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
            child: _bodyFormReferencesDialog(context, titleAppBar)
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.import_contacts_rounded, color: Colors.white),
            backgroundColor: Color.fromRGBO(51, 114, 134, 1),
            elevation: 0,
            onPressed: () async {
              final response = await PermissionsHelper.requestForPermission(permissionType: 'contacts');
              if(response == 200){
                List<Contact> contacts = await ContactsService.getContacts();  
                print(contacts[0].phones![0].value);
              }
            },
          )
        );
      },
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.white
    );
  }

  Widget _bodyFormReferencesDialog(BuildContext context, String reference) {

    final _mediaQuerySize = MediaQuery.of(context).size;
    final _height = _mediaQuerySize.height;
    final _width = _mediaQuerySize.width;

    final _textWidth = _width * 0.035;

    final _registerStepTwoRefsForm = Provider.of<RegisterFormProvider>(context);
    final _clientRefsForm2 = _registerStepTwoRefsForm.client;
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          SizedBox(height: 15),
          Form(
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(fontSize: _textWidth),
                  decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Nombre completo', prefixIcon: Icons.account_circle_rounded, height: _height, textWidth: _width),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  //enabled: !registerStepOneForm.isLoadingStepOne ? true : false,
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  initialValue: (reference == 'REFERENCIA #1') ? _clientRefsForm2.firstReferencePersonName : _clientRefsForm2.secondReferencePersonName,
                  onChanged: (value) {
                    if(reference == 'REFERENCIA #1'){
                      _clientRefsForm2.firstReferencePersonName = value;
                    }
                    else if(reference == 'REFERENCIA #2'){
                      _clientRefsForm2.secondReferencePersonName = value;
                    }
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
                  decoration: InputDecorations.registerInputDecoration(hintText: '', labelText: 'Teléfono', prefixIcon: Icons.phone_rounded, height: _height, textWidth: _width),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  //enabled: !registerStepOneForm.isLoadingStepOne ? true : false,
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  initialValue: (reference == 'REFERENCIA #1') ? _clientRefsForm2.firstReferencePersonPhone : _clientRefsForm2.secondReferencePersonPhone,
                  onChanged: (value) {
                    if(reference == 'REFERENCIA #1'){
                      _clientRefsForm2.firstReferencePersonPhone = value;
                    }
                    else if(reference == 'REFERENCIA #2'){
                      _clientRefsForm2.secondReferencePersonPhone = value;
                    }
                  }
                )
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

    final _mediaQuerySize = MediaQuery.of(context).size;
    final _height = _mediaQuerySize.height;
    final _width = _mediaQuerySize.width;

    final _textWidth = _width * 0.037;
    final _sizeObjects = _height * _width;

    return _CardBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     Padding(
          //       padding: EdgeInsets.only(right: 9),
          //       child: Icon(Icons.check_circle_sharp, color: Colors.green[600], size: _sizeObjects * 0.000095),
          //     ),
          //   ],
          // ),
          CircleAvatar(
            backgroundColor: Color.fromRGBO(51, 114, 134, 1),
            child: Icon(Icons.contact_page_rounded, size: _sizeObjects * 0.000127, color: Colors.white),
            radius: _sizeObjects * 0.00013,
          ),
          SizedBox(height: 17),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              children: [
                Text('REFERENCIA', style: TextStyle(color: Colors.white, fontSize: _textWidth, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                Text(this.text, style: TextStyle(color: Colors.white, fontSize: _textWidth, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
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
    
    final _mediaQuerySize = MediaQuery.of(context).size;
    final _height = _mediaQuerySize.height;

    return Container(
      margin: EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            height: _height * 0.228,
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