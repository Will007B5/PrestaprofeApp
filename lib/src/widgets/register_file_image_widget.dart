import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';
import 'package:path/path.dart' as fileextension;
import 'package:prestaprofe/src/providers/providers.dart';
import 'package:provider/provider.dart';

import 'package:prestaprofe/src/helpers/helpers.dart';
import 'package:prestaprofe/src/services/services.dart';
class RegisterFileImage extends StatelessWidget {

  final String imageType; //Recibe un parametro que es el tipo de imagen (ine, ineBack, selfie, proofAddress, payStub)

  const RegisterFileImage({
    Key? key, 
    required this.imageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _mediaQuerySize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        height: _mediaQuerySize.height * 0.6,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: _constructImage(context),
        ),
      ),
    );
  }

  //Widget que construye el card de imágen de acuerdo a la opcion cargada
  Widget _constructImage(BuildContext context) {

    final _registerForm = Provider.of<RegisterFormProvider>(context);

    switch(this.imageType){
      case 'ine':
        if(_registerForm.client.ine! == ''){
          return Image(
            image: AssetImage('assets/no_image.png'),
            fit: BoxFit.cover,
          );
        }
        else if(_registerForm.client.ine!.startsWith('http')) {
          return FadeInImage(
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(_registerForm.client.ine!),
            fit: BoxFit.cover,
          );
        }
        else if(fileextension.extension(_registerForm.client.ine!) == '.pdf') {
          return FutureBuilder(
            future: PdfHelper.loadPreviewFromFile(path: _registerForm.client.ine!),
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Image(
                  image: AssetImage('assets/no_image.png'),
                  fit: BoxFit.cover,
                );
              }
              return Image.memory(snapshot.data as Uint8List);
            },
          );
        }
        else{
          return Image.file(
            File(_registerForm.client.ine!),
            fit: BoxFit.cover
          );
        }
      case 'ineBack':
        if(_registerForm.client.ineBack == ''){
          return Image(
            image: AssetImage('assets/no_image.png'),
            fit: BoxFit.cover,
          );
        }
        else if(_registerForm.client.ineBack!.startsWith('http')) {
          return FadeInImage(
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(_registerForm.client.ineBack!),
            fit: BoxFit.cover,
          );
        }
        else if(fileextension.extension(_registerForm.client.ineBack!) == '.pdf') {
          return FutureBuilder(
            future: PdfHelper.loadPreviewFromFile(path: _registerForm.client.ineBack!),
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Image(
                  image: AssetImage('assets/no_image.png'),
                  fit: BoxFit.cover,
                );
              }
              return Image.memory(snapshot.data as Uint8List);
            },
          );
        }
        else{
          return Image.file(
            File(_registerForm.client.ineBack!),
            fit: BoxFit.cover
          );
        }
      case 'selfie':
        if(_registerForm.client.selfie == ''){
          return Image(
            image: AssetImage('assets/no_image.png'),
            fit: BoxFit.cover,
          );
        }
        else if(_registerForm.client.selfie!.startsWith('http')) {
          return FadeInImage(
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(_registerForm.client.selfie!),
            fit: BoxFit.cover,
          );
        }
        else{
          return Image.file(
            File(_registerForm.client.selfie!),
            fit: BoxFit.cover
          );
        }
      case 'proofAddress':
        if(_registerForm.client.proofAddress == ''){
          return Image(
            image: AssetImage('assets/no_image.png'),
            fit: BoxFit.cover,
          );
        }
        else if(_registerForm.client.proofAddress!.startsWith('http')) {
          return FadeInImage(
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(_registerForm.client.proofAddress!),
            fit: BoxFit.cover,
          );
        }
        else if(fileextension.extension(_registerForm.client.proofAddress!) == '.pdf') {
          return FutureBuilder(
            future: PdfHelper.loadPreviewFromFile(path: _registerForm.client.proofAddress!),
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Image(
                  image: AssetImage('assets/no_image.png'),
                  fit: BoxFit.cover,
                );
              }
              return Image.memory(snapshot.data as Uint8List);
            },
          );
        }
        else{
          return Image.file(
            File(_registerForm.client.proofAddress!),
            fit: BoxFit.cover
          );
        }
      case 'payStub':
        if(_registerForm.client.payStub == ''){
          return Image(
            image: AssetImage('assets/no_image.png'),
            fit: BoxFit.cover,
          );
        }
        else if(_registerForm.client.payStub!.startsWith('http')) {
          return FadeInImage(
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(_registerForm.client.payStub!),
            fit: BoxFit.cover,
          );
        }
        else if(fileextension.extension(_registerForm.client.payStub!) == '.pdf') {
          return FutureBuilder(
            future: PdfHelper.loadPreviewFromFile(path: _registerForm.client.payStub!),
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Image(
                  image: AssetImage('assets/no_image.png'),
                  fit: BoxFit.cover,
                );
              }
              return Image.memory(snapshot.data as Uint8List);
            },
          );
        }
        else{
          return Image.file(
            File(_registerForm.client.payStub!),
            fit: BoxFit.cover
          );
        }
      default:
        return Container();
    }
  }

  //Decoration que añade un borde y sombra a la card de imágen
  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: Offset(0,5)
        )
      ]
    );
  } 
}